from django import forms
from django.conf import settings
from pathlib import Path
from .models import Habitacion
from .models import Huesped
from .models import Reserva
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm
from django.db import transaction
from .models import Cliente
from django.utils import timezone

class HabitacionForm(forms.ModelForm):
    imagen = forms.ChoiceField(
        required=False,
        label='Imagen',
        help_text='Selecciona una imagen existente en static/img.',
        choices=[('', 'Sin imagen')],
        widget=forms.Select(attrs={'class': 'form-select'}),
    )
    class Meta:
        model = Habitacion
        fields = ['numero','tipo','capacidad','precio','estado','imagen']
        widgets = {
            'numero': forms.NumberInput(attrs={'class': 'form-control','min': '1'}),
            'tipo': forms.Select(attrs={'class': 'form-select'}),
            'capacidad': forms.NumberInput(attrs={'class': 'form-control','min': '1'}),
            'precio': forms.NumberInput(attrs={'class': 'form-control','min': '0.01','step': '0.01'}),
            'estado': forms.Select(attrs={'class': 'form-select'}),
        }
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        imagenes = [('', 'Sin imagen')]
        extensiones_validas = {'.jpg', '.jpeg', '.png', '.gif', '.webp'}
        for carpeta_estatica in settings.STATICFILES_DIRS:
            carpeta_imagenes = Path(carpeta_estatica) / 'img'
            if carpeta_imagenes.is_dir():
                imagenes.extend(
                    (archivo.name, archivo.name)
                    for archivo in sorted(carpeta_imagenes.iterdir())
                    if archivo.is_file()
                    and archivo.suffix.lower() in extensiones_validas
                )
        self.fields['imagen'].choices = imagenes
    def clean_capacidad(self):
        capacidad = self.cleaned_data['capacidad']
        if capacidad < 1:
            raise forms.ValidationError('La capacidad debe ser mayor que cero.')
        return capacidad
    def clean_precio(self):
        precio = self.cleaned_data['precio']
        if precio <= 0:
            raise forms.ValidationError('El precio debe ser mayor que cero.')
        return precio
    
class HuespedForm(forms.ModelForm):
    class Meta:
        model = Huesped
        fields = [
            'nombre',
            'apellido',
            'rut',
            'telefono',
            'correo'
        ]
        widgets = {'nombre': forms.TextInput(attrs={'class': 'form-control','placeholder': 'Ingrese el nombre'}),
            'apellido': forms.TextInput(attrs={'class': 'form-control','placeholder': 'Ingrese el apellido'}),
            'rut': forms.TextInput(attrs={'class': 'form-control','placeholder': 'Ejemplo: 12345678-9'}),
            'telefono': forms.TextInput(attrs={'class': 'form-control','placeholder': 'Ejemplo: +56912345678'}),
            'correo': forms.EmailInput(attrs={'class': 'form-control','placeholder': 'correo@ejemplo.com'}),
        }
        labels = {
            'nombre': 'Nombre',
            'apellido': 'Apellido',
            'rut': 'RUT',
            'telefono': 'Teléfono',
            'correo': 'Correo electrónico'
        }

class ReservaForm(forms.ModelForm):
    class Meta:
        model = Reserva
        fields = [
            'cliente',
            'huesped',
            'habitacion',
            'fecha_entrada',
            'fecha_salida'
        ]
        widgets = {'cliente': forms.Select(attrs={'class': 'form-select'}),
            'huesped': forms.Select(attrs={'class': 'form-select'}),
            'habitacion': forms.Select(attrs={'class': 'form-select'}),
            'fecha_entrada': forms.DateInput(
                attrs={
                    'class': 'form-control',
                    'type': 'date'
                },
                format='%Y-%m-%d'
            ),
            'fecha_salida': forms.DateInput(
                attrs={
                    'class': 'form-control',
                    'type': 'date'
                },
                format='%Y-%m-%d'
            ),
        }
        labels = {
            'cliente': 'Cliente',
            'huesped': 'Huésped',
            'habitacion': 'Habitación',
            'fecha_entrada': 'Fecha de entrada',
            'fecha_salida': 'Fecha de salida'
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        for campo in ('cliente', 'huesped', 'habitacion'):
            self.fields[campo].empty_label = 'Selecciona una opción'

        self.fields['habitacion'].queryset = (
            self.fields['habitacion'].queryset.filter(
                estado='habilitada'
            ).order_by('numero')
        )

class RegistroClienteForm(UserCreationForm):
    first_name = forms.CharField(
        label='Nombre',
        max_length=150,
        widget=forms.TextInput(attrs={
            'class': 'form-control'
        })
    )
    last_name = forms.CharField(
        label='Apellido',
        max_length=150,
        widget=forms.TextInput(attrs={
            'class': 'form-control'
        })
    )
    email = forms.EmailField(
        label='Correo electrónico',
        widget=forms.EmailInput(attrs={
            'class': 'form-control'
        })
    )
    rut = forms.CharField(
        label='RUT',
        max_length=12,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': '12345678-9'
        })
    )
    telefono = forms.CharField(
        label='Teléfono',
        max_length=15,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': '+56912345678'
        })
    )
    class Meta:
        model = User
        fields = [
            'username',
            'first_name',
            'last_name',
            'email',
            'rut',
            'telefono',
            'password1',
            'password2'
        ]

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for campo in self.fields.values():
            campo.widget.attrs['class'] = 'form-control'

    def clean_rut(self):
        rut = self.cleaned_data['rut'].strip().upper()
        if Cliente.objects.filter(rut__iexact=rut).exists():
            raise forms.ValidationError(
                'Este RUT ya se encuentra registrado.'
            )
        return rut

    def clean_email(self):
        email = self.cleaned_data['email'].strip().lower()
        if User.objects.filter(email__iexact=email).exists():
            raise forms.ValidationError(
                'Este correo electrónico ya está registrado.'
            )
        return email

    def save(self, commit=True):
        if not commit:
            raise ValueError(
                'El registro de clientes requiere commit=True.'
            )
        with transaction.atomic():
            usuario = super().save(commit=False)
            usuario.first_name = self.cleaned_data['first_name']
            usuario.last_name = self.cleaned_data['last_name']
            usuario.email = self.cleaned_data['email']
            usuario.save()
            Cliente.objects.create(
                usuario=usuario,
                rut=self.cleaned_data['rut'],
                telefono=self.cleaned_data['telefono']
            )
        return usuario

class ReservaClienteForm(forms.ModelForm):
    class Meta:
        model = Reserva
        fields = [
            'fecha_entrada',
            'fecha_salida'
        ]
        widgets = {
            'fecha_entrada': forms.DateInput(
                attrs={
                    'class': 'form-control',
                    'type': 'date'
                },
                format='%Y-%m-%d'
            ),
            'fecha_salida': forms.DateInput(
                attrs={
                    'class': 'form-control',
                    'type': 'date'
                },
                format='%Y-%m-%d'
            ),
        }
        labels = {
            'fecha_entrada': 'Fecha de entrada',
            'fecha_salida': 'Fecha de salida'
        }

    def clean_fecha_entrada(self):
        fecha = self.cleaned_data['fecha_entrada']
        if fecha < timezone.localdate():
            raise forms.ValidationError(
                'La fecha de entrada no puede ser anterior a hoy.'
            )
        return fecha

    def clean(self):
        datos = super().clean()
        entrada = datos.get('fecha_entrada')
        salida = datos.get('fecha_salida')
        if entrada and salida and salida <= entrada:
            self.add_error(
                'fecha_salida',
                'La fecha de salida debe ser posterior a la entrada.'
            )
        return datos