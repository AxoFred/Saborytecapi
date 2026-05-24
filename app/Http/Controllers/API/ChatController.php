<?php

namespace App\Http\Controllers\API; // <--- Namespace actualizado

use App\Http\Controllers\Controller; // Importamos el controlador base
use App\Models\MensajePedido;
use App\Models\Pedido;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ChatController extends Controller
{
    /**
     * Obtener el historial de chat de un pedido
     */
 public function index(int $id_pedido) // <--- Aquí agregamos 'int'
{
    // Buscamos el pedido para saber su estado antes de cargar mensajes
    $pedido = Pedido::find($id_pedido);

    if (!$pedido) {
        return response()->json([
            'status' => 'error',
            'message' => 'Pedido no encontrado'
        ], 404);
    }

    $mensajes = MensajePedido::with('usuario:ID_usuario,nombre')
        ->where('ID_pedido', $id_pedido)
        ->orderBy('created_at', 'asc')
        ->get();

    return response()->json([
        'status' => 'success',
        'estado_pedido' => $pedido->estado, // Fundamental para que Víctor bloquee el chat
        'mensajes' => $mensajes
    ]);
}

    /**
     * Guardar mensaje o comprobante enviado por el cliente
     */
public function store(Request $request)
    {
        $request->validate([
            'ID_pedido' => 'required|exists:pedidos,ID_pedido',
            'mensaje'   => 'nullable|string',
            'archivo'   => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
        ]);

        $pedido = Pedido::find($request->ID_pedido);

        // --- VALIDACIÓN DE CIERRE SEGURO ---
        // Si el pedido ya fue entregado, finalizado o cancelado, bloqueamos el mensaje
        if (in_array($pedido->estado, ['entregado', 'finalizado', 'cancelado'])) {
            return response()->json([
                'status' => 'error',
                'message' => 'El chat está cerrado porque el pedido ya ha sido gestionado.'
            ], 403);
        }

        $usuario = Auth::user();
        $path = null;
        $tipo = 'texto';

        if ($request->hasFile('archivo')) {
            $path = $request->file('archivo')->store('comprobantes', 'public');
            $tipo = 'imagen';

            $pedido->update([
                'estado' => 'validando',
                'comprobante' => $path
            ]);
        }

        $nuevoMensaje = MensajePedido::create([
            'ID_pedido'    => $request->ID_pedido,
            'ID_usuario'   => $usuario->ID_usuario,
            'mensaje'      => $request->mensaje,
            'archivo_path' => $path,
            'tipo'         => $tipo,
            'es_de_tienda' => false,
            'leido'        => false
        ]);

        return response()->json([
            'status'  => 'success',
            'data'    => $nuevoMensaje
        ], 201);
    }

    /**
     * Guardar mensaje enviado por el VENDEDOR
     */
    public function storeVendedor(Request $request, int $id_pedido)
{
    $request->validate([
        'mensaje' => 'nullable|string',
        'archivo' => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
    ]);

    // Debe existir al menos texto o imagen
    if (!$request->mensaje && !$request->hasFile('archivo')) {
        return response()->json([
            'status' => 'error',
            'message' => 'Debes enviar un mensaje o una imagen.'
        ], 422);
    }

    $pedido = Pedido::find($id_pedido);

    // Bloquear si el chat ya está cerrado
    if (in_array($pedido->estado, ['entregado', 'finalizado', 'cancelado'])) {
        return response()->json([
            'status' => 'error',
            'message' => 'Chat finalizado. No puedes enviar más mensajes.'
        ], 403);
    }

    $usuario = Auth::user();

    $path = null;
    $tipo = 'texto';

    // Si viene imagen
    if ($request->hasFile('archivo')) {

        $path = $request->file('archivo')
            ->store('chat_vendedor', 'public');

        $tipo = 'imagen';
    }

    $nuevoMensaje = MensajePedido::create([
        'ID_pedido'    => $id_pedido,
        'ID_usuario'   => $usuario->ID_usuario,
        'mensaje'      => $request->mensaje,
        'archivo_path' => $path,
        'tipo'         => $tipo,
        'es_de_tienda' => true,
        'leido'        => false
    ]);

    return response()->json([
        'status' => 'success',
        'data'   => $nuevoMensaje
    ], 201);
}
}