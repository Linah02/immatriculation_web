-- truncate table
TRUNCATE TABLE myapp_country RESTART IDENTITY CASCADE;


-- Insérer le pays Madagascar
INSERT INTO myapp_country (country_name, country_name_f, country_name_s, country_code, capital)
VALUES ('Madagascar', 'Madagasikara', 'Madagasikara', 'MG', 'Antananarivo');

-- Insérer les paroisses des 6 provinces de Madagascar
INSERT INTO myapp_parish (country_id, parish_name, parish_name_f, parish_name_s, parish_code)
VALUES
(1, 'Antananarivo', 'Antananarivo', 'Antananarivo', '001'),
(1, 'Itasy', 'Itasy', 'Itasy', '002'),
(1, 'Toamasina', 'Toamasina', 'Toamasina', '003'),
(1, 'Atsinanana', 'Atsinanana', 'Atsinanana', '004'),
(1, 'Fianarantsoa', 'Fianarantsoa', 'Fianarantsoa', '005'),
(1, 'Haute Matsiatra', 'Haute Matsiatra', 'Haute Matsiatra', '006');

-- Insérer des villes pour chaque paroisse
INSERT INTO myapp_city (parish_id, city_name_f, city_code, city_name_extra, city_name_s, city_name)
VALUES
(1, 'Antananarivo', '001', 'Antananarivo Ville', 'Antananarivo', 'Antananarivo City'),
(1, 'Ambohimanarina', '002', 'Ambohimanarina City', 'Ambohimanarina', 'Ambohimanarina'),
(3, 'Toamasina', '003', 'Toamasina Ville', 'Toamasina', 'Toamasina City'),
(3, 'Foulpointe', '004', 'Foulpointe City', 'Foulpointe', 'Foulpointe'),
(5, 'Fianarantsoa', '005', 'Fianarantsoa Ville', 'Fianarantsoa', 'Fianarantsoa City'),
(5, 'Ambalavao', '006', 'Ambalavao City', 'Ambalavao', 'Ambalavao');

TRUNCATE TABLE myapp_locality RESTART IDENTITY CASCADE;

-- Insérer des localités pour chaque ville
INSERT INTO myapp_locality (city_id, locality_desc, locality_desc_f, locality_desc_s, locality_code)
VALUES
(1, 'Centre Ville', 'Centre Ville', 'Centre Ville', '0001'),
(1, 'Ankorondrano', 'Ankorondrano', 'Ankorondrano', '0002'),
(3, 'Centre Ville', 'Centre Ville', 'Centre Ville', '0003'),
(3, 'Tanambao', 'Tanambao', 'Tanambao', '0004'),
(5, 'Ambalapaiso', 'Ambalapaiso', 'Ambalapaiso', '0005'),
(5, 'Mahamanina', 'Mahamanina', 'Mahamanina', '0006');

-- Insérer des weredas pour chaque localité
INSERT INTO myapp_wereda (wereda_code, locality_id, wereda_desc)
VALUES
(1, 1, 'Antananarivo District'),
(2, 2, 'Ankorondrano District'),
(3, 3, 'Toamasina District'),
(4, 4, 'Tanambao District'),
(5, 5, 'Ambalapaiso District'),
(6, 6, 'Mahamanina District');

-- Insérer des fokontany pour chaque wereda
INSERT INTO myapp_fokontany (wereda_id, fkt_desc)
VALUES
(1, 'Fokontany Antaninarenina'),
(1, 'Fokontany Isoraka'),
(2, 'Fokontany Ankorondrano Atsinanana'),
(2, 'Fokontany Andraharo'),
(3, 'Fokontany Ankirihiry'),
(3, 'Fokontany Morafeno'),
(4, 'Fokontany Tanambao V'),
(4, 'Fokontany Tanambao VI'),
(5, 'Fokontany Ambalapaiso I'),
(5, 'Fokontany Ambalapaiso II'),
(6, 'Fokontany Mahamanina I'),
(6, 'Fokontany Mahamanina II');
