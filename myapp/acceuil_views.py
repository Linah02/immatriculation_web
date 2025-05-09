import logging
logger = logging.getLogger(__name__)
from django.template.loader import render_to_string
from django.utils import timezone
from django.core.paginator import Paginator
from firebase_admin.messaging import Message, Notification, send

import pdfkit
from pdfkit import configuration
from django.http import HttpResponse
from firebase_admin import messaging

import json
from django.shortcuts import render, redirect,get_object_or_404
from .models import VueTransactionsParQuitEtContribuable  # Assurez-vous d'importer le modèle
from .models import VueSommeParContribuableParAnnee  # Assurez-vous d'importer le modèle
from .models import VueRecouvrementsEtPaiementsParAnnee
from django.core.mail import send_mail
from django.conf import settings
from .models import Message, Operateurs,Contribuable

import imaplib
import email
from email.header import decode_header


from django.http import JsonResponse
from django.shortcuts import render

from django.shortcuts import render, get_object_or_404
from django.contrib.auth import authenticate, login
from django.views.decorators.csrf import csrf_exempt
from django.contrib import messages
from django.http import JsonResponse
from datetime import datetime, timedelta
from django.db import connection
from django.core.paginator import Paginator

from django.contrib.auth.decorators import login_required
from .models import TransactionDetail
from .models import Brochure
def acceuil(request):
    return render(request, 'acceuil/acceuil.html')  


from django.core.paginator import Paginator
from django.shortcuts import render

def acceuils(request):
    videos_publiees = VideoPublicite.objects.filter(statut='publie').order_by('-date_publication')
    brochures = Brochure.objects.all()  # Récupère toutes les brochures
    paginator = Paginator(brochures, 5)  # 5 brochures par page
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'acceuil/accueils.html', {
        'videos_publiees': videos_publiees,
        'page_obj': page_obj,  # Ajoutez l'objet de page à votre contexte
    })

from django.core.paginator import Paginator
from django.http import JsonResponse
from .models import Brochure

def get_brochures(request):
    page_number = request.GET.get('page', 1)  # Page actuelle
    brochures = Brochure.objects.all()  # Toutes les brochures
    paginator = Paginator(brochures, 5)  # Pagination à 5 brochures par page

    try:
        page_obj = paginator.get_page(page_number)
    except:
        return JsonResponse({'error': 'Page non valide'}, status=400)
    brochures_data = [
        {
            'titre': brochure.titre,
            'fichier_pdf': brochure.fichier_pdf.url,  # URL correcte
        }
        for brochure in page_obj.object_list
    ]

    return JsonResponse({
        'brochures': brochures_data,
        'has_next': page_obj.has_next(),  # Indique s'il y a une page suivante
        'has_previous': page_obj.has_previous(),  # Indique s'il y a une page précédente
        'current_page': page_obj.number,  # Page actuelle
    })


def acceuilCte(request):
    return render(request, 'acceuil/acceuilCte.html')  

def IS_calcul(request):
    return render(request, 'acceuil/IS_calcul.html')  



def IR_calcul(request):
    if request.method == 'POST':
        salaire_brut = float(request.POST.get('salaire_brut', 0))
        charges_sociales = float(request.POST.get('charges_sociales', 0))

        # Calcul des charges et du salaire net imposable
        charges = (salaire_brut * charges_sociales) / 100
        salaire_net_imposable = salaire_brut - charges
        irsa = salaire_net_imposable * 0.2  # Exemple : IRSA à 20%

        # Répartition des pourcentages
        sante = irsa * 0.1
        enseignement = irsa * 0.9

        return JsonResponse({
            'irsa': irsa,
            'details': {
                'sante': sante,
                'enseignement': enseignement
            }
        })
    return render(request, 'acceuil/IR_calcul.html')


def IRSA_calcul(request):
    return render(request, 'acceuil/IRSA_calcul.html')  


def home1(request):
    return render(request, 'myapp/home1.html')  


def notification(request):
    return render(request, 'acceuil/notification.html')  


