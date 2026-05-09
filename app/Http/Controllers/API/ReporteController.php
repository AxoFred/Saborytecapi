<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Pedido; // Esto ya está aquí
use App\Models\Tienda; // Esto ya está aquí
use Illuminate\Support\Facades\DB; // Esto ya está aquí
use Carbon\Carbon; // Esto ya está aquí

class ReporteController extends Controller
{
public function reporteVendedor(Request $request)
{
    try {
        $user = $request->user();
        $tienda = Tienda::where('ID_usuario_vendedor', $user->ID_usuario)->first();

        if (!$tienda) {
            return response()->json(['message' => 'Tienda no encontrada'], 404);
        }

        $idTienda = $tienda->ID_tienda;
        
        // Ajustamos la fecha al día actual asegurando el formato correcto de MySQL
        // Si el servidor está en otra zona horaria, forzamos 'America/Mexico_City'
        $hoy = Carbon::now('America/Mexico_City')->format('Y-m-d');
        
       // ReporteController.php
        $estadosVenta = ['pendiente', 'validando', 'preparacion', 'listo', 'entregado', 'finalizado'];

        // 1. Resumen de Hoy
        $resumenHoy = Pedido::where('ID_tienda', $idTienda)
            // Cambiamos whereDate por un where sobre el string de fecha para ser más exactos
            ->whereRaw("DATE(created_at) = ?", [$hoy])
            ->whereIn('estado', $estadosVenta)
            ->select(
                DB::raw('COALESCE(SUM(total), 0) as ingresos_hoy'),
                DB::raw('COUNT(*) as pedidos_hoy')
            )->first();

        // 2. Ranking (Solo agregamos el filtro de fecha para que sea coherente con "Hoy")
        $topProductos = DB::table('detalle_pedidos') 
            ->join('productos', 'detalle_pedidos.ID_producto', '=', 'productos.ID_producto')
            ->join('pedidos', 'detalle_pedidos.ID_pedido', '=', 'pedidos.ID_pedido')
            ->where('pedidos.ID_tienda', $idTienda)
            ->whereRaw("DATE(pedidos.created_at) = ?", [$hoy])
            ->whereIn('pedidos.estado', $estadosVenta)
            ->select(
                'productos.nombre as nombre_producto', 
                DB::raw('SUM(detalle_pedidos.cantidad) as total_vendido')
            )
            ->groupBy('productos.ID_producto', 'productos.nombre')
            ->orderBy('total_vendido', 'desc')
            ->take(5)
            ->get();

        // 3. Ventas de la semana (Se mantiene igual)
        // En la sección 3 del controlador: Ventas de la semana
        $ventasSemana = Pedido::where('ID_tienda', $idTienda)
            ->where('created_at', '>=', Carbon::now('America/Mexico_City')->subDays(7))
            ->whereIn('estado', ['pendiente', 'validando', 'preparacion', 'listo', 'entregado', 'finalizado'])
            ->select(
                DB::raw('DATE(created_at) as fecha'),
                DB::raw('SUM(total) as total')
            )
            ->groupBy('fecha')
            ->orderBy('fecha', 'asc')
            ->get();

        return response()->json([
            'resumen' => [
                'ingresos_hoy' => (float)$resumenHoy->ingresos_hoy,
                'pedidos_hoy'  => (int)$resumenHoy->pedidos_hoy,
            ],
            'top_productos' => $topProductos,
            'grafica_semanal' => $ventasSemana
        ]);

    } catch (\Exception $e) {
        return response()->json([
            'error' => 'Error en consulta de fecha',
            'mensaje' => $e->getMessage()
        ], 500);
    }
}
}