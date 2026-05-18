<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\UsuariosController;
use App\Http\Controllers\API\TiendaController;
use App\Http\Controllers\API\ProductoController;
use App\Http\Controllers\API\TiendaAprobacionController;
use App\Http\Controllers\API\ProductoAprobacionController;
use App\Http\Controllers\API\ApiClienteController;
use App\Http\Controllers\API\PedidoController;
use App\Http\Controllers\API\VendedorPedidoController;
use App\Http\Controllers\API\ChatController;
use App\Http\Controllers\API\HorarioController;
use App\Http\Controllers\API\ReporteController;
use App\Http\Controllers\API\ReporteAdminController;
use App\Http\Controllers\API\CalificacionController;
/*
|--------------------------------------------------------------------------
| API Routes - Saborytec (Versión Protegida Universitaria)
|--------------------------------------------------------------------------
*/

// Estado de la API (Público solo para verificar que el servidor vive)
Route::get('/', function () {
    return response()->json(['status' => 'API Saborytec funcionando correctamente']);
});

Route::get('/crear-enlace-storage', function () {
    \Illuminate\Support\Facades\Artisan::call('storage:link');
    return '¡Enlace simbólico creado con éxito en la nube de Railway!';
});

/******************************************************************
 *                        RUTAS PÚBLICAS                          *
 ******************************************************************/

// Única puerta de entrada: Login
Route::post('login', [AuthController::class, 'login'])->name('login');


/******************************************************************
 *                       RUTAS PROTEGIDAS                         *
 ******************************************************************/
// todo lo que esté aquí dentro requiere el token "auth_token"
Route::middleware('auth:sanctum')->group(function () {

    // --- SESIÓN ---
    Route::post('logout', [AuthController::class, 'logout']);

    // --- RUTAS PARA CLIENTES (ESTUDIANTES, DOCENTES) ---
    // Estas rutas permiten que el cliente vea el catálogo una vez logueado
    Route::prefix('cliente')->group(function () {
        Route::get('tiendas', [ApiClienteController::class, 'getTiendas']);
        Route::get('productos/destacados', [ApiClienteController::class, 'getProductosDestacados']);
        Route::get('/explorar', [ApiClienteController::class, 'explorar']);
        Route::get('/filtros-data', [ApiClienteController::class, 'getFiltrosData']);
        Route::post('/carrito/agregar', [ApiClienteController::class, 'agregarAlCarrito']);
        
        // Rutas para ver, eliminar y actualizar el carrito
        Route::get('/carrito/ver', [ApiClienteController::class, 'verCarritos']);
        Route::delete('/carrito/eliminar/{id}', [ApiClienteController::class, 'eliminar']);
        Route::put('/carrito/actualizar/{id}', [ApiClienteController::class, 'update']);

        // --- RUTAS DE PEDIDOS (group cliente) ---
        Route::post('/pedidos/confirmar', [PedidoController::class, 'store']);

        Route::get('/pedidos/mis-pedidos', [PedidoController::class, 'misPedidos']);

        Route::post('/pedidos/crear', [PedidoController::class, 'store']);

        Route::get('/pedidos/ver', [PedidoController::class, 'misPedidos']);

        // RUTAS CHAT (groupcliente):
        Route::get('/pedidos/{id}/mensajes', [ChatController::class, 'index']);
        Route::post('/pedidos/mensajes', [ChatController::class, 'store']);
        //calificaciones(group cliente)
        Route::post('/calificaciones', [CalificacionController::class, 'store']);
         //calificaciones(group cliente)
        Route::put('/calificaciones/{id_pedido}', [CalificacionController::class, 'update']);
    });

    // --- GESTIÓN DE USUARIOS (ADMIN) ---
    Route::get('usuarios/ocultos', [UsuariosController::class, 'indexOcultos']);
    Route::patch('usuarios/{id}/activar', [UsuariosController::class, 'activar']);
    Route::apiResource('usuarios', UsuariosController::class);
    
    // --- GESTIÓN DE TIENDAS (VENDEDOR / ADMIN) ---
    // Mantenemos tu apiResource original para el CRUD
    Route::apiResource('tiendas', TiendaController::class);
    
    // --- ADMINISTRACIÓN DE TIENDAS (APROBACIONES) ---
    Route::prefix('admin/tiendas')->group(function () {
        Route::get('pendientes', [TiendaAprobacionController::class, 'pendientes']);
        Route::post('{id}/aprobar', [TiendaAprobacionController::class, 'aprobar']);
        Route::post('{id}/rechazar', [TiendaAprobacionController::class, 'rechazar']);
    });

    // --- GESTIÓN DE PRODUCTOS ---
    Route::get('categorias', [ProductoController::class, 'getCategorias']);
    Route::get('vendedor/tienda', [TiendaController::class, 'index']); 
    Route::post('productos/{id}/disponibilidad', [ProductoController::class, 'toggleDisponibilidad']);

    Route::apiResource('productos', ProductoController::class);

    // --- NUEVAS RUTAS DE GESTIÓN DE PEDIDOS (vendedor) ---
    Route::prefix('vendedor/pedidos')->group(function () {
        Route::get('/', [VendedorPedidoController::class, 'index']);          // Ver lista de pedidos
        Route::get('/{id}', [VendedorPedidoController::class, 'show']);       // Ver detalle (productos)  
        Route::post('/{id}/estado', [VendedorPedidoController::class, 'updateEstado']);     // Cambiar a 'preparación', etc.
        Route::post('/{id}/cancelar', [VendedorPedidoController::class, 'cancelar']);   
            // Cancelar con motivo
        Route::post('/{id}/mensajes', [ChatController::class, 'storeVendedor']);
       
    });

     Route::get('/chat/{id_pedido}', [ChatController::class, 'index']);

    // --- ADMINISTRACIÓN DE PRODUCTOS (APROBACIONES) ---
    Route::prefix('admin/productos')->group(function () {
        Route::get('pendientes', [ProductoAprobacionController::class, 'pendientes']);
        Route::post('{id}/aprobar', [ProductoAprobacionController::class, 'aprobar']);
        Route::post('{id}/rechazar', [ProductoAprobacionController::class, 'rechazar']);
    });

    // Rutas para Horarios
    Route::get('horarios/vendedor/mis-horarios', [HorarioController::class, 'index']);
    Route::put('horarios/{id}', [HorarioController::class, 'update']);
    Route::post('horarios', [HorarioController::class, 'store']);
    Route::delete('horarios/{id}', [HorarioController::class, 'destroy']);

    // Reportes Saborytec 
    Route::get('reportes/vendedor', [ReporteController::class, 'reporteVendedor']);
    Route::get('reportes/admin/general', [ReporteAdminController::class, 'obtenerMetricasGlobales']);
    
    //calificaciones
    Route::get('/tienda/{id}/calificaciones', [CalificacionController::class, 'index']);
});