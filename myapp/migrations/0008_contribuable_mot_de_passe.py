# Generated by Django 5.1.1 on 2024-10-11 06:39

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0007_alter_contribuable_fokontany'),
    ]

    operations = [
        migrations.AddField(
            model_name='contribuable',
            name='mot_de_passe',
            field=models.CharField(max_length=100, null=True),
        ),
    ]
