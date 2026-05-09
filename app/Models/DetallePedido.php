<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetallePedido extends Model
{
    use HasFactory;

    protected $table = 'detalle_pedidos';
    protected $primaryKey = 'ID_detalle';

    // Desactivamos timestamps porque esta tabla no suele necesitarlos 
    // (ya los tiene la tabla padre 'pedidos')
    public $timestamps = false;

    protected $fillable = [
        'ID_pedido',
        'ID_producto',
        'cantidad',
        'precio_unitario',
        'subtotal'
    ];

    /**
     * RELACIONES
     */

    // El detalle pertenece a un pedido "padre"
    public function pedido()
    {
        return $this->belongsTo(Pedido::class, 'ID_pedido', 'ID_pedido');
    }

    // El detalle está amarrado a un producto del catálogo
    public function producto()
    {
        return $this->belongsTo(Producto::class, 'ID_producto', 'ID_producto');
    }
}