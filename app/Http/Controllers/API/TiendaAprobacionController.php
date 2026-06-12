<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Tienda;
use Illuminate\Http\Request;

class TiendaAprobacionController extends Controller
{
    /**
     * Obtener tiendas pendientes de revisión.
     */
    public function pendientes()
    {
        // Traemos las tiendas pendientes que estén marcadas como visibles
        $tiendas = Tienda::where('aprobacion', 'pendiente')
            ->where('visible', 1)
            ->get();

        return response()->json($tiendas, 200);
    }

    /**
     * Obtener tiendas aprobadas históricas.
     */
    public function aprobadas()
    {
        // Traemos las aprobadas (puedes quitar el 'visible' si un admin debe verlas de todos modos)
        $tiendas = Tienda::where('aprobacion', 'aprobada')
            ->where('visible', 1)
            ->get();

        return response()->json($tiendas, 200);
    }

    /**
     * Obtener tiendas rechazadas históricas.
     */
    public function rechazadas()
    {
        // Traemos las rechazadas
        $tiendas = Tienda::where('aprobacion', 'rechazada')
            ->where('visible', 1) 
            ->get();

        return response()->json($tiendas, 200);
    }
    
    /**
     * Aprobar una tienda específica.
     */
    public function aprobar($id)
    {
        try {
            $tienda = Tienda::findOrFail($id);
            $tienda->aprobacion = 'aprobada';
            $tienda->save();

            return response()->json([
                'status' => 'success',
                'message' => 'Tienda aprobada correctamente.'
            ], 200);
        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'No se encontró la tienda.'], 404);
        }
    }

    /**
     * Rechazar una tienda específica.
     */
    public function rechazar($id)
    {
        try {
            $tienda = Tienda::findOrFail($id);
            $tienda->aprobacion = 'rechazada';
            $tienda->save();

            return response()->json([
                'status' => 'success',
                'message' => 'La tienda ha sido rechazada.'
            ], 200);
        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'No se encontró la tienda.'], 404);
        }
    }
}