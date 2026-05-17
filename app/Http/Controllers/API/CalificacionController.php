<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Calificacion;
use App\Models\Pedido;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CalificacionController extends Controller
{
    public function store(Request $request)
{
    $request->validate([
        'ID_pedido'  => 'required|exists:pedidos,ID_pedido',
        'puntuacion' => 'required|integer|min:1|max:5',
        'comentario' => 'nullable|string|max:500',
    ]);

    $pedido = Pedido::find($request->ID_pedido);
    
    // Obtenemos el usuario directamente del Request autenticado
    $usuario = $request->user();
    
    $id_usuario_auth = (int) $usuario->ID_usuario; 
    $id_dueno_pedido = (int) $pedido->ID_usuario; 

    if ($id_dueno_pedido !== $id_usuario_auth) {
        return response()->json([
            'status' => 'error',
            'message' => "No tienes permiso. Tu ID es $id_usuario_auth y el del pedido es $id_dueno_pedido"
        ], 403);
    }

    if (strtolower($pedido->estado) !== 'entregado') {
        return response()->json([
            'status' => 'error',
            'message' => 'Solo puedes calificar pedidos entregados.'
        ], 400);
    }

    $existe = Calificacion::where('ID_pedido', $request->ID_pedido)->exists();
    if ($existe) {
        return response()->json([
            'status' => 'error',
            'message' => 'Este pedido ya fue calificado.'
        ], 400);
    }

    try {
        $calificacion = Calificacion::create([
            'ID_pedido'  => $pedido->ID_pedido,
            'ID_tienda'  => $pedido->ID_tienda,
            'ID_usuario' => $id_usuario_auth,
            'puntuacion' => $request->puntuacion,
            'comentario' => $request->comentario
        ]);

        return response()->json([
            'status'  => 'success',
            'message' => '¡Gracias por calificar!',
            'data'    => $calificacion
        ], 201);

    } catch (\Exception $e) {
        return response()->json(['status' => 'error', 'message' => $e->getMessage()], 500);
    }
}

public function update(Request $request,int $id_pedido)
{
    $request->validate([
        'puntuacion' => 'required|integer|min:1|max:5',
        'comentario' => 'nullable|string|max:500',
    ]);

    $id_usuario_auth = (int) $request->user()->ID_usuario;

    // Buscar la calificación que coincida con el pedido y el usuario logueado
    $calificacion = Calificacion::where('ID_pedido', $id_pedido)
                                ->where('ID_usuario', $id_usuario_auth)
                                ->first();

    if (!$calificacion) {
        return response()->json([
            'status' => 'error',
            'message' => 'No se encontró la calificación para actualizar.'
        ], 404);
    }

    try {
        $calificacion->update([
            'puntuacion' => $request->puntuacion,
            'comentario' => $request->comentario
        ]);

        return response()->json([
            'status'  => 'success',
            'message' => 'Calificación actualizada correctamente.',
            'data'    => $calificacion
        ], 200);

    } catch (\Exception $e) {
        return response()->json([
            'status' => 'error', 
            'message' => 'Error al actualizar: ' . $e->getMessage()
        ], 500);
    }
}
    public function index(int $id_tienda)
    {
        $calificaciones = Calificacion::with('usuario:ID_usuario,nombre')
            ->where('ID_tienda', $id_tienda)
            ->orderBy('ID_calificacion', 'desc')
            ->get();

        return response()->json([
            'status' => 'success',
            'data'   => $calificaciones
        ]);
    }
}