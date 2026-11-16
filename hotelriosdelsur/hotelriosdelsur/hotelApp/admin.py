from django.contrib import admin
from .models import Cliente, Recepcionista, Huesped, Habitacion, Reserva

# Register your models here.
@admin.register(Cliente)
class ClienteAdmin(admin.ModelAdmin):
    list_display = ('id', 'usuario', 'rut', 'telefono')
    search_fields = ('usuario__username', 'rut')

@admin.register(Recepcionista)
class RecepcionistaAdmin(admin.ModelAdmin):
    list_display = ('id', 'usuario', 'rut', 'telefono')
    search_fields = ('usuario__username', 'rut')

@admin.register(Huesped)
class HuespedAdmin(admin.ModelAdmin):
    list_display = ('id', 'nombre', 'apellido', 'rut', 'telefono', 'correo')
    search_fields = ('nombre', 'apellido', 'rut')

@admin.register(Habitacion)
class HabitacionAdmin(admin.ModelAdmin):
    list_display = ('id', 'numero', 'tipo', 'capacidad', 'precio', 'estado')
    list_filter = ('tipo', 'estado')
    search_fields = ('=numero', 'tipo')

@admin.register(Reserva)
class ReservaAdmin(admin.ModelAdmin):
    list_display = ('id','cliente','huesped','habitacion','fecha_entrada','fecha_salida','estado')
    list_filter = ('estado', 'fecha_entrada', 'fecha_salida')
    search_fields = ('cliente__usuario__username','huesped__rut','=habitacion__numero')
    readonly_fields = ('fecha_reserva','fecha_checkin','fecha_checkout')