def chart(request):
    # Récupérer l'ID du contribuable connecté depuis la session
    id_contribuable = request.session.get('contribuable_id')
    messages_non_lus = Message.objects.filter(notifié=False,type_message='operateur')

    # Vérifier si l'utilisateur est connecté
    if not id_contribuable:
        return redirect('connexion')  # Redirige vers la page de login si non connecté

    # Récupérer les données depuis la base de données
    with connection.cursor() as cursor:
        cursor.execute(
            "SELECT contribuable, annee, total_mnt_ver FROM vue_somme_par_contribuable_par_annee WHERE contribuable = %s",
            [id_contribuable]
        )
        rows = cursor.fetchall()

    # Conversion des valeurs Decimal en float pour faciliter l'affichage JSON
    sommes = [{'contribuable': row[0], 'annee': row[1], 'total_mnt_ver': float(row[2])} for row in rows]
    
    # Rendu de la page avec les données JSON
    return render(request, 'acceuil/transaction_chart.html', {'sommes': json.dumps(sommes),'messages_non_lus':messages_non_lus})


def chart_line(request):
    messages_non_lus = Message.objects.filter(notifié=False,type_message='operateur')

    # Récupérer l'ID du contribuable connecté depuis la session
    id_contribuable = request.session.get('contribuable_id')

    # Vérifier si l'utilisateur est connecté
    if not id_contribuable:
        return redirect('connexion')  # Redirige vers la page de login si non connecté

    with connection.cursor() as cursor:
        cursor.execute(
            """
            SELECT contribuable, annee_recouvrement, total_recouvrement_annuel, total_paye_annuel
            FROM vue_recouvrements_et_paiements_par_annee
            WHERE contribuable = %s
            """,
            [id_contribuable]
        )
        rows = cursor.fetchall()

    # Structurer les données pour le graphique
    data_par_contribuable = {}
    for contribuable, annee, total_recouvrement, total_paye in rows:
        # Convertir les valeurs Decimal en float
        total_recouvrement = float(total_recouvrement) if total_recouvrement is not None else 0.0
        total_paye = float(total_paye) if total_paye is not None else 0.0

        if contribuable not in data_par_contribuable:
            data_par_contribuable[contribuable] = {
                'annees': [],
                'recouvrements': [],
                'paiements': []
            }
        data_par_contribuable[contribuable]['annees'].append(annee)
        data_par_contribuable[contribuable]['recouvrements'].append(total_recouvrement)
        data_par_contribuable[contribuable]['paiements'].append(total_paye)

    # Retourner les données sous forme JSON
    return render(request, 'acceuil/evolution_transaction.html', {
        'data': json.dumps(data_par_contribuable),
        'messages_non_lus': messages_non_lus
    })




def list_transaction(request):
    messages_non_lus = Message.objects.filter(notifié=False,type_message='operateur')

    # Récupérer l'ID du contribuable connecté depuis la session
    id_contribuable = request.session.get('contribuable_id')

    # Vérifier si l'utilisateur est connecté
    if not id_contribuable:
        return redirect('connexion')  # Redirige vers la page de connexion si non connecté

    # Créer la requête SQL pour obtenir les transactions du contribuable connecté
    query = """
      SELECT *
        FROM vue_transactions_par_quit_et_contribuable
        WHERE contribuable = %s
        ORDER BY CAST(REGEXP_REPLACE(n_quit, '[^0-9]', '', 'g') AS INTEGER) DESC;
    """
    
    # Exécuter la requête SQL
    with connection.cursor() as cursor:
        cursor.execute(query, [id_contribuable])
        transactions = cursor.fetchall()
    
    # Paginer les résultats avec 10 transactions par page
    paginator = Paginator(transactions, 5)  # 10 transactions par page
    page_number = request.GET.get('page')
    transactions = paginator.get_page(page_number)
    
    # Passer transactions au lieu de transactions dans le rendu
    return render(request, 'acceuil/liste_transaction.html', {'transactions': transactions,'messages_non_lus':messages_non_lus})


