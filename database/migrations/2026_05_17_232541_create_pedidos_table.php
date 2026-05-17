<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pedidos', function (Blueprint $table) {
            // IMPORTANTE: Usamos bigIncrements para que sea compatible con las llaves foráneas de Laravel
            $table->bigIncrements('ID_pedido'); 

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

    public function down(): void
    {
        Schema::dropIfExists('pedidos');
    }
};