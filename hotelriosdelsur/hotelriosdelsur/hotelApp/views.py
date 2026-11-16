from datetime import date
from django.contrib import messages
from django.contrib.auth import login
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth.views import LoginView, LogoutView
from django.core.exceptions import ValidationError
from django.db import transaction
from django.db.models import Sum
from django.shortcuts import get_object_or_404, redirect, render
from django.urls import reverse_lazy
from django.utils import timezone
from .forms import (HabitacionForm,HuespedForm,RegistroClienteForm,ReservaClienteForm,ReservaForm,)
from .models import Cliente, Habitacion, Huesped, Reserva

def inicio(request):
    return render(request, 'index.html')

def lista_habitaciones(request):
    habitaciones = Habitacion.objects.filter(estado='habilitada').order_by('numero')
    fecha_entrada = request.GET.get('fecha_entrada', '')
    fecha_salida = request.GET.get('fecha_salida', '')
    error = None
    if fecha_entrada and fecha_salida:
        try:
            entrada = date.fromisoformat(fecha_entrada)
            salida = date.fromisoformat(fecha_salida)
            if entrada < timezone.localdate():
                error = 'La fecha de entrada no puede ser anterior a hoy.'
            elif salida <= entrada:
                error = 'La fecha de salida debe ser posterior a la entrada.'
            else:
                reservas_ocupadas = Reserva.objects.filter(
                    estado__in=[
                        'pendiente',
                        'confirmada',
                        'en_estadia'
                    ],
                    fecha_entrada__lt=salida,
                    fecha_salida__gt=entrada
                ).values_list(
                    'habitacion_id',
                    flat=True
                )
                habitaciones = habitaciones.exclude(id__in=reservas_ocupadas)
        except ValueError:
            error = 'Las fechas ingresadas no son válidas.'
    elif fecha_entrada or fecha_salida:
        error = 'Debes seleccionar ambas fechas.'
    return render(request,'habitaciones/lista.html',
        {
            'habitaciones': habitaciones,
            'fecha_entrada': fecha_entrada,
            'fecha_salida': fecha_salida,
            'error': error
        }
    )


def es_administrador(usuario):
    return usuario.is_authenticated and usuario.is_staff

@user_passes_test(es_administrador, login_url='/admin/login/')
def administrar_habitaciones(request):
    habitaciones = Habitacion.objects.all().order_by('numero')
    return render(request,'admin_hotel/habitaciones.html',{'habitaciones': habitaciones})


def _guardar_formulario(request, formulario_class, plantilla, titulo, destino, instancia=None):
    es_post = request.method == 'POST'
    formulario = formulario_class(
        request.POST if es_post else None,
        request.FILES if es_post else None,
        instance=instancia,
    )
    if es_post and formulario.is_valid():
        formulario.save()
        return redirect(destino)
    return render(
        request,
        plantilla,
        {'formulario': formulario, 'titulo': titulo},
    )


@user_passes_test(es_administrador, login_url='/admin/login/')
def crear_habitacion(request):
    return _guardar_formulario(
        request,
        HabitacionForm,
        'habitaciones/formulario.html',
        'Registrar habitación',
        'administrar_habitaciones',
    )

@user_passes_test(es_administrador, login_url='/admin/login/')
def editar_habitacion(request, id):
    habitacion = get_object_or_404(Habitacion, id=id)
    return _guardar_formulario(
        request,
        HabitacionForm,
        'habitaciones/formulario.html',
        'Editar habitación',
        'administrar_habitaciones',
        habitacion,
    )