def filtre_list_transaction(request, min_montant=None, max_montant=None):
    # messages_non_lus = Message.objects.filter(notifié=False,type_message='operateur')

    # Récupérer l'ID du contribuable connecté depuis la session
    id_contribuable = request.session.get('contribuable_id')

    # Vérifier si l'utilisateur est connecté
    if not id_contribuable:
        return redirect('connexion')  # Redirige vers la page de connexion si non connecté

    # Récupérer les montants min et max à partir des paramètres GET, uniquement si fournis et valides
    try:
        if 'min' in request.GET and request.GET.get('min').strip():
            min_montant = float(request.GET['min'])
        if 'max' in request.GET and request.GET.get('max').strip():
            max_montant = float(request.GET['max'])
    except ValueError:
        logger.error("Valeur de min ou max non valide. Filtrage désactivé.")

    logger.debug(f"Filtrage avec min={min_montant} et max={max_montant}")

    # Construction de la requête SQL sécurisée avec des paramètres
    query = """
        SELECT *
        FROM vue_transactions_par_quit_et_contribuable
        WHERE contribuable = %s
    """
    params = [id_contribuable]

    if min_montant is not None and max_montant is not None:
        query += " AND mont_ap BETWEEN %s AND %s"
        params.extend([min_montant, max_montant])
    elif min_montant is not None:
        query += " AND mont_ap >= %s"
        params.append(min_montant)
    elif max_montant is not None:
        query += " AND mont_ap <= %s"
        params.append(max_montant)

    logger.debug(f"Requête SQL : {query}")

    with connection.cursor() as cursor:
        cursor.execute(query, params)
        transactions = cursor.fetchall()

    context = {
        'transactions': transactions,
    }

    return render(request, 'acceuil/liste_transaction.html', context)


def profil(request):
    id_contribuable = request.session.get('contribuable_id')
    messages_non_lus = Message.objects.filter(notifié=False,type_message='operateur')

    if not id_contribuable:
        return redirect('connexion')  

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM myapp_contribuable WHERE id = %s", [id_contribuable])
        contribuable = cursor.fetchone()  

    if contribuable:
        contribuable_info = {
            'id': contribuable[0],  
            'nom': contribuable[1],
            'prenom': contribuable[2],
            'email': contribuable[10],
            'contact': contribuable[8],
            'photo': contribuable[17],
            'propr_nif': contribuable[18],
            'cin':contribuable[6],
            'mot_de_passe': contribuable[13],
        }
    else:
        contribuable_info = {}  

    return render(request, 'myapp/profil.html', {'contribuable': contribuable_info,'messages_non_lus':messages_non_lus})

def get_transaction_details(request, n_quit, mnt_ap, reste_a_payer):
    messages_non_lus = Message.objects.filter(notifié=False,type_message='operateur')

    id_contribuable = request.session.get('contribuable_id')
    if not id_contribuable:
        return redirect('login')  


    sql_query = """
        SELECT 
            contribuable, 
            n_quit, 
            date_paiement, 
            numrec,
            annee_de_paiement, 
            annee_recouvrement, 
            date_debut, 
            date_fin, 
            base, 
            mnt_ap, 
            nimp AS NIMP, 
            imp_detail, 
            numero, 
            impot, 
            sens, 
            logiciel,
            montant
        FROM 
            vue_detail_transactions_par_quit_et_contribuable 
        WHERE 
            contribuable = %s AND n_quit = %s;
    """

    with connection.cursor() as cursor:
        # Logger la requête
        logger.info("Exécution de la requête SQL : SELECT * FROM vue_detail_transactions_par_quit_et_contribuable WHERE contribuable = %d AND n_quit = '%s'", id_contribuable, n_quit)

        cursor.execute(sql_query, [id_contribuable, n_quit])  # Assurez-vous que n_quit est une chaîne
        
        transaction_details = cursor.fetchall()

    sql_query_formatted = f"SELECT contribuable, n_quit, date_paiement, annee_de_paiement, annee_recouvrement, date_debut, date_fin, base, mnt_ap, nimp AS NIMP, imp_detail, numero, impot, sens, logiciel FROM vue_detail_transactions_par_quit_et_contribuable WHERE contribuable = {id_contribuable} AND n_quit = '{n_quit}'"

    return render(request, 'acceuil/transaction_details.html', {
        'transaction_details': transaction_details,
        'sql_query': sql_query_formatted,
        'montant': mnt_ap,  
        'reste': reste_a_payer, 
        'n_quit':n_quit,'messages_non_lus':messages_non_lus  
    })




