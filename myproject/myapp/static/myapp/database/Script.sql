-- Table demandes
CREATE TABLE DEMANDES
(
    ID_DEMANDE SERIAL PRIMARY KEY, -- Gestion de la clé primaire avec SERIAL
    RJT_CODE INTEGER, 
    FISCAL_REGIME_NO INTEGER, 
    JURIDICAL_FORM_NO INTEGER, 
    WEREDA_NO INTEGER, 
    DM_DATEDEMANDE DATE, 
    DM_STADE INTEGER, 
    DM_DATEVALIDATION DATE, 
    DM_MOTIF_REJET VARCHAR(200), 
    DM_RAISONSOCIALE VARCHAR(100), 
    DM_CIN VARCHAR(15), 
    DM_RESIDENT INTEGER, 
    CAP_SOCIETE NUMERIC, 
    COM_REG_NO VARCHAR(20), 
    DM_REF VARCHAR(15), 
    ID_VALID_USER INTEGER, 
    MAILING_ADDRESS VARCHAR(200), 
    ACTIVITY VARCHAR(800), 
    AGREE_DATE DATE, 
    BANK_ACCT_NO VARCHAR(250), 
    NOM_COMMERCIAL VARCHAR(200), 
    ACRONYME VARCHAR(40), 
    CF_VALID INTEGER, 
    CF_MANAGE VARCHAR(9), 
    AUTH_PUBLIE INTEGER, 
    OLD_NIF VARCHAR(50), 
    BIRTH_DATE DATE, 
    BIRTH_PLACE VARCHAR(120), 
    DELIVR_CIN_DATE DATE, 
    CIN_PLACE VARCHAR(120), 
    CREATE_DATE DATE, 
    ENT_TYPE_NO INTEGER, 
    SEX INTEGER, 
    REG_DATE DATE, 
    PIECES VARCHAR(20), 
    IMPORTER INTEGER, 
    EXPORTER INTEGER, 
    SIT_MATRIM INTEGER, 
    PROPRIETAIRE BOOLEAN, -- Représenté par BOOLEAN au lieu de NUMBER(1,0)
    PROPR_TYPE VARCHAR(20), 
    PROPR_NIF VARCHAR(10), 
    PROPR_NAME VARCHAR(100), 
    PROPR_CIN VARCHAR(15), 
    PROPR_ADDRESS VARCHAR(200), 
    STATISTIC_NO VARCHAR(21), 
    STATISTIC_DATE DATE, 
    DEBUT_EXO VARCHAR(5), 
    FIN_EXO VARCHAR(5), 
    INTERLOCUTOR_NAME VARCHAR(100), 
    INTERLOCUTOR_TITLE VARCHAR(100), 
    INTERLOCUTOR_ADDRESS VARCHAR(200), 
    INTERLOCUTOR_PHONE VARCHAR(14), 
    INTERLOCUTOR_EMAIL VARCHAR(100), 
    ASSOCIATE_MAJORITY BOOLEAN, -- BOOLEAN au lieu de NUMBER(1,0)
    COMPANY_NIF VARCHAR(100), 
    NBR_EMPLOYE INTEGER, 
    PROPR_CONTACT VARCHAR(14), 
    DETAILS_ACTIVITY VARCHAR(500), 
    PASSEPORT VARCHAR(20), 
    PERIODE_GRACE INTEGER, 
    FKT_NO INTEGER, 
    DURE_EXO INTEGER
);


ALTER TABLE DEMANDES
    ADD CONSTRAINT FKT_FK8 FOREIGN KEY (FKT_NO) REFERENCES FOKONTANY (FKT_NO);

ALTER TABLE DEMANDES
    ADD CONSTRAINT FK_CF FOREIGN KEY (CF_VALID) REFERENCES CENTRE_FISCAL (ID_CENTRE_FISCAL);

ALTER TABLE DEMANDES
    ADD CONSTRAINT FK_CF_MANAGE FOREIGN KEY (CF_MANAGE) REFERENCES CENTRE_GESTIONNAIRE (ID_CENTRE_GEST);

