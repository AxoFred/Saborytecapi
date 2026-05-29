<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use App\Models\Producto;
use App\Models\DetallePedido;

class ChatbotController extends Controller
{
    public function chat(Request $request)
    {
        $pregunta = mb_strtolower($request->pregunta, 'UTF-8');

        $contexto = "";

        /*
        |--------------------------------------------------------------------------
        | PRODUCTO MÁS VENDIDO
        |--------------------------------------------------------------------------
        */
        if (
            str_contains($pregunta, 'más vendido') ||
            str_contains($pregunta, 'mas vendido')
        ) {

            $producto = DetallePedido::selectRaw('ID_producto, SUM(cantidad) as total_vendidos')
                ->groupBy('ID_producto')
                ->orderByDesc('total_vendidos')
                ->with('producto')
                ->first();

            $nombreProducto = $producto->producto->nombre ?? 'No disponible';

            $contexto =
                "El producto más vendido actualmente es {$nombreProducto}.";
        }

        /*
        |--------------------------------------------------------------------------
        | BEBIDA RECOMENDADA
        |--------------------------------------------------------------------------
        */
        elseif (
            str_contains($pregunta, 'bebida') ||
            str_contains($pregunta, 'recomiendas')
        ) {

            $bebida = Producto::where('nombre', 'like', '%boing%')
                ->orWhere('nombre', 'like', '%coca%')
                ->orWhere('nombre', 'like', '%café%')
                ->orWhere('nombre', 'like', '%cafe%')
                ->first();

            $nombreBebida = $bebida->nombre ?? 'Boing de mango';

            $contexto =
                "La bebida más recomendada es {$nombreBebida} por su popularidad entre estudiantes.";
        }

        /*
        |--------------------------------------------------------------------------
        | VER CARRITO
        |--------------------------------------------------------------------------
        */
        elseif (
            str_contains($pregunta, 'carrito')
        ) {

            $contexto =
                "Puedes ver tu carrito presionando el ícono del carrito en la parte superior de la aplicación.";
        }

        /*
        |--------------------------------------------------------------------------
        | REALIZAR PEDIDO
        |--------------------------------------------------------------------------
        */
        elseif (
            str_contains($pregunta, 'pedido')
        ) {

            $contexto =
                "Para realizar un pedido debes seleccionar productos, agregarlos al carrito y confirmar tu compra.";
        }

        /*
        |--------------------------------------------------------------------------
        | PRODUCTOS DISPONIBLES
        |--------------------------------------------------------------------------
        */
        elseif (
            str_contains($pregunta, 'disponibles') ||
            str_contains($pregunta, 'productos')
        ) {

            $productos = Producto::where('disponible', 1)
                ->where('visible', 1)
                ->pluck('nombre')
                ->take(5)
                ->implode(', ');

            $contexto =
                "Los productos disponibles hoy son: {$productos}.";
        }

        /*
        |--------------------------------------------------------------------------
        | PREGUNTA NO VÁLIDA
        |--------------------------------------------------------------------------
        */
        else {

            return response()->json([
                'success' => false,
                'respuesta' =>
                    'Solo puedo responder preguntas relacionadas con Saborytec.'
            ]);
        }

        /*
        |--------------------------------------------------------------------------
        | PETICIÓN A GROQ
        |--------------------------------------------------------------------------
        */
        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . env('GROQ_API_KEY'),
            'Content-Type' => 'application/json'
        ])->post('https://api.groq.com/openai/v1/chat/completions', [

            'model' => 'llama-3.1-8b-instant',

            'messages' => [

                [
                    'role' => 'system',
                    'content' =>
                        'Eres un chatbot de Saborytec. Responde de manera breve, amigable y profesional.'
                ],

                [
                    'role' => 'user',
                    'content' => $contexto
                ]
            ]
        ]);

        /*
        |--------------------------------------------------------------------------
        | VALIDAR RESPUESTA DE GROQ
        |--------------------------------------------------------------------------
        */
        if (!$response->successful()) {

            return response()->json([
                'success' => false,
                'error' => $response->json()
            ]);
        }

        /*
        |--------------------------------------------------------------------------
        | RESPUESTA FINAL
        |--------------------------------------------------------------------------
        */
        return response()->json([
            'success' => true,
            'respuesta' =>
                $response->json()['choices'][0]['message']['content']
        ]);
    }
}