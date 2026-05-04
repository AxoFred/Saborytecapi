<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Carrito extends Model
{
    use HasFactory;

    // Nombre exacto de la tabla que creaste en phpMyAdmin
    protected $table = 'carrito'; 
    
    // Tu llave primaria personalizada
    protected $primaryKey = 'ID_carrito';

    // Campos que permitimos llenar (deben coincidir con tus columnas en phpMyAdmin)
    protected $fillable = [
        'ID_usuario',
        'ID_producto',
        'ID_tienda',
        'cantidad'
    ];
}