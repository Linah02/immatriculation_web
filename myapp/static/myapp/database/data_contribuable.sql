-- truncate table
TRUNCATE TABLE myapp_contribuable RESTART IDENTITY CASCADE;

insert into myapp_genre (genre) values ('homme');
insert into myapp_genre (genre) values ('femme');

insert into myapp_SIT_MATRIM (Situation) values ('marie(e)');
insert into myapp_SIT_MATRIM (Situation) values ('célibataire');
insert into myapp_SIT_MATRIM (Situation) values ('divorcé(e)');
insert into myapp_SIT_MATRIM (Situation) values ('veuf(ve)');


INSERT INTO myapp_videopublicite (
    titre, description, video, lien_video, date_publication, duree, categorie, langue, statut, 
    tags, nombre_vues, auteur, miniature, date_modification
)
VALUES
    (
        'Lutter Contre la Corruption', 
        'Connaissez Vos Droits, Protégez-Vous !',
        'videos/1.mp4', 
        NULL, 
        '2024-12-02', 
        '00:03:15', 
        'Produit', 
        'fr', 
        'publie', 
        'produit,marketing,visibilite', 
        456, 
        'Auteur 2', 
        'images/miniature2.png', 
        '2024-12-03'
    ),
    (
        'Partagez Vos Idées et Préoccupations', 
        'Visitez www.mef.gov.mg pour soumettre vos suggestions.',
        'videos/4.mp4', 
        NULL, 
        '2024-12-02', 
        '00:03:15', 
        'Produit', 
        'fr', 
        'publie', 
        'produit,marketing,visibilite', 
        456, 
        'Auteur 2', 
        'images/miniature2.png', 
        '2024-12-03'
    ),
    (
        'Comprendre l''IFPB et Son Importance pour Tous', 
        'Impôt Foncier sur les Propriétés Bâties (IFPB)',
        'videos/2.mp4', 
        NULL, 
        '2024-12-02', 
        '00:03:15', 
        'Produit', 
        'fr', 
        'publie', 
        'produit,marketing,visibilite', 
        456, 
        'Auteur 2', 
        'images/miniature2.png', 
        '2024-12-03'
    ),
    (
        'la DGI (Direction Générale des Impôts)', 
        'Votre Partenaire Fiscal au Service de la Nation',
        'videos/5.mp4', 
        NULL, 
        '2024-12-01', 
        '00:02:30', 
        'Promotion', 
        'fr', 
        'publie', 
        'promotion,fonctionnalites,nouvelle', 
        123, 
        'Auteur 1', 
        'images/miniature1.png', 
        '2024-12-03'
    ),
    (
        'Après l''Obtention de Votre Carte Fiscale', 
        'Les démarches à effectuer pour bien utiliser votre carte fiscale',
        'videos/6.mp4', 
        NULL, 
        '2024-12-03', 
        '00:01:45', 
        'evenement', 
        'fr', 
        'publie', 
        'evenement,annonce,publicite', 
        789, 
        'Auteur 3', 
        'images/miniature3.png', 
        '2024-12-03'
    ),
    (
        'Lutter Contre la Corruption', 
        'Connaissez Vos Droits, Protégez-Vous !',
        'videos/0.mp4', 
        NULL, 
        '2024-12-02', 
        '00:03:15', 
        'Produit', 
        'fr', 
        'publie', 
        'produit,marketing,visibilite', 
        456, 
        'Auteur 2', 
        'images/miniature2.png', 
        '2024-12-03'
);


INSERT INTO myapp_brochure (titre, description, fichier_pdf, date_publication)
VALUES
    ('Agriculture', 'energie-renouvelable_447', '/brochurespdfs/AGRICULTURE.pdf', '2024-12-01'),
    ('Education', 'industrie_448', '/brochurespdfs/EDUCATION.pdf', '2024-12-02'),
    ('Énergie renouvelable', 'industrie_449', '/brochurespdfs/energie-renouvelable_447.pdf', '2024-12-03'),
    ('Industrie', 'industrie_448', '/brochurespdfs/industrie_448.pdf', '2024-12-06'),
    ('Industrie', 'industrie_449', '/brochurespdfs/industrie_449.pdf', '2024-12-07'),
    ('Santé', 'industrie_44', '/brochurespdfs/SANTE.pdf', '2024-12-10'),
    ('Tourisme', 'energie-renouvelable_447', '/brochurespdfs/Tourisme.pdf', '2024-12-09'),
    ('Transport', 'TRANSPORT_450', '/brochurespdfs/TRANSPORT_450.pdf', '2024-12-08');

-- Ajout ligne mdp
insert into myapp_operateurs(nom,email) values('RANDRIANIRINA','raharinirinalina@gmail.com');

insert into myapp_operateur(cin,contact) values ('115172007680','0345319719');




insert into myapp_message('love you',,default,20,1,f);

Bonjour,

Je rencontre un souci avec mes dernières transactions. Pourriez-vous m’aider à clarifier la situation ?




Bonjour, Votre message a bien été reçu. Nous allons l’examiner et reviendrons vers vous dès que possible.

-- lina04!s