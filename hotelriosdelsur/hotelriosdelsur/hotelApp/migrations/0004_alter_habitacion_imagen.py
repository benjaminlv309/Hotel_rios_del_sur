from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('hotelApp', '0003_habitacion_imagen'),
    ]

    operations = [
        migrations.AlterField(
            model_name='habitacion',
            name='imagen',
            field=models.CharField(
                blank=True,
                help_text='Selecciona una imagen existente en static/img.',
                max_length=255,
            ),
        ),
    ]
