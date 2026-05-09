<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Horario;
use App\Models\Tienda;
use Illuminate\Http\Request;
use Exception;

class HorarioController extends Controller
{
    public function index(Request $request)
    {
        try {
            $user = $request->user();
            $tienda = Tienda::where('ID_usuario_vendedor', $user->ID_usuario)->first();

            if (!$tienda) {
                return response()->json([]);
            }

            $horarios = Horario::where('ID_tienda', $tienda->ID_tienda)
                ->orderByRaw("FIELD(dia_semana, 'lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo')")
                ->get();

            return response()->json($horarios);

        } catch (Exception $e) {
            return response()->json([
                'error' => 'Error al obtener horarios',
                'detalle' => $e->getMessage()
            ], 500);
        }
    }

   public function store(Request $request)
{
    try {
        $user = $request->user();
        $tienda = Tienda::where('ID_usuario_vendedor', $user->ID_usuario)->first();

        if (!$tienda) {
            return response()->json(['message' => 'Tienda no encontrada'], 404);
        }

        // 1. Validar los datos de entrada
        $request->validate([
            'dia_semana'    => 'required|in:lunes,martes,miercoles,jueves,viernes,sabado,domingo',
            'hora_apertura' => 'required',
            'hora_cierre'   => 'required',
            'estado'        => 'required|in:activo,inactivo'
        ]);

        // 2. VERIFICACIÓN CLAVE: ¿Ya existe este día para esta tienda?
        $existe = Horario::where('ID_tienda', $tienda->ID_tienda)
                         ->where('dia_semana', $request->dia_semana)
                         ->exists();

        if ($existe) {
            // Devolvemos un 400 (Bad Request) con el mensaje personalizado
            return response()->json([
                'status'  => 'error',
                'message' => "Ya tienes un horario registrado para el día {$request->dia_semana}. Puedes editarlo en la lista."
            ], 400);
        }

        // 3. Si no existe, procedemos a crear el registro
        $horario = Horario::create([
            'ID_tienda'     => $tienda->ID_tienda,
            'dia_semana'    => $request->dia_semana,
            'hora_apertura' => date('H:i:s', strtotime($request->hora_apertura)),
            'hora_cierre'   => date('H:i:s', strtotime($request->hora_cierre)),
            'estado'        => $request->estado
        ]);

        return response()->json($horario, 201);

    } catch (Exception $e) {
        return response()->json([
            'error'   => 'Error al procesar la solicitud',
            'detalle' => $e->getMessage()
        ], 500);
    }
}

    public function update(Request $request, int $id)
    {
        try {
            $horario = Horario::findOrFail($id);
            $user = $request->user();
            $tienda = Tienda::where('ID_usuario_vendedor', $user->ID_usuario)->first();

            if (!$tienda || $horario->ID_tienda !== $tienda->ID_tienda) {
                return response()->json(['message' => 'No autorizado'], 403);
            }

            $request->validate([
                'hora_apertura' => 'required',
                'hora_cierre'   => 'required',
                'estado'        => 'required|in:activo,inactivo'
            ]);

            $horario->update([
                'hora_apertura' => date('H:i:s', strtotime($request->hora_apertura)),
                'hora_cierre'   => date('H:i:s', strtotime($request->hora_cierre)),
                'estado'        => $request->estado
            ]);

            return response()->json([
                'message' => 'Horario actualizado correctamente',
                'horario' => $horario
            ]);

        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function destroy(Request $request, int $id)
    {
        try {
            $horario = Horario::findOrFail($id);
            $user = $request->user();
            $tienda = Tienda::where('ID_usuario_vendedor', $user->ID_usuario)->first();

            if (!$tienda || $horario->ID_tienda !== $tienda->ID_tienda) {
                return response()->json(['message' => 'No autorizado'], 403);
            }

            $horario->delete();
            return response()->json(['message' => 'Horario eliminado']);

        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
}