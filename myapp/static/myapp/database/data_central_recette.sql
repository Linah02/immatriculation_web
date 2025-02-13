
-- truncate table
TRUNCATE TABLE myapp_centralrecette RESTART IDENTITY CASCADE;



INSERT INTO myapp_logiciel (logiciel) VALUES
('SURF'),
('SIGTAS'),
('HETRAONLINE');


INSERT INTO myapp_modepaiement (sens) VALUES
('Depot'),
('Declaration'),
('Espece'),
('Virement');


INSERT INTO myapp_numimpot (impot, numero) VALUES
('Droit d''Enregistrement', 15),
('PENALITE', 40),
('AMENDE', 43);
TRUNCATE TABLE myapp_numimpot RESTART IDENTITY CASCADE;

-- 1
INSERT INTO myapp_centralrecette (
id_contribuable_id,id_centre_recette,regisseur,logiciel_id,
ref_trans,ref_reglement,daty,mouvement,
moyen_paiement,rib,raison_sociale,nimp_id,
libelle,flag,date_debut,date_fin,
periode,periode2,mnt_ap,base,imp_detail,da,
banque,annee_recouvrement,
code_bureau,libelle_bureau
) VALUES (
1,'NIF123QUITCENTRE','Regisseur 1',1,                        
'TRANS123','REG123','2024-01-01','1',                      
'01','RIB123456789','null',1,                                              
'Libelle 1','Y','2024-01-01','2024-12-31',             
1,'01-2024',50000.00,100000.00,                
'mutations immobilières',1,                         
'Banque 1',0,                      
'Bureau_00123','Centre Fiscal Anosy'          
);
INSERT INTO myapp_paiement (id_contribuable_id,central_recette_id,mode_paiement_id,n_quit,numrec,montant,date_paiement) VALUES
(1, 1, 1, 'QUIT126',001, 35000.00, '2025-02-01'),  
(1, 1, 1, 'QUIT126',002, 15000.00, '2025-03-01');  



-- 2
INSERT INTO myapp_centralrecette (
id_contribuable_id,id_centre_recette,regisseur,logiciel_id,
ref_trans,ref_reglement,daty,mouvement,
moyen_paiement,rib,raison_sociale,nimp_id,
libelle,flag,date_debut,date_fin,
periode,periode2,mnt_ap,base,imp_detail,da,
banque,annee_recouvrement,
code_bureau,libelle_bureau
) VALUES (
1,'NIF123_QUIT237_CR1','Regisseur 2',1,                        
'TRANS123','REG123','2024-01-01','1',                      
'01','RIB123456788','null',1,                                              
'Libelle 1','Y','2024-01-01','2024-12-31',             
1,'01-2024',1000000.00,1000000.00,                
'successions',1,                         
'BFVSG',0,                      
'Bureau_0022','Centre Fiscal Behoririka'          
);

INSERT INTO myapp_paiement (id_contribuable_id,central_recette_id,mode_paiement_id,n_quit,numrec,montant,date_paiement) VALUES
(1, 2, 1, 'QUIT237',001, 350000.00, '2025-02-01'),  
(1, 2, 1, 'QUIT237',002, 500000.00, '2025-03-02'), 
(1, 2, 1, 'QUIT237',003, 150000.00, '2025-04-03');  

-- 3
INSERT INTO myapp_centralrecette (
id_contribuable_id,id_centre_recette,regisseur,logiciel_id,
ref_trans,ref_reglement,daty,mouvement,
moyen_paiement,rib,raison_sociale,nimp_id,
libelle,flag,date_debut,date_fin,
periode,periode2,mnt_ap,base,imp_detail,da,
banque,annee_recouvrement,
code_bureau,libelle_bureau
) VALUES (
1,'NIF123_QUIT001_CR1','Regisseur 2',1,                        
'TRANS123','REG123','2024-01-01','1',                      
'01','RIB123456708','null',1,                                              
'Libelle 3','Y','2024-01-01','2024-12-31',             
1,'01-2024',500000.00,1000000.00,                
'ventes de terrains',1,                         
'BFVSG',0,                      
'Bureau_005','Centre Fiscal Itasy'          
);

INSERT INTO myapp_paiement (id_contribuable_id,central_recette_id,mode_paiement_id,n_quit,numrec,montant,date_paiement) VALUES
(1, 3, 1, 'QUIT590',001, 500000.00, '2026-02-01');

