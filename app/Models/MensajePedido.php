<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MensajePedido extends Model
{
    use HasFactory;

    protected $table = 'mensajes_pedido';
    protected $primaryKey = 'ID_mensaje';

    protected $fillable = [
        'ID_pedido',
        'ID_usuario',
        'mensaje',
        'archivo_path',
        'tipo',
        'es_de_tienda',
        'leido'
    ];

    /**
     * Relación: El mensaje pertenece a un pedido.
     */
    public function pedido()
    {
        return $this->belongsTo(Pedido::class, 'ID_pedido', 'ID_pedido');
    }

    /**
     * Relación: El mensaje pertenece a un usuario (quien lo envió).
     * Nota: Asegúrate de que tu modelo de usuario se llame 'User' o 'Usuario'.
     */
    public function usuario()
    {
        return $this->belongsTo(Usuario::class, 'ID_usuario', 'ID_usuario');
    }
}