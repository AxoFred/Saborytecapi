<?php

// Si el archivo está dentro de la carpeta Controllers/API/
namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class UsuariosController extends Controller
{
    // Mostrar todos los usuarios activos
    public function index() 
    {
        try {
            // Mostrar solo usuarios visibles
            $usuarios = DB::connection('mysql')->table('usuarios')->where('visible', 1)->get();
            return response()->json($usuarios, 200);

        } catch (Exception $e) {
            return response()->json([
                'success' => false, 
                'error' => 'No se pudieron obtener los usuarios'
            ], 500);
        }
    }

    // NUEVO: Mostrar solo usuarios en la papelera (ocultos)
    public function indexOcultos()
    {
        try {
            $usuarios = DB::connection('mysql')->table('usuarios')->where('visible', 0)->get();
            return response()->json($usuarios, 200);
        } catch (Exception $e) {
            return response()->json([
                'success' => false, 
                'error' => 'No se pudo cargar la papelera'
            ], 500);
        }
    }

    // Registrar nuevo usuario
    public function store(Request $request)
    {
        try {
            DB::connection('mysql')->table('usuarios')->insert([
                'nombre' => $request->nombre,
                'Apaterno' => $request->Apaterno,
                'Amaterno' => $request->Amaterno,
                'correo' => $request->correo,
                'password' => bcrypt($request->password),
                'telefono' => $request->telefono,
                'estado' => $request->estado,
                'ID_rol' => $request->ID_rol,
                'visible' => 1 
            ]);

            return response()->json(['success' => true], 201);

        } catch (Exception $e) {
            return response()->json([
                'success' => false, 
                'error' => $e->getMessage()
            ], 400);
        }
    }

    // Actualizar usuario
    public function update(Request $request, int $id)
    {
        try {
            $data = [
                'nombre' => $request->nombre,
                'Apaterno' => $request->Apaterno,
                'Amaterno' => $request->Amaterno,
                'correo' => $request->correo,
                'telefono' => $request->telefono,
                'estado' => $request->estado,
                'ID_rol' => $request->ID_rol
            ];

            if ($request->password) {
                $data['password'] = bcrypt($request->password);
            }

            DB::connection('mysql')->table('usuarios')->where('ID_usuario', $id)->update($data);

            return response()->json(['success' => true], 200);

        } catch (Exception $e) {
            return response()->json([
                'success' => false, 
                'error' => $e->getMessage()
            ], 400);
        }
    }

    // NUEVO: Restaurar usuario (Volver a hacer visible)
    public function activar(int $id)
    {
        try {
            DB::connection('mysql')->table('usuarios')
                ->where('ID_usuario', $id)
                ->update(['visible' => 1]);

            return response()->json(['success' => true, 'message' => 'Usuario restaurado'], 200);
        } catch (Exception $e) {
            return response()->json([
                'success' => false, 
                'error' => $e->getMessage()
            ], 500);
        }
    }

    // Eliminar usuario (soft delete / ocultar)
    public function destroy(int $id)
    {
        try {
            if ($id == 1) {
                return response()->json([
                    'success' => false,
                    'message' => 'No se puede eliminar al Administrador General'
                ], 403);
            }

            DB::connection('mysql')->table('usuarios')->where('ID_usuario', $id)->update(['visible' => 0]);

            return response()->json(['success' => true], 200);

        } catch (Exception $e) {
            return response()->json([
                'success' => false, 
                'error' => $e->getMessage()
            ], 500);
        }
    }
}