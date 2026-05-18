<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Valida si la tabla ya fue inyectada por el archivo .sql
        if (!Schema::hasTable('mensajes_pedido')) {
            Schema::create('mensajes_pedido', function (Blueprint $table) {
                $table->bigIncrements('ID_mensaje');

                // CORRECCIÓN: Tipo de dato correcto para llaves foráneas en Laravel
                $table->unsignedBigInteger('ID_pedido');
                $table->unsignedBigInteger('ID_usuario'); // El campo se queda para tu frontend

                $table->text('mensaje')->nullable();
                $table->string('archivo_path')->nullable();
                $table->enum('tipo', ['texto', 'imagen', 'sistema'])->default('texto');
                $table->boolean('es_de_tienda')->default(false);
                $table->boolean('leido')->default(false);
                $table->timestamps();

                // SÓLO dejamos la relación con pedidos (porque pedidos sí va a existir)
                $table->foreign('ID_pedido')->references('ID_pedido')->on('pedidos')->onDelete('cascade');
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('mensajes_pedido');
    }
};