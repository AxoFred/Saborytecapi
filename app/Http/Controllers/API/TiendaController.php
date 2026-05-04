<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\Request;
use App\Models\Tienda; 
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class TiendaController extends Controller
{
    /**
     * Corresponde a: GET /api/tiendas
     */
    public function index()
    {
        try {
            $user = Auth::user();

            $tienda = Tienda::where('ID_usuario_vendedor', $user->ID_usuario)->first();
            
            return response()->json([
                'success' => true,
                'data' => $tienda
            ], 200);
            
        } catch (Exception $e) {
            return response()->json([
                'error' => 'Error al cargar la tienda: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Corresponde a: POST /api/tiendas
     */
    public function store(Request $request)
    {
        try {
            $user = Auth::user();
            $userId = $user->ID_usuario;

            $request->validate([
                'nombre' => 'required|string|max:100',
                'clabe'  => 'nullable|string|size:18',
            ]);

            $tienda = Tienda::where('ID_usuario_vendedor', $userId)->first();

            $logoNombre = $tienda ? $tienda->logo : null;
            $portadaNombre = $tienda ? $tienda->portada : null;

            // =========================
            // LOGO (CORREGIDO)
            // =========================
            if ($request->hasFile('logo')) {
                $logoNombre = $request->file('logo')->store('logos', 'public');
            }

            // =========================
            // PORTADA (CORREGIDO)
            // =========================
            if ($request->hasFile('portada')) {
                $portadaNombre = $request->file('portada')->store('portadas', 'public');
            }

            $data = [
                'nombre'              => $request->nombre,
                'descripcion'         => $request->descripcion,
                'logo'                => $logoNombre,
                'portada'             => $portadaNombre,
                'estado'              => $request->estado ?? 'activo',
                'ID_usuario_vendedor' => $userId,
                'visible'             => 1,
                'facebook'            => $request->facebook,
                'instagram'           => $request->instagram,
                'whatsapp'            => $request->whatsapp,
                'tiktok'              => $request->tiktok,
                'clabe'               => $request->clabe,
                'banco'               => $request->banco,
                'titular_cuenta'      => $request->titular_cuenta,
                'aprobacion'          => 'pendiente'
            ];

            if ($tienda) {
                $tienda->update($data);
            } else {
                $tienda = Tienda::create($data);
            }

            return response()->json([
                'success' => true, 
                'message' => 'Tienda guardada correctamente',
                'data' => $tienda
            ]);

        } catch (Exception $e) {
            return response()->json([
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Corresponde a: DELETE /api/tiendas/{id}
     */
    public function destroy($id)
    {
        try {
            $user = Auth::user();
            
            Tienda::where('ID_usuario_vendedor', $user->ID_usuario)
                ->update(['visible' => 0]);

            return response()->json([
                'success' => true,
                'message' => 'La tienda ahora es invisible para los clientes.'
            ]);
        } catch (Exception $e) {
            return response()->json([
                'error' => $e->getMessage()
            ], 500);
        }
    }
}