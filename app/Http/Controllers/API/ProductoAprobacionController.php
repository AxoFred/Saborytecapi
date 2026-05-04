<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Producto;
use Illuminate\Support\Facades\DB;
use Exception;

class ProductoAprobacionController extends Controller
{
    public function pendientes()
    {
        try {
            $productos = DB::table('productos')
                ->leftJoin('categorias', 'productos.ID_categoria', '=', 'categorias.ID_categoria')
                ->leftJoin('tiendas', 'productos.ID_tienda', '=', 'tiendas.ID_tienda')
                //->where('productos.estado', 'pendiente')
                ->select(
                    'productos.*', // Corregido: sin saltos de línea raros
                    'categorias.nombre as nombre_categoria',
                    'tiendas.nombre as nombre_tienda' 
                )
                ->get();

            return response()->json($productos);

        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error en la base de datos',
                'error' => $e->getMessage() 
            ], 500);
        }
    }

    // Añadimos 'int' para quitar el aviso de Intelephense
    public function aprobar(int $id)
    {
        try {
            DB::table('productos')->where('ID_producto', $id)->update([
                'estado' => 'aprobado',
                'visible' => 1
            ]);
            return response()->json(['success' => true]);
        } catch (Exception $e) {
            return response()->json(['success' => false, 'error' => $e->getMessage()], 500);
        }
    }

    public function rechazar(int $id)
    {
        try {
            DB::table('productos')->where('ID_producto', $id)->update([
                'estado' => 'rechazado',
                'visible' => 0
            ]);
            return response()->json(['success' => true]);
        } catch (Exception $e) {
            return response()->json(['success' => false, 'error' => $e->getMessage()], 500);
        }
    }
}