<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Schema;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Carrito; 
use Exception;

class ApiClienteController extends Controller
{
    /**
     * Retorna las tiendas para la sección de inicio.
     */
public function getTiendas()
{
    try {
        if (!Schema::hasTable('tiendas')) {
            return response()->json(['error' => 'La tabla tiendas no existe en la BD'], 500);
        }

        $tiendas = DB::table('tiendas')
            ->select(
                'ID_tienda',
                'nombre',
                'descripcion',
                'logo',
                'estado',
                'ID_usuario_vendedor',
                'visible',
                'facebook',
                'instagram',
                'whatsapp',
                'tiktok',
                'portada',
                'clabe',
                'banco',
                'titular_cuenta',
                'aprobacion'
            )
            ->where('aprobacion', '=', 'aprobada') 
            ->where('visible', '=', 1)
            ->where('estado', '=', 'activo')
            ->get();

        return response()->json($tiendas, 200);

    } catch (\Exception $e) {
        return response()->json([
            'error' => 'Fallo en el servidor',
            'mensaje' => $e->getMessage()
        ], 500);
    }
}

    /**
     * Retorna los productos destacados (últimos 4 aceptados).
     */
    public function getProductosDestacados()
    {
        try {
            $productos = DB::table('productos')
                ->join('tiendas', 'productos.ID_tienda', '=', 'tiendas.ID_tienda')
                ->join('categorias', 'productos.ID_categoria', '=', 'categorias.ID_categoria')
                ->select(
                    'productos.*',
                    'categorias.nombre as nombre_categoria',
                    'tiendas.nombre as nombre_tienda'
                )
                // Solo productos aceptados por el admin
                ->where('productos.estado', '!=', 'pendiente')
                ->where('productos.visible', '=', 1)
                ->orderBy('productos.ID_producto', 'desc')
                ->limit(4)
                ->get();

            return response()->json($productos, 200);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    /**
     * Catálogo completo con filtros dinámicos.
     */
    public function explorar(Request $request)
    {
        try {
            $query = DB::table('productos')
                ->join('tiendas', 'productos.ID_tienda', '=', 'tiendas.ID_tienda')
                ->join('categorias', 'productos.ID_categoria', '=', 'categorias.ID_categoria')
                ->where('productos.estado', '!=', 'pendiente')
                ->where('productos.visible', '=', 1)
                ->whereIn('tiendas.aprobacion', ['aprobado', 'aprobada', 'Aprobado', 'Aprobada']);

            // Filtros Dinámicos
            if ($request->filled('buscar')) {
                $query->where(function($q) use ($request) {
                    $q->where('productos.nombre', 'like', '%' . $request->buscar . '%')
                      ->orWhere('productos.marca', 'like', '%' . $request->buscar . '%');
                });
            }

            if ($request->filled('categoria')) {
                $query->where('productos.ID_categoria', '=', $request->categoria);
            }

            if ($request->filled('tienda')) {
                $query->where('productos.ID_tienda', '=', $request->tienda);
            }

            $productos = $query->select(
                'productos.ID_producto',
                'productos.nombre',
                'productos.marca',
                'productos.precio',
                'productos.imagen',
                'productos.descripcion',
                'categorias.nombre as nombre_categoria',
                'tiendas.nombre as nombre_tienda'
            )
            ->orderBy('productos.ID_producto', 'desc')
            ->get();

            return response()->json($productos, 200);

        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    /**
     * Retorna categorías y tiendas para llenar los selects del filtro.
     */
    public function getFiltrosData()
    {
        try {
            $categorias = DB::table('categorias')->select('ID_categoria', 'nombre')->get();
            
            $tiendas = DB::table('tiendas')
                ->whereIn('aprobacion', ['aprobado', 'aprobada', 'Aprobado', 'Aprobada'])
                ->where('visible', 1)
                ->select('ID_tienda', 'nombre')
                ->get();

            return response()->json([
                'categorias' => $categorias,
                'tiendas' => $tiendas
            ], 200);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    /**
     * Agrega un producto al carrito del usuario autenticado.
     */
    public function agregarAlCarrito(Request $request)
    {
        try {
            $user = $request->user(); // Usuario obtenido por el Token de Sanctum
            $productoId = $request->input('ID_producto');
            $cantidad = $request->input('cantidad', 1);

            // 1. Buscamos el producto para jalar su ID_tienda
            // Esto permite que el registro en el carrito sepa a qué vendedor pertenece
            $producto = DB::table('productos')
                ->where('ID_producto', $productoId)
                ->first();

            if (!$producto) {
                return response()->json(['message' => 'Producto no encontrado'], 404);
            }

            // 2. Buscamos si ya existe este producto en el carrito del usuario
            $itemExistente = DB::table('carrito')
                ->where('ID_usuario', $user->ID_usuario)
                ->where('ID_producto', $productoId)
                ->first();

            if ($itemExistente) {
                // Si ya existe, incrementamos la cantidad
                DB::table('carrito')
                    ->where('ID_carrito', $itemExistente->ID_carrito)
                    ->increment('cantidad', $cantidad);
                    
                return response()->json(['message' => 'Cantidad actualizada'], 200);
            } else {
                // Si es nuevo, lo insertamos con el ID_tienda del producto
                // Aquí es donde nace la separación por tiendas
                DB::table('carrito')->insert([
                    'ID_usuario'  => $user->ID_usuario,
                    'ID_producto' => $productoId,
                    'ID_tienda'   => $producto->ID_tienda, 
                    'cantidad'    => $cantidad,
                    'created_at'  => now(),
                    'updated_at'  => now()
                ]);
                
                return response()->json(['message' => 'Añadido al carrito con éxito'], 201);
            }

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Error al guardar en el carrito',
                'detalle' => $e->getMessage()
            ], 500);
        }
    }

    public function verCarritos(Request $request)
{
    try {
        $carrito = DB::table('carrito')
            ->join('productos', 'carrito.ID_producto', '=', 'productos.ID_producto')
            ->join('tiendas', 'carrito.ID_tienda', '=', 'tiendas.ID_tienda')
            ->where('carrito.ID_usuario', $request->user()->ID_usuario)
            // En ApiClienteController.php, dentro de verCarritos:
            ->select(
                'carrito.ID_carrito',
                'carrito.ID_tienda',
                'carrito.cantidad',
                'productos.nombre as nombre_producto', 
                'productos.precio',
                // Esto construye la URL completa hacia tu backend
                DB::raw("CONCAT('http://saborytecapi.test/storage/productos/', productos.imagen) as imagen"),
                'tiendas.nombre as nombre_tienda' 
            )
            ->get();

        return response()->json($carrito);
    } catch (\Exception $e) {
        return response()->json(['error' => $e->getMessage()], 500);
    }
}
    public function update(Request $request, $id) {
    $item = Carrito::find($id);
    
    if (!$item) {
        return response()->json(['error' => 'No encontrado'], 404);
    }

    $item->cantidad = $request->cantidad;
    $item->save();

    return response()->json(['message' => 'Cantidad actualizada', 'item' => $item]);
}

public function eliminar($id) 
{
    try {
        // Buscamos y borramos usando el nombre real de tu columna: ID_carrito
        $deleted = DB::table('carrito')->where('ID_carrito', $id)->delete();

        if ($deleted) {
            return response()->json(['message' => 'Eliminado'], 200);
        } else {
            return response()->json(['message' => 'No encontrado o ya eliminado'], 404);
        }

    } catch (\Exception $e) {
        return response()->json([
            'error' => 'Error al eliminar',
            'detalle' => $e->getMessage()
        ], 500);
    }
}
}