<?php

namespace Database\Seeders;

use App\Models\Usuario;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Creamos el usuario de prueba de forma manual usando tus campos reales
        Usuario::create([
            'nombre'   => 'Fredy',
            'Apaterno' => 'Cano',
            'Amaterno' => 'Lopez',
            'correo'   => 'AxoFred@smartin.tecnm.mx',
            'password' => Hash::make('Password'), 
            'telefono' => '2481701307',
            'estado'   => 'activo',
            'ID_rol'   => 1,
            'visible'  => 1
        ]);
    }
}