-- 4
INSERT INTO myapp_centralrecette (
id_contribuable_id,id_centre_recette,regisseur,logiciel_id,
ref_trans,ref_reglement,daty,mouvement,
moyen_paiement,rib,raison_sociale,nimp_id,
libelle,flag,date_debut,date_fin,
periode,periode2,mnt_ap,base,imp_detail,da,
banque,annee_recouvrement,
code_bureau,libelle_bureau
) VALUES (
1,'NIF123_QUIT001_CR10','Regisseur 2',1,                        
'TRANS123','REG123','2024-01-01','1',                      
'01','RIB123456708','null',1,                                              
'Libelle 3','Y','2024-01-01','2024-12-31',             
1,'01-2024',400000.00,500000.00,                
'donations',1,                         
'BFVSG',0,                      
'Bureau_002','Centre Fiscal Ihosy'          
);

INSERT INTO myapp_paiement (id_contribuable_id,central_recette_id,mode_paiement_id,n_quit,numrec,montant,date_paiement) VALUES
(1, 4, 1, 'QUIT709',001, 400000.00, '2027-02-01');


-- 5
INSERT INTO myapp_centralrecette (
id_contribuable_id,id_centre_recette,regisseur,logiciel_id,
ref_trans,ref_reglement,daty,mouvement,
moyen_paiement,rib,raison_sociale,nimp_id,
libelle,flag,date_debut,date_fin,
periode,periode2,mnt_ap,base,imp_detail,da,
banque,annee_recouvrement,
code_bureau,libelle_bureau
) VALUES (
1,'NIF123_QUIT001_CR1','Regisseur 2',1,                        
'TRANS123','REG123','2024-01-01','1',                      
'01','RIB123456708','null',1,                                              
'Libelle 3','Y','2024-01-01','2024-12-31',             
1,'01-2024',300000.00,500000.00,                
'échanges de biens immobiliers',1,                         
'BFVSG',0,                      
'Bureau_0010','Centre Fiscal Anosy'          
);
INSERT INTO myapp_paiement (id_contribuable_id,central_recette_id,mode_paiement_id,n_quit,numrec,montant,date_paiement) VALUES
(1, 5, 1, 'QUIT801',001, 200000.00, '2027-08-01'),  
(1, 5, 1, 'QUIT801',002, 100000.00, '2027-08-03');  

-- 6

INSERT INTO myapp_centralrecette (
id_contribuable_id,id_centre_recette,regisseur,logiciel_id,
ref_trans,ref_reglement,daty,mouvement,
moyen_paiement,rib,raison_sociale,nimp_id,
libelle,flag,date_debut,date_fin,
periode,periode2,mnt_ap,base,imp_detail,da,
banque,annee_recouvrement,
code_bureau,libelle_bureau
) VALUES (
1,'NIF123_QUIT001_CR6','Regisseur 2',1,                        
'TRANS123','REG123','2024-01-01','1',                      
'01','RIB123456708','null',1,                                              
'Libelle 3','Y','2024-01-01','2024-12-31',             
1,'01-2024',500000.00,1000000.00,                
'échanges de biens immobiliers',1,                         
'BFVSG',0,                      
'Bureau_005','Centre Fiscal Itasy'          
);

INSERT INTO myapp_paiement (id_contribuable_id,central_recette_id,mode_paiement_id,n_quit,montant,numrec,date_paiement) VALUES
(1, 6, 1, 'QUIT1000', 500000.00,001, '2028-09-01');


-- 7
INSERT INTO myapp_centralrecette (
id_contribuable_id,id_centre_recette,regisseur,logiciel_id,
ref_trans,ref_reglement,daty,mouvement,
moyen_paiement,rib,raison_sociale,nimp_id,
libelle,flag,date_debut,date_fin,
periode,periode2,mnt_ap,base,imp_detail,da,
banque,annee_recouvrement,
code_bureau,libelle_bureau
) VALUES (
1,'NIF123_QUIT001_CR1','Regisseur 2',1,                        
'TRANS123','REG123','2024-01-01','1',                      
'01','RIB123456708','null',1,                                              
'Libelle 3','Y','2024-01-01','2024-12-31',             
1,'01-2024',200000.00,500000.00,                
'mutation immobilier',1,                         
'BFVSG',0,                      
'Bureau_005','Centre Fiscal Analakely'          
);

INSERT INTO myapp_paiement (id_contribuable_id,central_recette_id,mode_paiement_id,n_quit,montant,numrec,date_paiement) VALUES
(1, 7, 1, 'QUIT1050', 100000.00,001, '2028-10-04'),  
(1, 7, 1, 'QUIT1050', 50000.00,002, '2028-11-05');  

