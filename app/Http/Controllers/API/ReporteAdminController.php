<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Usuario;
use App\Models\Pedido;
use App\Models\Producto;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ReporteAdminController extends Controller
{
    /**
     * Saborytec - Reportes Globales para Administrador
     * Desarrollado por: FREDY & VICTOR
     */
    public function obtenerMetricasGlobales()
    {
        try {
            // 1. Ingresos Consolidados (Solo pedidos completados exitosamente)
            $ingresosTotales = Pedido::where('estado', 'entregado')
                ->sum('total');

            // 2. Puntos de Venta (Usuarios con rol de vendedor)
            // Asegúrate que 2 sea el ID de 'vendedor' en tu tabla roles
            $totalVendedores = Usuario::where('ID_rol', 2)->count();

            // 3. Catálogo General (Contamos todos los productos en el sistema)
            $totalProductos = Producto::count();

            // 4. Comparativa de Ventas (Ruta corregida: Usuario -> Tienda -> Pedido)
            $comparativaVendedores = Usuario::where('usuarios.ID_rol', 2)
                ->select(
                    'usuarios.nombre as nombre_vendedor',
                    DB::raw('COALESCE(SUM(pedidos.total), 0) as total_ventas')
                )
                // UNIÓN CORRECTA: Usando 'ID_usuario_vendedor' según tu modelo Tienda
                ->leftJoin('tiendas', 'usuarios.ID_usuario', '=', 'tiendas.ID_usuario_vendedor')
                // Unión con Pedidos
                ->leftJoin('pedidos', function ($join) {
                    $join->on('tiendas.ID_tienda', '=', 'pedidos.ID_tienda')
                        ->where('pedidos.estado', '=', 'entregado'); // 'entregado' como string
                })
                ->groupBy('usuarios.ID_usuario', 'usuarios.nombre')
                ->orderBy('total_ventas', 'desc')
                ->get();

            // Respuesta estructurada para el JS que ya tienes
            return response()->json([
                'error' => false,
                'ingresos_totales' => number_format($ingresosTotales, 2, '.', ''),
                'total_vendedores' => $totalVendedores,
                'total_productos' => $totalProductos,
                'comparativa_vendedores' => $comparativaVendedores
            ], 200);

        } catch (\Exception $e) {
            // El helper logger() ya sabe qué hacer sin importar los imports
            logger()->error("Error en ReporteAdmin: " . $e->getMessage());

            return response()->json([
                'error' => true,
                'mensaje' => 'Error en el servidor de Saborytec: ' . $e->getMessage()
            ], 500);
        }
    }
}