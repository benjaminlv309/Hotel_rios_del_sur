from django.db import models
from django.contrib.auth.models import User
from django.core.exceptions import ValidationError
from django.utils import timezone

# Create your models here.
class Cliente(models.Model):
    usuario = models.OneToOneField(User,on_delete=models.CASCADE,related_name='cliente')
    rut = models.CharField(max_length=12, unique=True)
    telefono = models.CharField(max_length=15)
    def __str__(self):
        return self.usuario.get_full_name() or self.usuario.username

class Recepcionista(models.Model):
    usuario = models.OneToOneField(User,on_delete=models.CASCADE,related_name='recepcionista')
    rut = models.CharField(max_length=12, unique=True)
    telefono = models.CharField(max_length=15)
    def __str__(self):
        return self.usuario.get_full_name() or self.usuario.username

class Huesped(models.Model):
    nombre = models.CharField(max_length=100)
    apellido = models.CharField(max_length=100)
    rut = models.CharField(max_length=12, unique=True)
    telefono = models.CharField(max_length=15)
    correo = models.EmailField()
    def __str__(self):
        return f"{self.nombre} {self.apellido}"


class Habitacion(models.Model):
    ESTADOS = [
        ('habilitada', 'Habilitada'),
        ('fuera_servicio', 'Fuera de servicio'),
    ]
    TIPOS = [
        ('individual', 'Individual'),
        ('doble', 'Doble'),
        ('matrimonial', 'Matrimonial'),
        ('familiar', 'Familiar'),
    ]
    numero = models.PositiveIntegerField(unique=True)
    tipo = models.CharField(max_length=50, choices=TIPOS)
    capacidad = models.PositiveIntegerField()
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    estado = models.CharField(max_length=20, choices=ESTADOS, default='habilitada')
    imagen = models.CharField(
        max_length=255,
        blank=True,
        help_text='Selecciona una imagen existente en static/img.',
    )

    def __str__(self):
        return f"Habitación {self.numero} - {self.tipo}"

class Reserva(models.Model):
    ESTADOS = [
        ('pendiente', 'Pendiente'),
        ('confirmada', 'Confirmada'),
        ('en_estadia', 'En estadía'),
        ('finalizada', 'Finalizada'),
        ('cancelada', 'Cancelada'),
    ]
    cliente = models.ForeignKey(Cliente,on_delete=models.PROTECT,related_name='reservas')
    huesped = models.ForeignKey(Huesped,on_delete=models.PROTECT,related_name='reservas')
    habitacion = models.ForeignKey(Habitacion,on_delete=models.PROTECT,related_name='reservas')
    fecha_entrada = models.DateField()
    fecha_salida = models.DateField()
    cantidad_noches = models.PositiveIntegerField(default=0)
    precio_total = models.DecimalField(max_digits=12,decimal_places=2,null=True,blank=True)
    estado = models.CharField(max_length=20,choices=ESTADOS,default='pendiente')
    fecha_reserva = models.DateTimeField(default=timezone.now)
    fecha_checkin = models.DateTimeField(null=True,blank=True)
    fecha_checkout = models.DateTimeField(null=True,blank=True)


    def calcular_precio(self):
        if (
            self.fecha_entrada
            and self.fecha_salida
            and self.habitacion_id
        ):
            noches = (self.fecha_salida - self.fecha_entrada).days
            if noches > 0:
                self.cantidad_noches = noches
                self.precio_total = (self.habitacion.precio * noches)
            else:
                self.cantidad_noches = 0
                self.precio_total = None

    def clean(self):
        super().clean()
        if self.fecha_entrada and self.fecha_salida:
            if self.fecha_salida <= self.fecha_entrada:
                raise ValidationError({'fecha_salida': ('La fecha de salida debe ser posterior a la fecha de entrada.')})
        if self.habitacion_id and self.estado != 'cancelada':
            if self.habitacion.estado == 'fuera_servicio':
                raise ValidationError('No se puede reservar una habitación fuera de servicio.')
            if self.fecha_entrada and self.fecha_salida:
                reservas_existentes = Reserva.objects.filter(habitacion=self.habitacion, estado__in=['pendiente','confirmada','en_estadia'], fecha_entrada__lt=self.fecha_salida, fecha_salida__gt=self.fecha_entrada)
                if self.pk:
                    reservas_existentes = reservas_existentes.exclude(pk=self.pk)
                if reservas_existentes.exists():
                    raise ValidationError('La habitación ya tiene una reserva para las fechas seleccionadas.')

    def __str__(self):
        return (f"Reserva {self.id} - Habitación {self.habitacion.numero}")