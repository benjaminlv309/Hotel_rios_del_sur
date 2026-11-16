import tempfile
from pathlib import Path
from django.contrib.auth.models import User
from django.test import TestCase, override_settings
from django.urls import reverse
from .models import Habitacion

class HabitacionImagenTests(TestCase):
    def setUp(self):
        static_dir = tempfile.TemporaryDirectory()
        self.addCleanup(static_dir.cleanup)
        self.static_dir = Path(static_dir.name)
        image_dir = self.static_dir / 'img'
        image_dir.mkdir()
        (image_dir / 'habitacion.png').write_bytes(b'placeholder')
        self.settings_override = override_settings(
            STATICFILES_DIRS=[self.static_dir]
        )
        self.settings_override.enable()
        self.addCleanup(self.settings_override.disable)
        self.client.force_login(User.objects.create_user(
            username='administrador',
            password='clave-segura',
            is_staff=True,
        ))

    def test_admin_can_select_static_image_and_public_list_displays_it(self):
        response = self.client.get(reverse('crear_habitacion'))
        self.assertContains(response, '<option value="habitacion.png">habitacion.png</option>')
        response = self.client.post(
            reverse('crear_habitacion'),
            {
                'numero': 101,
                'tipo': 'Doble',
                'capacidad': 2,
                'precio': '50000.00',
                'estado': 'habilitada',
                'imagen': 'habitacion.png',
            },
        )
        self.assertRedirects(response, reverse('administrar_habitaciones'))
        habitacion = Habitacion.objects.get(numero=101)
        self.assertEqual(habitacion.imagen, 'habitacion.png')
        response = self.client.get(reverse('lista_habitaciones'))
        self.assertContains(response, '/static/img/habitacion.png')

class PanelAdministradorTests(TestCase):
    def setUp(self):
        usuario = User.objects.create_user(
            username='administrador',
            password='clave-segura',
            is_staff=True,
        )
        self.client.force_login(usuario)

    def test_dashboard_renders_summary_and_module_links(self):
        response = self.client.get(reverse('dashboard'))
        self.assertContains(response, 'Accesos de gestión')
        self.assertContains(response, 'href="/static/css/estilos.css"')
        self.assertContains(response, 'card dashboard-stat-card')
        self.assertContains(response, 'bg-primary bg-gradient')
        self.assertContains(response, reverse('crear_reserva'))
        self.assertContains(response, reverse('administrar_estadias'))

    def test_reservation_form_uses_spanish_empty_option(self):
        response = self.client.get(reverse('crear_reserva'))
        self.assertContains(response, 'Selecciona una opción')