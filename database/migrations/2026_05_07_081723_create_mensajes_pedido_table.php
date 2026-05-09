<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
public function up(): void
{
    Schema::create('mensajes_pedido', function (Blueprint $table) {
        // El ID de esta tabla puede ser el estándar de Laravel
        $table->id('ID_mensaje');

        // IMPORTANTE: Definimos como 'integer' simple para que sea idéntico a tu imagen
        $table->integer('ID_pedido');
        $table->integer('ID_usuario');

        $table->text('mensaje')->nullable();
        $table->string('archivo_path')->nullable();
        $table->enum('tipo', ['texto', 'imagen', 'sistema'])->default('texto');
        $table->boolean('es_de_tienda')->default(false);
        $table->boolean('leido')->default(false);
        $table->timestamps();

        // Creamos las relaciones manualmente
        $table->foreign('ID_pedido')->references('ID_pedido')->on('pedidos')->onDelete('cascade');
        $table->foreign('ID_usuario')->references('ID_usuario')->on('usuarios');
    });
}

    public function down(): void
    {
        Schema::dropIfExists('mensajes_pedido');
    }
};