ALTER TABLE DEMANDES
    ADD CONSTRAINT FK_DEMANDES_AVOIR_13_MOTIF_RE FOREIGN KEY (RJT_CODE) REFERENCES MOTIF_REJET (RJT_CODE);

ALTER TABLE DEMANDES
    ADD CONSTRAINT FK_DEMANDES_AVOIR_14_JURIDICA FOREIGN KEY (JURIDICAL_FORM_NO) REFERENCES JURIDICAL_FORM (JURIDICAL_FORM_NO);

ALTER TABLE DEMANDES
    ADD CONSTRAINT FK_DEMANDES_ENT_TYPE_NO FOREIGN KEY (ENT_TYPE_NO) REFERENCES ENT_TYPE (ENT_TYPE_NO);

ALTER TABLE DEMANDES
    ADD CONSTRAINT FK_DEMANDES_PROVENIR__WEREDA FOREIGN KEY (WEREDA_NO) REFERENCES WEREDA (WEREDA_NO);

ALTER TABLE DEMANDES
    ADD CONSTRAINT FK_DEMANDES_SUIVRE_3_FISCAL_R FOREIGN KEY (FISCAL_REGIME_NO) REFERENCES FISCAL_REGIME (FISCAL_REGIME_NO);

ALTER TABLE DEMANDES
    ADD CONSTRAINT FK_DEM_USER FOREIGN KEY (ID_VALID_USER) REFERENCES USERS_NIF (ID_USER);


-- Create table Fokontany
CREATE TABLE FOKONTANY
(
    FKT_NO SERIAL PRIMARY KEY, -- Utilisation de SERIAL pour auto-incrémentation et clé primaire
    WEREDA_NO INTEGER, 
    FKT_DESC VARCHAR(500)
);


ALTER TABLE FOKONTANY
    ADD CONSTRAINT WEREDA_FK1 FOREIGN KEY (WEREDA_NO)
    REFERENCES WEREDA (WEREDA_NO) ON DELETE CASCADE;


-- Creta table Centre_fiscal
CREATE TABLE CENTRE_FISCAL
(
    ID_CENTRE_FISCAL SERIAL PRIMARY KEY, -- Utilisation de SERIAL pour auto-incrémentation et clé primaire
    CFL_DESIGNATION VARCHAR(80),
    ID_DIRECTION INTEGER,
    PARISH VARCHAR(50),
    CFL_ABREV VARCHAR(80)
);


ALTER TABLE CENTRE_FISCAL
    ADD CONSTRAINT FK_DIRECTION FOREIGN KEY (ID_DIRECTION)
    REFERENCES DIRECTIONS (ID_DIRECTION);


-- Create table centre_gestionnaire
CREATE TABLE CENTRE_GESTIONNAIRE
(
    ID_CENTRE_GEST VARCHAR(9) PRIMARY KEY,
    CG_DESIGNATION VARCHAR(400),
    LIEU_BUREAU VARCHAR(100),
    ID_CENTRE_FISCAL INTEGER,
    MAIL VARCHAR(80),
    TEL VARCHAR(20),
    TEL2 VARCHAR(20),
    ADRESSE VARCHAR(280),
    CODE_POSTAL VARCHAR(20),
    CODE_BUREAU VARCHAR(9),
    RIB VARCHAR(140),
    CG_ABBREV VARCHAR(60),
    WEREDA_NO INTEGER,
    COMPTE_A VARCHAR(8),
    ID_DIRECTION INTEGER,
    RGSR_CODE VARCHAR(20),
    CODE_BUREAU_OLD VARCHAR(20)
);

-- create table motif_rejet
CREATE TABLE MOTIF_REJET
(
    RJT_CODE SERIAL PRIMARY KEY, -- Utilisation de SERIAL pour auto-incrémentation et clé primaire
    RJT_LIBELLE VARCHAR(150)
);