@user_passes_test(es_administrador, login_url='/admin/login/')
def dashboard(request):
    total_habitaciones = Habitacion.objects.count()
    habitaciones_habilitadas = Habitacion.objects.filter(estado='habilitada').count()
    habitaciones_fuera_servicio = Habitacion.objects.filter(estado='fuera_servicio').count()
    total_reservas = Reserva.objects.count()
    reservas_pendientes = Reserva.objects.filter(estado='pendiente').count()
    reservas_confirmadas = Reserva.objects.filter(estado='confirmada').count()
    estadias_activas = Reserva.objects.filter(estado='en_estadia').count()
    ingresos_confirmados = Reserva.objects.filter(estado__in=['confirmada', 'en_estadia']).aggregate(total=Sum('precio_total'))['total'] or 0
    ingresos_finalizados = Reserva.objects.filter(estado='finalizada').aggregate(total=Sum('precio_total'))['total'] or 0
    contexto = {
        'total_habitaciones': total_habitaciones,
        'habitaciones_habilitadas': habitaciones_habilitadas,
        'habitaciones_fuera_servicio': habitaciones_fuera_servicio,
        'total_reservas': total_reservas,
        'reservas_pendientes': reservas_pendientes,
        'reservas_confirmadas': reservas_confirmadas,
        'estadias_activas': estadias_activas,
        'ingresos_confirmados': ingresos_confirmados,
        'ingresos_finalizados': ingresos_finalizados,
    }
    return render(request,'admin_hotel/dashboard.html',contexto)

@user_passes_test(es_administrador, login_url='/admin/login/')
def administrar_huespedes(request):

    huespedes = Huesped.objects.all().order_by(
        'apellido',
        'nombre'
    )
    return render(request,'huespedes/lista.html',{'huespedes': huespedes})

@user_passes_test(es_administrador, login_url='/admin/login/')
def crear_huesped(request):
    return _guardar_formulario(
        request,
        HuespedForm,
        'huespedes/formulario.html',
        'Registrar huésped',
        'administrar_huespedes',
    )


@user_passes_test(es_administrador, login_url='/admin/login/')
def editar_huesped(request, id):
    huesped = get_object_or_404(Huesped, id=id)
    return _guardar_formulario(
        request,
        HuespedForm,
        'huespedes/formulario.html',
        'Editar huésped',
        'administrar_huespedes',
        huesped,
    )


@user_passes_test(es_administrador, login_url='/admin/login/')
def administrar_reservas(request):

    reservas = Reserva.objects.select_related(
        'cliente',
        'huesped',
        'habitacion'
    ).order_by('-fecha_reserva')

    return render(
        request,
        'reservas/lista.html',
        {
            'reservas': reservas
        }
    )

@user_passes_test(es_administrador, login_url='/admin/login/')
def crear_reserva(request):
    if request.method == 'POST':
        formulario = ReservaForm(request.POST)
        if formulario.is_valid():
            reserva = formulario.save(commit=False)
            reserva.estado = 'pendiente'
            try:
                with transaction.atomic():
                    habitacion = Habitacion.objects.select_for_update().get(
                        pk=reserva.habitacion_id
                    )
                    reserva.habitacion = habitacion
                    reserva.full_clean()
                    reserva.calcular_precio()
                    reserva.save()
                messages.success(
                    request,
                    'La reserva se registró correctamente.'
                )
                return redirect('administrar_reservas')
            except ValidationError as error:
                if hasattr(error, 'message_dict'):
                    for campo, errores in error.message_dict.items():
                        if campo in formulario.fields:
                            for mensaje in errores:
                                formulario.add_error(campo, mensaje)
                        else:
                            for mensaje in errores:
                                formulario.add_error(None, mensaje)
                else:
                    for mensaje in error.messages:
                        formulario.add_error(None, mensaje)
    else:
        formulario = ReservaForm()
    return render(
        request,
        'reservas/formulario.html',
        {
            'formulario': formulario,
            'titulo': 'Registrar reserva'
        }
    )

