<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Calificacion extends Model
{
    protected $table = 'calificaciones';
    protected $primaryKey = 'ID_calificacion';
    public $timestamps = false;

    protected $fillable = [
        'ID_pedido',
        'ID_tienda',
        'ID_usuario',
        'puntuacion',
        'comentario'
    ];

    /**
     * Relación: Una calificación pertenece a un pedido.
     */
    public function pedido(): BelongsTo
    {
        return $this->belongsTo(Pedido::class, 'ID_pedido', 'ID_pedido');
    }

    /**
     * Relación: Una calificación pertenece a una tienda.
     */
    public function tienda(): BelongsTo
    {
        return $this->belongsTo(Tienda::class, 'ID_tienda', 'ID_tienda');
    }

    /**
     * Relación: Una calificación pertenece a un usuario (cliente).
     */
    public function usuario(): BelongsTo
    {
        return $this->belongsTo(Usuario::class, 'ID_usuario', 'ID_usuario');
    }
}