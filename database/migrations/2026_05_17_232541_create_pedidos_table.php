<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
public function up(): void
    {
        // Si la tabla NO existe, la creamos. Si ya existe, Laravel no hará nada y no dará error.
        if (!Schema::hasTable('pedidos')) {
            Schema::create('pedidos', function (Blueprint $table) {
                $table->id('ID_pedido');
                $table->unsignedBigInteger('ID_usuario');
                $table->unsignedBigInteger('ID_tienda')->nullable();
                $table->string('nombre_cliente');
                $table->decimal('total', 10, 2);
                $table->string('metodo_pago');
                $table->text('notas_pedido')->nullable();
                $table->string('estado')->default('pendiente');
                $table->text('motivo_cancelacion')->nullable();
                $table->string('comprobante')->nullable();
                $table->timestamps();
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('pedidos');
    }
};