@user_passes_test(es_administrador, login_url='/admin/login/')
def confirmar_reserva(request, id):
    if request.method != 'POST':
        return redirect('administrar_reservas')
    with transaction.atomic():
        reserva = get_object_or_404(
            Reserva.objects.select_for_update(),
            id=id
        )
        if reserva.estado == 'pendiente':
            reserva.estado = 'confirmada'
            reserva.save(update_fields=['estado'])
            messages.success(request,'La reserva fue confirmada correctamente.')
        else:
            messages.error(request,'Solo se pueden confirmar reservas pendientes.')
    return redirect('administrar_reservas')

@user_passes_test(es_administrador, login_url='/admin/login/')
def cancelar_reserva(request, id):
    if request.method != 'POST':
        return redirect('administrar_reservas')
    with transaction.atomic():
        reserva = get_object_or_404(
            Reserva.objects.select_for_update(),
            id=id
        )
        if reserva.estado in ['pendiente', 'confirmada']:
            reserva.estado = 'cancelada'
            reserva.save(update_fields=['estado'])
            messages.success(request,'La reserva fue cancelada correctamente.')
        else:
            messages.error(request,'Esta reserva no se puede cancelar.')
    return redirect('administrar_reservas')

    
@user_passes_test(es_administrador, login_url='/admin/login/')
def administrar_estadias(request):
    reservas = Reserva.objects.select_related(
        'cliente',
        'huesped',
        'habitacion'
    ).filter(
        estado__in=['confirmada', 'en_estadia', 'finalizada']
    ).order_by('-fecha_entrada')
    return render(request,'admin_hotel/estadias.html',{'reservas': reservas})

@user_passes_test(es_administrador, login_url='/admin/login/')
def realizar_checkin(request, id):
    if request.method != 'POST':
        return redirect('administrar_estadias')
    with transaction.atomic():
        reserva = get_object_or_404(
            Reserva.objects.select_for_update(),
            id=id
        )
        hoy = timezone.localdate()
        if reserva.estado != 'confirmada':
            messages.error(
                request,
                'Solo se puede realizar check-in en reservas confirmadas.'
            )
        elif hoy < reserva.fecha_entrada:
            messages.error(
                request,
                'Todavía no ha llegado la fecha de entrada.'
            )
        elif hoy >= reserva.fecha_salida:
            messages.error(
                request,
                'La fecha de salida ya llegó. Revisa la reserva antes de registrar el ingreso.'
            )
        else:
            reserva.estado = 'en_estadia'
            reserva.fecha_checkin = timezone.now()
            reserva.save(update_fields=['estado', 'fecha_checkin'])
            messages.success(request,'Check-in realizado correctamente.')
    return redirect('administrar_estadias')

@user_passes_test(es_administrador, login_url='/admin/login/')
def realizar_checkout(request, id):
    if request.method != 'POST':
        return redirect('administrar_estadias')
    with transaction.atomic():
        reserva = get_object_or_404(
            Reserva.objects.select_for_update(),
            id=id
        )
        hoy = timezone.localdate()
        if reserva.estado != 'en_estadia':
            messages.error(request,'Solo se puede realizar check-out en reservas que están en estadía.')
        elif hoy < reserva.fecha_salida:
            messages.error(request,'Todavía no ha llegado la fecha de salida.')
        else:
            reserva.estado = 'finalizada'
            reserva.fecha_checkout = timezone.now()
            reserva.save(update_fields=['estado', 'fecha_checkout'])
            messages.success(request,'Check-out realizado correctamente.')
    return redirect('administrar_estadias')

def registrar_cliente(request):
    if request.user.is_authenticated:
        return redirect('inicio')
    if request.method == 'POST':
        formulario = RegistroClienteForm(request.POST)
        if formulario.is_valid():
            usuario = formulario.save()
            login(request, usuario)
            return redirect('inicio')
    else:
        formulario = RegistroClienteForm()
    return render(
        request,
        'usuarios/registro.html',
        {
            'formulario': formulario
        }
    )

