<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Pedido;
use App\Models\DetallePedido;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class PedidoController extends Controller
{
    /**
     * Saborytec | Crear un nuevo pedido desde el carrito
     */
    public function store(Request $request)
    {
        // 1. VALIDACIÓN
        $request->validate([
            'id_tienda' => 'required|exists:tiendas,ID_tienda',
            'metodo_pago' => 'required|in:efectivo,transferencia',
        ]);

        $user = Auth::user();
        
        // Si no mandas nombre_cliente, usamos el del usuario logueado
        $nombreCliente = $request->nombre_cliente ?? $user->name ?? $user->nombre ?? 'Usuario Saborytec';

        try {
            return DB::transaction(function () use ($request, $user, $nombreCliente) {
                
                // 2. OBTENER PRODUCTOS DEL CARRITO
                // Buscamos los items de este usuario en la tienda específica
                $itemsCarrito = DB::table('carrito')
                    ->join('productos', 'carrito.ID_producto', '=', 'productos.ID_producto')
                    ->where('carrito.ID_usuario', $user->ID_usuario)
                    ->where('carrito.ID_tienda', $request->id_tienda)
                    ->select('carrito.*', 'productos.precio')
                    ->get();

                if ($itemsCarrito->isEmpty()) {
                    return response()->json([
                        'message' => 'El carrito para esta tienda está vacío o ya fue procesado.'
                    ], 400);
                }

                // 3. CALCULAR TOTAL
                $total = $itemsCarrito->sum(function($item) {
                    return $item->cantidad * $item->precio;
                });

                // 4. CREAR CABECERA DEL PEDIDO
                $pedido = Pedido::create([
                    'ID_usuario'     => $user->ID_usuario,
                    'ID_tienda'      => $request->id_tienda,
                    'nombre_cliente' => $nombreCliente,
                    'total'          => $total,
                    'metodo_pago'    => $request->metodo_pago,
                    'notas_pedido'   => $request->notas_pedido ?? null,
                    'estado'         => 'pendiente', 
                    'comprobante'    => null
                ]);

                // 5. REGISTRAR DETALLES DEL PEDIDO
                foreach ($itemsCarrito as $item) {
                    DetallePedido::create([
                        'ID_pedido'       => $pedido->ID_pedido,
                        'ID_producto'     => $item->ID_producto,
                        'cantidad'        => $item->cantidad,
                        'precio_unitario' => $item->precio,
                        'subtotal'        => $item->cantidad * $item->precio
                    ]);
                }

                // 6. VACIAR CARRITO
                // Solo eliminamos los productos de la tienda que se acaba de comprar
                DB::table('carrito')
                    ->where('ID_usuario', $user->ID_usuario)
                    ->where('ID_tienda', $request->id_tienda)
                    ->delete();

                return response()->json([
                    'status' => 'success',
                    'message' => '¡Pedido generado con éxito!',
                    'ID_pedido' => $pedido->ID_pedido
                ], 201);
            });

        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Error al procesar el pedido en el servidor.',
                'detalle' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Listar pedidos del usuario autenticado
     */
    public function misPedidos()
    {
        try {
            $pedidos = Pedido::where('ID_usuario', Auth::user()->ID_usuario)
                ->with('tienda:ID_tienda,nombre', 'calificacion') // Asegúrate de tener la relación 'tienda' en el modelo Pedido
                ->orderBy('created_at', 'desc')
                ->get();

            return response()->json($pedidos);
            
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
}