"""
URL configuration for hotelriosdelsur project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""


from django.contrib import admin
from django.urls import path
from hotelApp import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('',views.inicio,name='inicio'),
    path('habitaciones/',views.lista_habitaciones,name='lista_habitaciones'),
    path('gestion/',views.dashboard,name='dashboard'),
    path('gestion/habitaciones/',views.administrar_habitaciones,name='administrar_habitaciones'),
    path('gestion/habitaciones/crear/',views.crear_habitacion,name='crear_habitacion'),
    path('gestion/habitaciones/editar/<int:id>/',views.editar_habitacion,name='editar_habitacion'),
    path('gestion/huespedes/',views.administrar_huespedes,name='administrar_huespedes'),
    path('gestion/huespedes/crear/',views.crear_huesped,name='crear_huesped'),
    path('gestion/huespedes/editar/<int:id>/',views.editar_huesped,name='editar_huesped'),
    path('gestion/reservas/',views.administrar_reservas,name='administrar_reservas'),
    path('gestion/reservas/crear/',views.crear_reserva,name='crear_reserva'),
    path('gestion/reservas/confirmar/<int:id>/',views.confirmar_reserva,name='confirmar_reserva'),
    path('gestion/reservas/cancelar/<int:id>/',views.cancelar_reserva,name='cancelar_reserva'),
    path('gestion/estadias/',views.administrar_estadias,name='administrar_estadias'),
    path('gestion/estadias/checkin/<int:id>/',views.realizar_checkin,name='realizar_checkin'),
    path('gestion/estadias/checkout/<int:id>/',views.realizar_checkout,name='realizar_checkout'),
    path('registro/',views.registrar_cliente,name='registrar_cliente'),
    path('iniciar-sesion/',views.IniciarSesionView.as_view(),name='iniciar_sesion'),
    path('cerrar-sesion/',views.CerrarSesionView.as_view(),name='cerrar_sesion'),
    path('habitaciones/reservar/<int:id>/',views.reservar_habitacion,name='reservar_habitacion'),
    path('mis-reservas/',views.mis_reservas,name='mis_reservas'),
    path('mis-reservas/cancelar/<int:id>/',views.cancelar_reserva_cliente,name='cancelar_reserva_cliente'),
]