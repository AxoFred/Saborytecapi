<?php 
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Producto extends Model
{
    protected $primaryKey = 'ID_producto';

    protected $fillable = [
        'nombre',
        'marca',
        'descripcion',
        'precio',
        'imagen',
        'estado',
        'disponible',
        'visible',
        'ID_categoria',
        'ID_tienda'
    ];

    // Relación con la tienda
    public function tienda()
    {
        return $this->belongsTo(Tienda::class, 'ID_tienda');
    }

}
