<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Pedido;
use App\Models\MensajePedido;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class VendedorPedidoController extends Controller
{
    public function index()
    {
        $user = Auth::user();
        $tienda = DB::table('tiendas')->where('ID_usuario_vendedor', $user->ID_usuario)->first();

        if (!$tienda)
            return response()->json(['error' => 'Sin tienda'], 403);

        $pedidos = Pedido::where('ID_tienda', $tienda->ID_tienda)
            // 'usuario' debe coincidir con el nombre de la función en Pedido.php
            ->with(['usuario', 'detalles.producto'])
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json($pedidos);
    }

    public function show($id)
    {
        // Ver detalle del pedido con los nombres de los productos
        $pedido = Pedido::with('detalles.producto')->find($id);

        if (!$pedido) {
            return response()->json(['message' => 'Pedido no encontrado'], 404);
        }

        return response()->json($pedido);
    }

    public function updateEstado(Request $request, $id)
    {
        $pedido = Pedido::find($id);

        if (!$pedido)
            return response()->json(['message' => 'Pedido no encontrado'], 404);

        $nuevoEstado = $request->estado;

        // Lógica de Cierre Seguro de Saborytec
        if ($nuevoEstado === 'entregado') {
            $pedido->update([
                'estado' => 'entregado',
                'fecha_entrega' => now(), // Importante para la limpieza de 24h
            ]);

            return response()->json([
                'message' => 'Pedido entregado. El chat se ha bloqueado para nuevas interacciones.',
                'estado' => 'entregado'
            ]);
        }

        $pedido->update(['estado' => $nuevoEstado]);

        return response()->json([
            'message' => 'El estado ha cambiado a: ' . $pedido->estado
        ]);
    }

    public function cancelar(Request $request, $id)
    {
        $pedido = Pedido::find($id);

        if (!$pedido)
            return response()->json(['message' => 'Pedido no encontrado'], 404);

        $pedido->update([
            'estado' => 'cancelado',
            'motivo_cancelacion' => $request->motivo
        ]);

        return response()->json(['message' => 'Pedido cancelado correctamente']);
    }



}