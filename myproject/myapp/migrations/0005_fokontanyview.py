# Generated by Django 5.1.1 on 2024-10-09 05:31

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0004_city_country_locality_parish_city_parish_wereda_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='FokontanyView',
            fields=[
                ('fkt_no', models.IntegerField(primary_key=True, serialize=False)),
                ('FKT_DESC', models.CharField(max_length=500)),
                ('wereda_no', models.IntegerField()),
                ('wereda_desc', models.CharField(max_length=50)),
                ('wereda_code', models.IntegerField()),
                ('locality_no', models.IntegerField()),
                ('locality_desc', models.CharField(max_length=30)),
                ('locality_desc_f', models.CharField(max_length=30)),
                ('locality_desc_s', models.CharField(max_length=30)),
                ('locality_code', models.CharField(max_length=6)),
                ('city_no', models.IntegerField()),
                ('city_name', models.CharField(max_length=25)),
                ('city_name_f', models.CharField(max_length=25)),
                ('city_name_s', models.CharField(max_length=25)),
                ('city_code', models.CharField(max_length=5)),
                ('city_name_extra', models.CharField(max_length=50)),
                ('parish_no', models.IntegerField()),
                ('parish_name', models.CharField(max_length=35)),
                ('parish_name_f', models.CharField(max_length=35)),
                ('parish_name_s', models.CharField(max_length=35)),
                ('parish_code', models.CharField(max_length=4)),
                ('country_no', models.IntegerField()),
                ('country_name', models.CharField(max_length=100)),
                ('country_name_f', models.CharField(max_length=20)),
                ('country_name_s', models.CharField(max_length=20)),
                ('country_code', models.CharField(max_length=4)),
                ('capital', models.CharField(max_length=100)),
            ],
            options={
                'db_table': 'v_getFokontany',
                'managed': False,
            },
        ),
    ]
