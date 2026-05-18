<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
public function up(): void
{
    Schema::create('usuarios', function (Blueprint $table) {
        $table->id('ID_usuario'); // Tu llave primaria personalizada
        $table->string('nombre');
        $table->string('Apaterno');
        $table->string('Amaterno');
        $table->string('correo')->unique();
        $table->string('password');
        $table->string('telefono')->nullable();
        $table->string('estado')->default('activo');
        $table->integer('ID_rol');
        $table->integer('visible')->default(1);
    });
}

public function down(): void
{
    Schema::dropIfExists('usuarios');
}
};
