from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('hotelApp', '0002_reserva_cantidad_noches_reserva_precio_total'),
    ]

    operations = [
        migrations.AddField(
            model_name='habitacion',
            name='imagen',
            field=models.ImageField(blank=True, upload_to='habitaciones/'),
        ),
    ]
