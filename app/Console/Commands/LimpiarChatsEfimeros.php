<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class LimpiarChatsEfimeros extends Command
{
    // Cambiamos la firma para que sea "saborytecapi"
    protected $signature = 'saborytecapi:limpiar-chats';

    protected $description = 'Borra chats y comprobantes antiguos de Saborytec API';

    public function handle()
    {
        try {
            // Nombre exacto de tu tabla
            $tabla = 'mensajes_pedido';

            // 1. Obtener archivos de mensajes con más de 24 horas
            $archivos = DB::table($tabla)
                ->where('created_at', '<', now()->subHours(24))
                ->whereNotNull('archivo_path')
                ->pluck('archivo_path');

            // 2. Borrar archivos del storage
            foreach ($archivos as $path) {
                if (Storage::disk('public')->exists($path)) {
                    Storage::disk('public')->delete($path);
                }
            }

            // 3. Borrar registros de la base de datos
            $filasBorradas = DB::table($tabla)
                ->where('created_at', '<', now()->subHours(24))
                //->where('created_at', '<', now()->subSeconds(1))
                ->delete();

            $this->info("SaborytecAPI: Se eliminaron {$filasBorradas} registros antiguos.");
            
        } catch (\Exception $e) {
            $this->error("Error en la limpieza: " . $e->getMessage());
        }
    }
}