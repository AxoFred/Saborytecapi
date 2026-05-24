<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class WeatherController extends Controller
{
    public function index(Request $request)
    {
        try {

            // Obtener coordenadas del frontend
            $lat = $request->query('lat');
            $lon = $request->query('lon');

            // Validar coordenadas
            if (!$lat || !$lon) {
                return response()->json([
                    'success' => false,
                    'message' => 'Latitud y longitud requeridas'
                ], 400);
            }

            // Consumir WeatherAPI
            $response = Http::get(
                'https://api.weatherapi.com/v1/current.json',
                [
                    'key' => env('WEATHER_API_KEY'),
                    'q' => $lat . ',' . $lon,
                    'lang' => 'es'
                ]
            );

            $data = $response->json();

            // Obtener temperatura
            $temp = $data['current']['temp_c'];

            // Recomendaciones automáticas
            if ($temp >= 28) {

                $recommendation = "🥤 Recomendamos bebidas frías";

            } elseif ($temp <= 18) {

                $recommendation = "☕ Recomendamos café caliente";

            } else {

                $recommendation = "🍔 Ideal para cualquier comida";

            }

            return response()->json([
                'success' => true,
                'city' => $data['location']['name'],
                'country' => $data['location']['country'],
                'temperature' => $temp,
                'condition' => $data['current']['condition']['text'],
                'icon' => 'https:' . $data['current']['condition']['icon'],
                'humidity' => $data['current']['humidity'],
                'chance_of_rain' => $data['current']['chance_of_rain'],
                'recommendation' => $recommendation
            ]);

        } catch (\Exception $e) {

            return response()->json([
                'success' => false,
                'message' => 'Error al obtener clima',
                'error' => $e->getMessage()
            ], 500);

        }
    }
}