<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;

class ProductoController extends Controller
{
    /**
     * MÉTODOS ESTÁNDAR PARA API RESOURCE
     */

    // 1. GET /api/productos (Equivale a MostrarProductos)
    public function index()
    {
        try {
            // Obtenemos el ID del usuario desde el Token
            $userId = Auth::user()->ID_usuario;

            // Filtramos productos de las tiendas que pertenecen a este usuario
            $productos = DB::table('productos')
                ->leftJoin('categorias', 'productos.ID_categoria', '=', 'categorias.ID_categoria')
                ->leftJoin('tiendas', 'productos.ID_tienda', '=', 'tiendas.ID_tienda')
                ->where('tiendas.ID_usuario_vendedor', $userId) 
                
                ->select(
                    'productos.*',
                    'categorias.nombre as nombre_categoria',
                    'tiendas.nombre as nombre_tienda'
                )
                ->get();

            return response()->json($productos, 200);

        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'error' => 'No se pudieron obtener los productos: ' . $e->getMessage()
            ], 500);
        }
    }

    // 2. POST /api/productos (Equivale a RegistrarProductos)
    public function store(Request $request)
{
    try {
        $data = [
            'nombre'       => $request->nombre,
            'marca'        => $request->marca,
            'descripcion'  => $request->descripcion,
            'precio'       => $request->precio,
            'estado'       => 'pendiente',
            'ID_categoria' => $request->ID_categoria,
            'ID_tienda'    => $request->ID_tienda,
            'visible'      => 0,
            'disponible'   => 1 
        ];

        if ($request->hasFile('imagen')) {
            $file = $request->file('imagen');

            // Generar nombre único seguro
            $nombreArchivo = time() . '.' . $file->getClientOriginalExtension();

            // Guardar correctamente en el disk 'public'
            $file->storeAs('productos', $nombreArchivo, 'public');

            // Guardar solo el nombre en la BD
            $data['imagen'] = $nombreArchivo;
        }

        DB::table('productos')->insert($data);

        return response()->json([
            'success' => true,
            'message' => 'Producto registrado correctamente. Pendiente de revisión por el administrador.'
        ], 201);

    } catch (Exception $e) {
        return response()->json([
            'success' => false,
            'error' => $e->getMessage()
        ], 400);
    }
}

    // 3. GET /api/productos/{id} (Para ver un producto específico)
    public function show($id)
    {
        $producto = DB::table('productos')->where('ID_producto', $id)->first();
        
        if (!$producto) {
            return response()->json(['error' => 'Producto no encontrado'], 404);
        }
        
        return response()->json($producto);
    }

    // 4. PUT /api/productos/{id} (Equivale a ActualizarProductos)
    public function update(Request $request, $id)
    {
        try {
            $producto = DB::table('productos')
                ->where('ID_producto', $id)
                ->first();

            if (!$producto) {
                return response()->json([
                    'success' => false,
                    'error' => 'Producto no encontrado'
                ], 404);
            }

            $data = [];
            $campos = ['nombre', 'marca', 'descripcion', 'precio', 'ID_categoria', 'ID_tienda', 'disponible'];

            foreach ($campos as $campo) {
                if ($request->has($campo)) {
                    $data[$campo] = $request->$campo;
                }
            }

            if ($request->hasFile('imagen')) {
                // Borrar imagen vieja si existe
                if ($producto->imagen) {
                    Storage::delete('public/productos/' . $producto->imagen);
                }
                
                $file = $request->file('imagen');
                $nombreArchivo = time() . "_" . $file->getClientOriginalName();
                $file->storeAs('public/productos', $nombreArchivo);
                $data['imagen'] = $nombreArchivo;
            }

            if (empty($data)) {
                return response()->json(['success' => true, 'message' => 'No hay cambios que realizar']);
            }

            DB::table('productos')
                ->where('ID_producto', $id)
                ->update($data);

            return response()->json(['success' => true, 'message' => 'Producto actualizado correctamente']);

        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'error' => $e->getMessage()
            ], 400);
        }
    }

    // 5. DELETE /api/productos/{id} (Equivale a EliminarProductos)
    public function destroy($id)
    {
        try {
            // Borrado lógico (lo hacemos invisible)
            DB::table('productos')
                ->where('ID_producto', $id)
                ->update(['visible' => 0]);

            return response()->json([
                'success' => true,
                'message' => 'El producto ha sido marcado como no visible.'
            ]);

        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'error' => $e->getMessage()
            ], 500);
        }
    }

    // Método para obtener categorías (Soluciona el error 500 de /api/categorias)
    public function getCategorias()
    {
        try {
            $categorias = DB::table('categorias')->select('ID_categoria', 'nombre')->get();
            return response()->json($categorias, 200);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    // Método para cambiar disponibilidad (Soluciona el error del Switch)
    public function toggleDisponibilidad(Request $request, $id)
    {
        try {
            DB::table('productos')
                ->where('ID_producto', $id)
                ->update(['disponible' => $request->disponible]);

            return response()->json(['success' => true, 'message' => 'Disponibilidad actualizada']);
        } catch (Exception $e) {
            return response()->json(['success' => false, 'error' => $e->getMessage()], 500);
        }
    }

    // Asegúrate de que el método miTienda esté en TiendaController o añádelo aquí si lo prefieres
}