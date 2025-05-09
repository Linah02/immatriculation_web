"""
Django settings for myproject project.

Generated by 'django-admin startproject' using Django 5.1.1.

For more information on this file, see
https://docs.djangoproject.com/en/5.1/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/5.1/ref/settings/
"""
import os
from pathlib import Path
from decouple import config 
import dj_database_url

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent
# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/5.1/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY =config('SECRET_KEY')

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

# ALLOWED_HOSTS = ['192.168.1.199', 'localhost', '127.0.0.1', '0.0.0.0','192.168.0.185']
ALLOWED_HOSTS = ['0.0.0.0','127.0.0.1','immatriculation-prenif.onrender.com']

SECURE_CONTENT_TYPE_NOSNIFF = False
X_FRAME_OPTIONS = 'SAMEORIGIN'

CORS_ALLOWED_ORIGINS = [
    "http://localhost:19006",  # Adresse de votre app React Native
    "http://192.168.1.199:8000",
    "http://192.168.0.185:8000",
    "http://127.0.0.1:8000",
]
# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'myapp.apps.MyappConfig',#integration de mon app dans mon projet
    'django.contrib.humanize',
    'corsheaders',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.common.CommonMiddleware',
]

CORS_ALLOW_ALL_ORIGINS = True
SESSION_ENGINE = 'django.contrib.sessions.backends.db'  # Utilisation des sessions basées sur la base de données
SESSION_COOKIE_NAME = 'sessionid'  # Nom du cookie de session
SESSION_COOKIE_AGE = 3600  # Durée de vie du cookie en secondes
SESSION_COOKIE_HTTPONLY = True
CORS_ALLOW_CREDENTIALS = True
ROOT_URLCONF = 'myproject.urls'

# TEMPLATES = [
#     {
#         'BACKEND': 'django.template.backends.django.DjangoTemplates',
#         'DIRS': [os.path.join(BASE_DIR, 'templates')],
#         'APP_DIRS': True,
#         'OPTIONS': {
#             'context_processors': [
#                 'django.template.context_processors.debug',
#                 'django.template.context_processors.request',
#                 'django.contrib.auth.context_processors.auth',
#                 'django.contrib.messages.context_processors.messages',
#             ],
#         },
#     },
# ]
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,  # Important: doit être à True
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]




WSGI_APPLICATION = 'myproject.wsgi.application'
DATABASES = {
    'default': dj_database_url.parse(config('DATABASE_URL'))
}


# Database
# https://docs.djangoproject.com/en/5.1/ref/settings/#databases

# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.sqlite3',
#         'NAME': BASE_DIR / 'db.sqlite3',
#     }
# }

# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.postgresql',
#         'NAME': 'immatriculation',  # Remplacez par le nom de votre base de données
#         'USER': 'postgres',  # Remplacez par le nom d'utilisateur PostgreSQL
#         'PASSWORD': 'root',  # Remplacez par votre mot de passe PostgreSQL
#         'HOST': 'localhost',  # Remplacez si votre base est hébergée ailleurs
#         'PORT': '5433',  # Port par défaut de PostgreSQL
#     }
# }


# Password validation
# https://docs.djangoproject.com/en/5.1/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/5.1/topics/i18n/

LANGUAGE_CODE = 'en-us'

# TIME_ZONE = 'UTC'
TIME_ZONE = 'Africa/Nairobi'  # Exemple pour UTC+3
USE_TZ = True  # Active la gestion des fuseaux horaires

USE_I18N = True

USE_TZ = True

# Chemin vers le dossier des fichiers médias
MEDIA_URL = 'media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media/')

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/5.1/howto/static-files/
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
STATIC_URL = 'static/'
# STATICFILES_DIRS = [
#     BASE_DIR / "static",  # Chemin vers le dossier des fichiers statiques
# ]

# Default primary key field type
# https://docs.djangoproject.com/en/5.1/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'


# Paramètres d'envoi d'email
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.gmail.com'  # Par exemple, pour Gmail
EMAIL_PORT = 587
EMAIL_USE_TLS = True
EMAIL_HOST_USER = 'raharinirinalina@gmail.com'
EMAIL_HOST_PASSWORD = 'ywfx wlht flhi typd'
DEFAULT_FROM_EMAIL = 'raharinirinalina@gmail.com'


REST_FRAMEWORK = {
    'DEFAULT_RENDERER_CLASSES': (
        'rest_framework.renderers.JSONRenderer',
    ),
}

# (OTP - One-Time Password)