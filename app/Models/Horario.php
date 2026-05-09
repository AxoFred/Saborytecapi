<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Horario extends Model
{
    use HasFactory;

    protected $table = 'horarios';
    protected $primaryKey = 'ID_horario';

    public $timestamps = false;

    // Para que coincida con tus enums y campos de la BD
    protected $fillable = [
        'ID_tienda',
        'dia_semana',
        'hora_apertura',
        'hora_cierre',
        'estado'
    ];

    // Relación con la tienda
    public function tienda()
    {
        return $this->belongsTo(Tienda::class, 'ID_tienda');
    }
}