def filtre_detail_transaction(request, n_quit):
    min_montant = request.GET.get('min')
    max_montant = request.GET.get('max')
    date_min = request.GET.get('date_min')
    date_max = request.GET.get('date_max')
    query = """
        SELECT *
        FROM vue_detail_transactions_par_quit_et_contribuable
        WHERE n_quit = %s
    """
    params = [n_quit]
    
    if min_montant:
        query += " AND montant >= %s"
        params.append(min_montant)
    if max_montant:
        query += " AND montant <= %s"
        params.append(max_montant)
    
    if date_min:
        query += " AND date_paiement >= %s"
        params.append(date_min)
    if date_max:
        query += " AND date_paiement <= %s"
        params.append(date_max)

    with connection.cursor() as cursor:
        cursor.execute(query, params)
        transaction_details = cursor.fetchall()

    formatted_query = query % tuple(map(repr, params))  # Remplace les %s par les valeurs réelles
    
    context = {
        'transaction_details': transaction_details,  # Assurez-vous que c'est 'transactions' et non 'transaction_details'
        'n_quit': n_quit,
        'query': formatted_query,  # Passer la requête formatée pour débogage
    }
    return render(request, 'acceuil/transaction_details.html', context)


def export_transaction_pdf(request, n_quit):
    id_contribuable = request.session.get('contribuable_id')
    if not id_contribuable:
        return redirect('login')  

    sql_query = """
        SELECT 
            contribuable, 
            n_quit, 
            date_paiement, 
            annee_de_paiement, 
            annee_recouvrement, 
            date_debut, 
            date_fin, 
            base, 
            mnt_ap, 
            nimp AS NIMP, 
            imp_detail, 
            numero, 
            impot, 
            sens, 
            logiciel,
            montant
        FROM 
            vue_detail_transactions_par_quit_et_contribuable 
        WHERE 
            contribuable = %s AND n_quit = %s;
    """

    with connection.cursor() as cursor:
        cursor.execute(sql_query, [id_contribuable, n_quit])
        transaction_details = cursor.fetchall()  

    html_string = render_to_string('acceuil/pdf_template.html', {
        'transaction_details': transaction_details,
        'n_quit': n_quit,
    })

    path_wkhtmltopdf = r'C:\Program Files (x86)\wkhtmltopdf\bin\wkhtmltopdf.exe'  # Mettez le bon chemin ici
    config = pdfkit.configuration(wkhtmltopdf=path_wkhtmltopdf)

    pdf = pdfkit.from_string(html_string, False, configuration=config)

    response = HttpResponse(pdf, content_type='application/pdf')
    response['Content-Disposition'] = f'attachment; filename="transaction_{n_quit}.pdf"'
    return response

def view_message_contribuable(request, message_id):
    message = get_object_or_404(Message, id=message_id)
    
    if not message.notifié:
        message.notifié = True
        message.save()
    return redirect('discussion')


def discussion(request):
    contribuable_id = request.session.get('contribuable_id')
    contribuable = Contribuable.objects.get(id=contribuable_id)
    operateur = Operateurs.objects.get(id=1)  # Opérateur par défaut
    if request.method == 'POST':
        contenu = request.POST.get('contenu')
        fichier_joint = request.FILES.get('fichier_joint')
        message = Message.objects.create(
            contenu=contenu,
            fichier_joint=fichier_joint,
            id_contribuable_id=contribuable_id,
            id_operateur_id=operateur.id,
            type_message='contribuable',
            date_envoi=timezone.now()
        )

    messages = Message.objects.filter(id_contribuable=contribuable_id).order_by('date_envoi')
    messages_non_lus = Message.objects.filter(notifié=False,type_message='operateur')
    
    return render(request, 'acceuil/message.html', {'messages': messages,'messages_non_lus':messages_non_lus})



def reponse_admin(request,id_contribuable):

    try:
        contribuable_id = Contribuable.objects.get(id=id_contribuable)
    except Contribuable.DoesNotExist:
        return render(request, 'admin/message.html', {'error': 'Contribuable non trouvé'})

    operateur = Operateurs.objects.get(id=1)  # Remplacer si l'opérateur par défaut doit être déterminé dynamiquement

    if request.method == 'POST':
        contenu = request.POST.get('contenu')
        fichier_joint = request.FILES.get('fichier_joint')
        
        message = Message.objects.create(
            contenu=contenu,
            fichier_joint=fichier_joint,
           id_contribuable_id=contribuable_id.id,
            id_operateur_id=operateur.id,
            type_message='operateur',
            date_envoi=timezone.now()
        )
        

    messages_non_lus = Message.objects.filter(id_operateur=1, notifié=False)
    messages = Message.objects.filter(id_contribuable=contribuable_id).order_by('date_envoi')

    return render(request, 'admin/reponse_admin.html', {
        'messages': messages,
        'messages_non_lus': messages_non_lus
    })



