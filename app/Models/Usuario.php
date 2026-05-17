<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class Usuario extends Authenticatable
{
    use HasApiTokens, Notifiable;

    public $timestamps = false;
    protected $table = 'usuarios';
    protected $primaryKey = 'ID_usuario';

    protected $fillable = [
        'nombre',
        'Apaterno',
        'Amaterno',
        'correo',
        'password',
        'telefono',
        'estado',
        'ID_rol',
        'visible'
    ];

    protected $hidden = [
        'password'
    ];

    // Personalización para usar 'correo' en lugar de 'email'
    public function getAuthIdentifierName()
    {
        return 'correo';
    }

    public function getEmailForPasswordReset()
    {
        return $this->correo;
    }

    public function routeNotificationForMail($notification = null)
    {
        return $this->correo;
    }
}