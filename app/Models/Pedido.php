<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pedido extends Model
{
    use HasFactory;

    protected $table = 'pedidos'; // Nombre de la tabla en la BD
    protected $primaryKey = 'ID_pedido'; // Tu llave primaria personalizada
// Dentro de App\Models\Pedido.php
    public $timestamps = false;
    // Campos que Laravel tiene permiso de llenar automáticamente
    protected $fillable = [
        'ID_usuario',
        'ID_tienda',
        'nombre_cliente',
        'total',
        'metodo_pago',
        'notas_pedido',
        'estado',
        'motivo_cancelacion',
        'comprobante'
    ];

    /**
     * RELACIONES
     */

    // Un pedido tiene muchos productos detallados
    public function detalles()
    {
        return $this->hasMany(DetallePedido::class, 'ID_pedido', 'ID_pedido');
    }

    // Un pedido pertenece a un usuario (cliente)
    public function usuario()
    {
        return $this->belongsTo(Usuario::class, 'ID_usuario', 'ID_usuario');
    }

    // Un pedido pertenece a una tienda específica
    public function tienda()
    {
        return $this->belongsTo(Tienda::class, 'ID_tienda', 'ID_tienda');
    }

    public function calificacion()
    {
        return $this->hasOne(Calificacion::class, 'ID_pedido', 'ID_pedido');
    }
}