<?php

namespace App\Http\Controllers\API;

use App\Models\Usuario;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Http\Controllers\Controller;
use Exception;

class AuthController extends Controller
{
    // REGISTRO de nuevo usuario
    public function register(Request $request)
    {
        $request->validate([
            'nombre'   => 'required|string|max:255',
            'Apaterno' => 'required|string|max:255',
            'Amaterno' => 'nullable|string|max:255',
            'correo'   => 'required|email|unique:usuarios,correo',
            'password' => 'required|min:2',
            'telefono' => 'nullable|string',
            'ID_rol'   => 'required|integer'
        ]);

        try {
            $usuario = Usuario::create([
                'nombre'   => $request->nombre,
                'Apaterno' => $request->Apaterno,
                'Amaterno' => $request->Amaterno,
                'correo'   => $request->correo,
                'password' => Hash::make($request->password),
                'telefono' => $request->telefono,
                'estado'   => $request->estado ?? 'Activo', // Valor por defecto
                'ID_rol'   => $request->ID_rol,
                'visible'  => 1
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Usuario registrado correctamente',
                'data'    => $usuario
            ], 201);

        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'error'   => 'Error al registrar: ' . $e->getMessage()
            ], 500);
        }
    }

    // LOGIN - Generación de Token
    public function login(Request $request)
    {
        $request->validate([
            'correo'   => 'required|email',
            'password' => 'required'
        ]);

        // Buscamos por 'correo' y que el usuario esté 'visible'
        $usuario = Usuario::where('correo', $request->correo)
                          ->where('visible', 1)
                          ->first();

        if (!$usuario || !Hash::check($request->password, $usuario->password)) {
            return response()->json([
                'success' => false,
                'message' => 'Credenciales incorrectas o usuario no permitido'
            ], 401);
        }

        // Crear el token (usando Laravel Sanctum)
        $token = $usuario->createToken('auth_token')->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Login exitoso',
            'token'   => $token,
            'user'    => $usuario
        ], 200);
    }

    // LOGOUT - Revocar Token
    public function logout(Request $request)
    {
        // Elimina el token que se está usando actualmente
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'success' => true,
            'message' => 'Sesión cerrada correctamente y token eliminado'
        ], 200);
    }
}