-- create table juridical_form
CREATE TABLE JURIDICAL_FORM
(
    JURIDICAL_FORM_NO SERIAL PRIMARY KEY, -- Utilisation de SERIAL pour auto-incrémentation et clé primaire
    JURIDICAL_FORM_ABBR VARCHAR(20),
    JURIDICAL_FORM_ABBR_F VARCHAR(20),
    JURIDICAL_FORM_ABBR_S VARCHAR(20),
    JURIDICAL_FORM_DESC VARCHAR(50),
    JURIDICAL_FORM_DESC_F VARCHAR(50),
    JURIDICAL_FORM_DESC_S VARCHAR(50)
);

-- create table ent_type
CREATE TABLE ENT_TYPE
(
    ENT_TYPE_NO SERIAL PRIMARY KEY,  -- Utilisation de SERIAL pour gérer les valeurs uniques
    ENT_TYPE_DESC VARCHAR(20),
    ENT_TYPE_DESC_F VARCHAR(20),
    ENT_TYPE_DESC_S VARCHAR(20)
);


-- create table wereda
CREATE TABLE WEREDA
(
    WEREDA_NO SERIAL PRIMARY KEY,  -- Utilisation de SERIAL pour gérer les valeurs uniques
    LOCALITY_NO INTEGER,
    WEREDA_DESC VARCHAR(50),
    WEREDA_CODE INTEGER,
    CONSTRAINT FK_WEREDA_APPARTENI_LOCALITY FOREIGN KEY (LOCALITY_NO)
        REFERENCES LOCALITY (LOCALITY_NO) ON DELETE CASCADE  -- Ajout d'une option ON DELETE CASCADE
);

CREATE INDEX APPARTENIR_3_FK ON WEREDA (LOCALITY_NO);


-- create table fiscal_regime
CREATE TABLE FISCAL_REGIME
(
    FISCAL_REGIME_NO SERIAL PRIMARY KEY,  -- Utilisation de SERIAL pour gérer les valeurs uniques
    FISCAL_REGIME_DESC VARCHAR(30),
    FISCAL_REGIME_DESC_F VARCHAR(30),
    FISCAL_REGIME_DESC_S VARCHAR(30)
);


-- create table users_nif
CREATE TABLE USERS_NIF
(
    ID_USER SERIAL PRIMARY KEY,  -- Utilisation de SERIAL pour gérer les valeurs uniques
    ID_CENTRE_FISCAL INTEGER,
    USR_LOGIN VARCHAR(30),
    USR_PASSWORD VARCHAR(100),
    ID_AUTHORITY INTEGER DEFAULT 2,
    TRANSFERT INTEGER,
    BLOQUE INTEGER DEFAULT 0,
    PARISH_NO INTEGER,
    LAST_LOGIN TIMESTAMP,  -- Utilisation de TIMESTAMP pour stocker la date et l'heure
    LAST_IMP_VEHICL TIMESTAMP,
    DATE_ACTIVATE TIMESTAMP,
    NIF_EXPORT VARCHAR(10),
    BNK VARCHAR(20) DEFAULT '0',  -- '0' est une chaîne ici
    CONSTRAINT FK_USERS_NI_APPARTENI_CENTRE_F FOREIGN KEY (ID_CENTRE_FISCAL)
        REFERENCES CENTRE_FISCAL (ID_CENTRE_FISCAL) ON DELETE SET NULL,  -- Ajout d'une option ON DELETE SET NULL
    CONSTRAINT ID_AUTHORITY_FK FOREIGN KEY (ID_AUTHORITY)
        REFERENCES AUTHORITY (ID_AUTHORITY) ON DELETE SET NULL,
    CONSTRAINT USERS_NIF_PARISH_FK1 FOREIGN KEY (PARISH_NO)
        REFERENCES PARISH (PARISH_NO) ON DELETE SET NULL
);

CREATE UNIQUE INDEX PK_USERS_NIF ON USERS_NIF (ID_USER);
CREATE INDEX APPARTENIR_2_FK ON USERS_NIF (ID_CENTRE_FISCAL);