class IniciarSesionView(LoginView):
    template_name = 'usuarios/login.html'
    redirect_authenticated_user = True
    def get_success_url(self):
        if self.request.user.is_staff:
            return reverse_lazy('dashboard')
        return reverse_lazy('inicio')

class CerrarSesionView(LogoutView):
    next_page = reverse_lazy('inicio')

@login_required(login_url='iniciar_sesion')
def reservar_habitacion(request, id):
    habitacion = get_object_or_404(
        Habitacion,
        id=id,
        estado='habilitada'
    )
    cliente = Cliente.objects.filter(usuario=request.user).first()
    if cliente is None:
        messages.error(
            request,
            'Necesitas una cuenta de cliente para reservar.'
        )
        return redirect('lista_habitaciones')
    if request.method == 'POST':
        formulario = ReservaClienteForm(request.POST)
        if formulario.is_valid():
            try:
                with transaction.atomic():
                    habitacion_bloqueada = get_object_or_404(
                        Habitacion.objects.select_for_update(),
                        id=id
                    )
                    if habitacion_bloqueada.estado != 'habilitada':
                        raise ValidationError('La habitación está fuera de servicio.')
                    usuario = request.user
                    huesped, creado = Huesped.objects.get_or_create(
                        rut=cliente.rut,
                        defaults={
                            'nombre': usuario.first_name,
                            'apellido': usuario.last_name,
                            'telefono': cliente.telefono,
                            'correo': usuario.email
                        }
                    )
                    reserva = formulario.save(commit=False)
                    reserva.cliente = cliente
                    reserva.huesped = huesped
                    reserva.habitacion = habitacion_bloqueada
                    reserva.estado = 'pendiente'
                    reserva.full_clean()
                    reserva.calcular_precio()
                    reserva.save()
                messages.success(request,'Tu reserva fue registrada correctamente.')
                return redirect('mis_reservas')
            except ValidationError as error:
                for mensaje in error.messages:
                    formulario.add_error(None, mensaje)
    else:
        fecha_entrada = request.GET.get('fecha_entrada', '')
        fecha_salida = request.GET.get('fecha_salida', '')
        formulario = ReservaClienteForm(
            initial={
                'fecha_entrada': fecha_entrada,
                'fecha_salida': fecha_salida
            }
        )
    return render(request,
        'reservas/reservar.html',
        {
            'habitacion': habitacion,
            'formulario': formulario,
            'precio_noche': str(habitacion.precio)
        }
    )

@login_required(login_url='iniciar_sesion')
def mis_reservas(request):
    cliente = Cliente.objects.filter(usuario=request.user).first()
    if cliente is None:
        messages.error(request,'No tienes un perfil de cliente registrado.')
        return redirect('inicio')
    reservas = Reserva.objects.filter(cliente=cliente).select_related('habitacion','huesped').order_by('-fecha_reserva')
    return render(request,'reservas/mis_reservas.html',{'reservas': reservas,'hoy': timezone.localdate()})


@login_required(login_url='iniciar_sesion')
def cancelar_reserva_cliente(request, id):
    if request.method != 'POST':
        return redirect('mis_reservas')
    cliente = Cliente.objects.filter(
        usuario=request.user
    ).first()
    if cliente is None:
        messages.error(request,'No tienes un perfil de cliente registrado.')
        return redirect('inicio')
    with transaction.atomic():
        reserva = get_object_or_404(
            Reserva.objects.select_for_update(),
            id=id,
            cliente=cliente
        )
        if reserva.estado not in ['pendiente', 'confirmada']:
            messages.error(request,'Esta reserva no se puede cancelar.')
        elif reserva.fecha_entrada <= timezone.localdate():
            messages.error(request,'No puedes cancelar una reserva cuya fecha de entrada ya llegó.')
        else:
            reserva.estado = 'cancelada'
            reserva.save(update_fields=['estado'])
            messages.success(request,'Tu reserva fue cancelada correctamente.')
    return redirect('mis_reservas')