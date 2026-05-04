<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\UsuariosController;
use App\Http\Controllers\API\TiendaController;
use App\Http\Controllers\API\ProductoController;
use App\Http\Controllers\API\TiendaAprobacionController;
use App\Http\Controllers\API\ProductoAprobacionController;
use App\Http\Controllers\API\ApiClienteController;

/*
|--------------------------------------------------------------------------
| API Routes - Saborytec (Versión Protegida Universitaria)
|--------------------------------------------------------------------------
*/

// Estado de la API (Público solo para verificar que el servidor vive)
Route::get('/', function () {
    return response()->json(['status' => 'API Saborytec funcionando correctamente']);
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
        
    Route::get('/carrito/ver', [ApiClienteController::class, 'verCarritos']);
    Route::delete('/carrito/eliminar/{id}', [ApiClienteController::class, 'eliminar']);
    // api.php
    Route::put('/carrito/actualizar/{id}', [ApiClienteController::class, 'update']);
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

    // --- ADMINISTRACIÓN DE PRODUCTOS (APROBACIONES) ---
    Route::prefix('admin/productos')->group(function () {
        Route::get('pendientes', [ProductoAprobacionController::class, 'pendientes']);
        Route::post('{id}/aprobar', [ProductoAprobacionController::class, 'aprobar']);
        Route::post('{id}/rechazar', [ProductoAprobacionController::class, 'rechazar']);
    });
});