def discussion_admin(request):
    try:
        operator = Operateurs.objects.get(id=1)  # Utiliser l'ID 1 par défaut
    except Operateurs.DoesNotExist:
        return render(request, 'admin/message.html', {'error': 'Opérateur non trouvé'})
    messages_non_lus = Message.objects.filter(id_operateur=1, notifié=False)
    
    return render(request, 'admin/message.html', {'messages_non_lus': messages_non_lus})


def view_message(request, message_id):
    message = get_object_or_404(Message, id=message_id)
    
    if not message.notifié:
        message.notifié = True
        message.save()

    return redirect('reponse_admin', message.id_contribuable.id)




def notifier_message_cont(request):
    contribuable_id = request.session.get('contribuable_id')

    messages_non_lus = Message.objects.filter(id_contribuable_id=contribuable_id, notifié=False)
    
    return render(request, 'layout/navbar_admin.html', {'messages_non_lus': messages_non_lus})



# @login_required
def dashboard(request):
    messages_non_lus = Message.objects.filter(id_operateur=1, notifié=False)
    return render(request, 'layout/navbar_admin.html', {'messages_non_lus': messages_non_lus})


from django.shortcuts import render
from .models import VideoPublicite
from .models import Taux_droit_enregistrement
from .models import Declaration
from decimal import Decimal
from .models import VueDeclarationParContribuable

def calculer_montant_droit(montant_base, taux):
    base = Decimal(montant_base)
    taux_decimal = Decimal(taux) / 100  
    montant = base * taux_decimal
    return montant if montant >= 10000 else Decimal('10000')

def formDeclarationDE(request):
    contribuable_id = request.session.get('contribuable_id')

    if request.method == 'POST':
        montant_base = request.POST.get('montant_base')
        type_droit_id = request.POST.get('type_droit')

        try:
            taux_obj = Taux_droit_enregistrement.objects.get(id=type_droit_id)
        except Taux_droit_enregistrement.DoesNotExist:
            messages.error(request, "Type de droit invalide.")
            return redirect('formDeclarationDE')  

        taux = taux_obj.taux
        montant_ap = calculer_montant_droit(montant_base, taux)

        if 'confirm' in request.POST:
            if not contribuable_id:
                messages.error(request, "Utilisateur non authentifié.")
                return redirect('connexion')

            contribuable = Contribuable.objects.get(id=contribuable_id)

            Declaration.objects.create(
                id_contribuable=contribuable,
                base_imposable=montant_base,
                id_tde=taux_obj,
                mnt_ap=montant_ap
            )
            messages.success(request, f"Déclaration enregistrée. Montant à payer : {montant_ap} Ar")
            return redirect('listDeclarationDE')

        return render(request, 'acceuil/declarationDE.html', {
            'montant_calcule': montant_ap,
            'base': montant_base,
            'type_droit_id': type_droit_id,
            'taux': taux,
            'confirmation_requise': True
        })

    return render(request, 'acceuil/declarationDE.html')


def listDeclarationDE(request):
    messages_non_lus = Message.objects.filter(notifié=False, type_message='operateur')
    id_contribuable = request.session.get('contribuable_id')
    if not id_contribuable:
        return redirect('connexion')  
    query = """
        SELECT * FROM vue_declarations_par_contribuable
        WHERE id_contribuable_id = %s
        ORDER BY date_declaration DESC;
    """

    with connection.cursor() as cursor:
        cursor.execute(query, [id_contribuable])
        declarations = cursor.fetchall()

    paginator = Paginator(declarations, 5)
    page_number = request.GET.get('page')
    declarations = paginator.get_page(page_number)

    return render(request, 'acceuil/listeDE.html', {
        'declarations': declarations,
        'messages_non_lus': messages_non_lus
    })