CREATE OR REPLACE FUNCTION insert_sequence_id_user()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.ID_USER IS NULL THEN
        NEW.ID_USER := nextval('id_user_seq');  -- Assurez-vous que cette séquence est créée
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_sequence_id_user
BEFORE INSERT ON USERS_NIF
FOR EACH ROW
EXECUTE FUNCTION insert_sequence_id_user();


CREATE TABLE DIRECTIONS
(
    ID_DIRECTION SERIAL PRIMARY KEY,  -- Utilisation de SERIAL pour gérer les valeurs uniques
    DIR_REF VARCHAR(40),
    DIR_LIB VARCHAR(100)
);

CREATE UNIQUE INDEX DIRECTIONS_PK ON DIRECTIONS (ID_DIRECTION);


CREATE TABLE AUTHORITY
(
    ID_AUTHORITY SERIAL PRIMARY KEY,  -- Utilisation de SERIAL pour gérer les valeurs uniques
    AUT_DESIGNATION VARCHAR(50),
    AUT_ROLE INTEGER,
    AUT_CONSULT INTEGER
);

CREATE UNIQUE INDEX PK_AUTHORITY ON AUTHORITY (ID_AUTHORITY);





-- NIF.FOKONTANY definition

CREATE TABLE "NIF"."FOKONTANY" 
   (	"FKT_NO" NUMBER NOT NULL ENABLE, 
	"WEREDA_NO" NUMBER, 
	"FKT_DESC" VARCHAR2(500), 
	 CONSTRAINT "FOKONTANY_PK" PRIMARY KEY ("FKT_NO")
  USING INDEX PCTFREE 20 INITRANS 128 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 851968 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE" ;

ALTER TABLE "NIF"."FOKONTANY" ADD CONSTRAINT "WEREDA_FK1" FOREIGN KEY ("WEREDA_NO")
	  REFERENCES "NIF"."WEREDA" ("WEREDA_NO") ON DELETE CASCADE ENABLE;

CREATE UNIQUE INDEX "NIF"."FOKONTANY_PK" ON "NIF"."FOKONTANY" ("FKT_NO") 
  PCTFREE 20 INITRANS 128 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 851968 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE" ;




-- NIF.WEREDA definition

CREATE TABLE "NIF"."WEREDA" 
   (	"WEREDA_NO" NUMBER NOT NULL ENABLE, 
	"LOCALITY_NO" NUMBER, 
	"WEREDA_DESC" VARCHAR2(50), 
	"WEREDA_CODE" NUMBER, 
	 CONSTRAINT "PK_WEREDA" PRIMARY KEY ("WEREDA_NO")
  USING INDEX PCTFREE 20 INITRANS 128 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 131072 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE" ;

ALTER TABLE "NIF"."WEREDA" ADD CONSTRAINT "FK_WEREDA_APPARTENI_LOCALITY" FOREIGN KEY ("LOCALITY_NO")
	  REFERENCES "NIF"."LOCALITY" ("LOCALITY_NO") ENABLE;

CREATE INDEX "NIF"."APPARTENIR_3_FK" ON "NIF"."WEREDA" ("LOCALITY_NO") 
  PCTFREE 20 INITRANS 128 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 131072 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE" ;
  CREATE UNIQUE INDEX "NIF"."PK_WEREDA" ON "NIF"."WEREDA" ("WEREDA_NO") 
  PCTFREE 20 INITRANS 128 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 131072 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE" ;


CREATE TABLE "NIF"."LOCALITY" 
   (	"LOCALITY_NO" NUMBER NOT NULL ENABLE, 
	"CITY_NO" NUMBER, 
	"LOCALITY_DESC" VARCHAR2(30), 
	"LOCALITY_DESC_F" VARCHAR2(30), 
	"LOCALITY_DESC_S" VARCHAR2(30), 
	"LOCALITY_CODE" VARCHAR2(6), 
	 CONSTRAINT "PK_LOCALITY" PRIMARY KEY ("LOCALITY_NO")
  USING INDEX PCTFREE 20 INITRANS 128 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE" ;

ALTER TABLE "NIF"."LOCALITY" ADD CONSTRAINT "FK_LOCALITY_APPARTENI_CITY" FOREIGN KEY ("CITY_NO")
	  REFERENCES "NIF"."CITY" ("CITY_NO") ENABLE;

CREATE UNIQUE INDEX "NIF"."PK_LOCALITY" ON "NIF"."LOCALITY" ("LOCALITY_NO") 
  PCTFREE 20 INITRANS 128 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE" ;
  CREATE INDEX "NIF"."APPARTENIR_4_FK" ON "NIF"."LOCALITY" ("CITY_NO") 
  PCTFREE 20 INITRANS 128 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE" ;




CREATE TABLE "NIF"."CITY" 
   (	"CITY_NO" NUMBER NOT NULL ENABLE, 
	"PARISH_NO" NUMBER, 
	"CITY_NAME" VARCHAR2(25), 
	"CITY_NAME_F" VARCHAR2(25), 
	"CITY_NAME_S" VARCHAR2(25), 
	"CITY_CODE" VARCHAR2(5), 
	"CITY_NAME_EXTRA" VARCHAR2(50), 
	 CONSTRAINT "PK_CITY" PRIMARY KEY ("CITY_NO")
  USING INDEX PCTFREE 20 INITRANS 128 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE" ;

ALTER TABLE "NIF"."CITY" ADD CONSTRAINT "FK_CITY_APPARTENI_PARISH" FOREIGN KEY ("PARISH_NO")
	  REFERENCES "NIF"."PARISH" ("PARISH_NO") ENABLE;

CREATE UNIQUE INDEX "NIF"."PK_CITY" ON "NIF"."CITY" ("CITY_NO") 
  PCTFREE 20 INITRANS 128 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE" ;
  CREATE INDEX "NIF"."APPARTENIR_5_FK" ON "NIF"."CITY" ("PARISH_NO") 
  PCTFREE 20 INITRANS 128 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE" ;




  -- NIF.PARISH definition

CREATE TABLE "NIF"."PARISH" 
   (	"PARISH_NO" NUMBER NOT NULL ENABLE, 
	"COUNTRY_NO" NUMBER, 
	"PARISH_NAME" VARCHAR2(35), 
	"PARISH_NAME_F" VARCHAR2(35), 
	"PARISH_NAME_S" VARCHAR2(35), 
	"PARISH_CODE" VARCHAR2(4), 
	 CONSTRAINT "PK_PARISH" PRIMARY KEY ("PARISH_NO")
  USING INDEX PCTFREE 20 INITRANS 128 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE" ;

ALTER TABLE "NIF"."PARISH" ADD CONSTRAINT "FK_PARISH_APPARTENI_COUNTRY" FOREIGN KEY ("COUNTRY_NO")
	  REFERENCES "NIF"."COUNTRY" ("COUNTRY_NO") ENABLE;

CREATE UNIQUE INDEX "NIF"."PK_PARISH" ON "NIF"."PARISH" ("PARISH_NO") 
  PCTFREE 20 INITRANS 128 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE" ;
  CREATE INDEX "NIF"."APPARTENIR_6_FK" ON "NIF"."PARISH" ("COUNTRY_NO") 
  PCTFREE 20 INITRANS 128 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE" ;


-- NIF.COUNTRY definition

CREATE TABLE "NIF"."COUNTRY" 
   (	"COUNTRY_NO" NUMBER NOT NULL ENABLE, 
	"COUNTRY_NAME" VARCHAR2(100), 
	"COUNTRY_NAME_F" VARCHAR2(20), 
	"COUNTRY_NAME_S" VARCHAR2(20), 
	"COUNTRY_CODE" VARCHAR2(4), 
	"CAPITAL" VARCHAR2(100), 
	 CONSTRAINT "PK_COUNTRY" PRIMARY KEY ("COUNTRY_NO")
  USING INDEX PCTFREE 20 INITRANS 128 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE" ;

CREATE UNIQUE INDEX "NIF"."PK_COUNTRY" ON "NIF"."COUNTRY" ("COUNTRY_NO") 
  PCTFREE 20 INITRANS 128 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_NIFONLINE" ;

