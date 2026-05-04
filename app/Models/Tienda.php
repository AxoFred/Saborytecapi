<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tienda extends Model
{
    protected $table = 'tiendas';
    protected $primaryKey = 'ID_tienda';

    public $timestamps = false;

    protected $fillable = [
        'nombre',
        'descripcion',
        'logo',
        'estado',
        'ID_usuario_vendedor',
        'visible',
        'facebook',
        'instagram',
        'whatsapp',
        'tiktok',
        'portada',
        'clabe',
        'banco',
        'titular_cuenta',
        'aprobacion'
    ];
}