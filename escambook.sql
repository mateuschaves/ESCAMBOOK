BEGIN
   FOR cur_rec IN (SELECT object_name, object_type
                   FROM user_objects
                   WHERE object_type IN
                             ('TABLE',
                              'VIEW',
                              'MATERIALIZED VIEW',
                              'PACKAGE',
                              'PROCEDURE',
                              'FUNCTION',
                              'SEQUENCE',
                              'SYNONYM',
                              'PACKAGE BODY'
                             ))
   LOOP
      BEGIN
         IF cur_rec.object_type = 'TABLE'
         THEN
            EXECUTE IMMEDIATE 'DROP '
                              || cur_rec.object_type
                              || ' "'
                              || cur_rec.object_name
                              || '" CASCADE CONSTRAINTS';
         ELSE
            EXECUTE IMMEDIATE 'DROP '
                              || cur_rec.object_type
                              || ' "'
                              || cur_rec.object_name
                              || '"';
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line ('FAILED: DROP '
                                  || cur_rec.object_type
                                  || ' "'
                                  || cur_rec.object_name
                                  || '"'
                                 );
      END;
   END LOOP;
   FOR cur_rec IN (SELECT * 
                   FROM all_synonyms 
                   WHERE table_owner IN (SELECT USER FROM dual))
   LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM ' || cur_rec.synonym_name;
      END;
   END LOOP;
END;





CREATE TABLE GENERO (
  ID INT,
  GENERO VARCHAR(30),
  PRIMARY KEY (ID)
);

CREATE TABLE ENDERECO(
  ID INT,
  RUA VARCHAR2(30),
  BAIRRO VARCHAR2(30),
  CIDADE VARCHAR2(30),
  CEP VARCHAR2(15),
  PRIMARY KEY (ID)
);

SELECT * FROM ENDERECO;

CREATE TABLE TELEFONE( 
  ID INT,
  NUMERO VARCHAR2(25) NOT NULL,
  PRIMARY KEY (ID)
);


CREATE TABLE USUARIO(
  ID INT,
  NOME VARCHAR2(30),
  LOGIN VARCHAR2(30),
  PASSWORD VARCHAR2(60),
  ENDERECO_ID NUMBER,
  TELEFONE_ID NUMBER,
  PRIMARY KEY (ID),
  
  FOREIGN KEY (ENDERECO_ID) REFERENCES ENDERECO (ID),
  FOREIGN KEY (TELEFONE_ID) REFERENCES TELEFONE (ID)
  
);

CREATE TABLE AUTOR(
  ID INT,
  NOME VARCHAR2(30),
  ENDERECO_ID NUMBER,
  TELEFONE_ID NUMBER,
  PRIMARY KEY (ID),

  FOREIGN KEY (ENDERECO_ID) REFERENCES ENDERECO (ID),
  FOREIGN KEY (TELEFONE_ID) REFERENCES TELEFONE (ID)
);


CREATE TABLE EDITORA (
  ID INT,
  CNPJ_EDITORA VARCHAR2(11),
  NOME VARCHAR2(30),
  ENDERECO_ID NUMBER,
  TELEFONE_ID NUMBER,
  PRIMARY KEY (ID),
  
  FOREIGN KEY (ENDERECO_ID) REFERENCES ENDERECO (ID),
  FOREIGN KEY (TELEFONE_ID) REFERENCES TELEFONE (ID)
);

CREATE TABLE LIVRO(
  ID INT,
  TITULO VARCHAR2(100),
  EXEMPLAR NUMBER,
  USUARIO_ID NUMBER NOT NULL,
  AUTOR_ID NUMBER NOT NULL,
  EDITORA_ID NUMBER NOT NULL,
  GENERO_ID NUMBER NOT NULL,
  PRIMARY KEY (ID),

  FOREIGN KEY (USUARIO_ID) REFERENCES USUARIO (ID),
  FOREIGN KEY (AUTOR_ID) REFERENCES AUTOR (ID),
  FOREIGN KEY (EDITORA_ID) REFERENCES EDITORA (ID),
  FOREIGN KEY (GENERO_ID) REFERENCES GENERO (ID)
);

CREATE TABLE GENERO_LIVRO(
  ID INT,
  LIVRO_ID NUMBER NOT NULL,
  GENERO_ID NUMBER NOT NULL,
  PRIMARY KEY (ID),
  
  FOREIGN KEY (LIVRO_ID) REFERENCES LIVRO (ID),
  FOREIGN KEY (GENERO_ID) REFERENCES GENERO (ID)
);

CREATE TABLE GENERO_USUARIO(
  ID INT,
  USUARIO_ID NUMBER NOT NULL,
  GENERO_ID NUMBER NOT NULL,
  PRIMARY KEY (ID),
  
  FOREIGN KEY (USUARIO_ID) REFERENCES USUARIO (ID),
  FOREIGN KEY (GENERO_ID) REFERENCES GENERO (ID)
);


CREATE TABLE EVENTO (
  ID INT,
  USUARIO_ID NUMBER NOT NULL,
  LIVRO_ID NUMBER NOT NULL,
  TIPO VARCHAR2(10) CHECK( TIPO IN ('DEMANDAR','OFERECER') ),
  PRIMARY KEY (ID),
  
  FOREIGN KEY (USUARIO_ID) REFERENCES USUARIO (ID),
  FOREIGN KEY (LIVRO_ID) REFERENCES LIVRO (ID)
);

CREATE TABLE HISTORICO (
  ID INT,
  USUARIO_DESTINATARIO_ID NUMBER NOT NULL,
  USUARIO_REMETENTE_ID NUMBER NOT NULL,
  LIVRO_ID NUMBER NOT NULL,
  DATA_TROCA DATE NOT NULL,
  
  PRIMARY KEY (ID),
  
  FOREIGN KEY (USUARIO_DESTINATARIO_ID) REFERENCES USUARIO (ID),
  FOREIGN KEY (USUARIO_REMETENTE_ID) REFERENCES USUARIO (ID),
  FOREIGN KEY (LIVRO_ID) REFERENCES LIVRO (ID)
);


SELECT * FROM LIVRO WHERE USUARIO_ID = 12;

INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (0, 'Afton Place', 'Ernestoberg', 'New Trystanfort', '31894-9034' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (1, 'Nader Route', 'Trantowbury', 'West Shannymouth', '23202-0836' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (2, 'McDermott Pine', 'Lake Myleston', 'Wymanview', '21927' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (3, 'Kreiger Harbors', 'Meganeburgh', 'East Marlee', '12293' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (4, 'Langosh Landing', 'West Kyraville', 'New Jessica', '84501-8274' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (5, 'Krystina Way', 'Mekhichester', 'DuBuqueville', '21927' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (6, 'Fahey Prairie', 'Rudyport', 'Gaychester', '76118-6858' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (7, 'Feil Crest', 'Creminville', 'East Haylie', '75748-2382' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (8, 'Jeanie Harbors', 'Marianeborough', 'Rohanshire', '73370' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (9, 'Linnea Hills', 'Port Kristy', 'Aurorehaven', '63704' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (10, 'Ruecker Lights', 'New Eldredside', 'West Jaclynmouth', '21927' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (11, 'Shawn Trail', 'New Joyfort', 'Port Isadorefurt', '25915' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (12, 'Nils Curve', 'Port Giles', 'South Archibald', '38364-5001' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (13, 'Adrain Spurs', 'Krajcikburgh', 'Kristoferstad', '66157' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (14, 'Tito Summit', 'East Erynbury', 'Lake Lesliechester', '16032-6631' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (15, 'Kirlin Underpass', 'Katelinton', 'Langworthfurt', '76656-3530' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (16, 'Mossie Dam', 'Kautzerburgh', 'Ankundingport', '74078' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (17, 'Feeney Grove', 'Quintonland', 'Lonzofurt', '84551' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (18, 'Leopoldo Ports', 'Norafurt', 'North Bernieceview', '58792' );
INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (19, 'Catherine Stravenue', 'Welchtown', 'Eulaville', '37695-5387' );

INSERT INTO TELEFONE(ID, NUMERO) VALUES (0, '861-552-6682 x743');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (1, '576-966-9425 x92432');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (2, '704-672-4523 x985');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (3, '294-047-5725 x399');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (4, '(390) 279-7893 x9039');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (5, '(846) 624-4501 x313');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (6, '(752) 344-7362 x865');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (7, '(815) 984-2044 x74041');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (8, '007.071.5809 x19998');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (9, '752.796.8195');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (10, '1-626-560-8025');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (11, '354-562-4177');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (12, '(058) 317-9552');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (13, '063.563.8197 x95704');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (14, '1-753-045-6370 x84491');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (15, '876-312-4619 x5915');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (16, '1-425-104-3347');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (17, '700-868-5211 x92873');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (18, '(143) 083-9985 x234');
INSERT INTO TELEFONE(ID, NUMERO) VALUES (19, '1-127-911-3072');

INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (0, 'Kacie', 17, 16);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (1, 'Aniya', 1, 10);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (2, 'Estrella', 10, 11);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (3, 'Carole', 8, 3);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (4, 'Otis', 11, 9);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (5, 'Annalise', 3, 5);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (6, 'Cecile', 16, 17);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (7, 'Gardner', 17, 15);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (8, 'Raegan', 13, 11);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (9, 'Kamron', 12, 19);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (10, 'Cathryn', 15, 9);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (11, 'Madison', 13, 0);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (12, 'Elias', 2, 17);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (13, 'Alexandre', 14, 5);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (14, 'Breana', 3, 2);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (15, 'Tiara', 9, 1);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (16, 'Ramon', 6, 0);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (17, 'Brandy', 6, 4);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (18, 'Cullen', 6, 0);
INSERT INTO AUTOR(ID, NOME, ENDERECO_ID, TELEFONE_ID)	VALUES (19, 'Kelsie', 1, 6);

INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (0, '7183', 'Donald', 7, 3);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (1, '4845', 'Reta', 0, 15);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (2, '0303', 'Otis', 7, 14);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (3, '1051', 'Sydni', 17, 0);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (4, '9545', 'Don', 19, 4);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (5, '6541', 'Danielle', 8, 6);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (6, '7205', 'Crystal', 14, 1);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (7, '6984', 'Clarissa', 5, 8);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (8, '8645', 'Lily', 12, 3);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (9, '7036', 'Roberto', 10, 10);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (10, '1213', 'Kaia', 13, 15);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (11, '6385', 'Josue', 13, 15);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (12, '9812', 'Alexzander', 1, 10);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (13, '5067', 'Allan', 10, 11);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (14, '6164', 'Kristin', 2, 4);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (15, '5191', 'Frankie', 16, 9);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (16, '0185', 'Ellen', 0, 6);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (17, '9658', 'Hobart', 8, 19);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (18, '4925', 'Daniela', 2, 2);
INSERT INTO EDITORA(ID, CNPJ_EDITORA, NOME, ENDERECO_ID, TELEFONE_ID) VALUES (19, '7011', 'Michale', 6, 3);

INSERT INTO GENERO (ID, GENERO) VALUES (0, 'Mobility');
INSERT INTO GENERO (ID, GENERO) VALUES (1, 'Accounts');
INSERT INTO GENERO (ID, GENERO) VALUES (2, 'Program');
INSERT INTO GENERO (ID, GENERO) VALUES (3, 'Interactions');
INSERT INTO GENERO (ID, GENERO) VALUES (4, 'Branding');
INSERT INTO GENERO (ID, GENERO) VALUES (5, 'Tactics');
INSERT INTO GENERO (ID, GENERO) VALUES (6, 'Web');
INSERT INTO GENERO (ID, GENERO) VALUES (7, 'Solutions');
INSERT INTO GENERO (ID, GENERO) VALUES (8, 'Infrastructure');
INSERT INTO GENERO (ID, GENERO) VALUES (9, 'Security');
INSERT INTO GENERO (ID, GENERO) VALUES (10, 'Data');
INSERT INTO GENERO (ID, GENERO) VALUES (11, 'Operations');
INSERT INTO GENERO (ID, GENERO) VALUES (12, 'Applications');
INSERT INTO GENERO (ID, GENERO) VALUES (13, 'Communications');
INSERT INTO GENERO (ID, GENERO) VALUES (14, 'Mobility');
INSERT INTO GENERO (ID, GENERO) VALUES (15, 'Security');
INSERT INTO GENERO (ID, GENERO) VALUES (16, 'Web');
INSERT INTO GENERO (ID, GENERO) VALUES (17, 'Data');
INSERT INTO GENERO (ID, GENERO) VALUES (18, 'Marketing');
INSERT INTO GENERO (ID, GENERO) VALUES (19, 'Metrics');

INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (0, 'Rogelio Kihn', 'Abigail.Heller', '5k2AGE55dVDUCBa', 15, 4);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (1, 'Greg Aufderhar', 'Cole_Cormier5', 'kLFdvOFVRTzP1UF', 17, 5);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (2, 'Carroll Mosciski', 'Wilford.Ziemann', 'hAHvzGBLWOS3umy', 14, 12);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (3, 'Nia Littel', 'Carissa.Adams', '6gzxMUD_WapHklv', 9, 4);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (4, 'Theron Abshire', 'Lexi.Beahan', '6wslDM7Fd8LxOOV', 4, 10);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (5, 'Kacey Schowalter', 'Marley.Strosin', 'e_AOpkv0GNAlH4A', 7, 0);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (6, 'Leif Hagenes', 'Demarcus51', 'upMAOzEAQgGyKac', 3, 12);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (7, 'Gerson Legros', 'Jolie_Barrows48', 'BHJGE5R5hGHZBUG', 4, 3);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (8, 'Margarette Schowalter', 'Cary.Mayert98', 'CciquPzsKAbYf_S', 5, 3);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (9, 'Demarcus Connelly', 'Felipe.Ruecker', '2UMBZFB8yWor5jS', 13, 6);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (10, 'Godfrey Wyman', 'Haskell33', 'kaaqWzOSuv9482Z', 19, 5);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (11, 'Jerrod Ernser', 'Sabina95', 'TQiPYhnOH19nJ_h', 3, 2);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (12, 'Lillie Tremblay', 'Matt35', 'uRHjwk8QX4XoesD', 4, 3);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (13, 'Thalia Jacobson', 'Thad.Braun35', 'VrxB7EjewgTceXA', 15, 17);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (14, 'Alia Schulist', 'Bobby27', 'QczWSP36dD0zk3q', 0, 7);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (15, 'Tabitha Hills', 'Serenity_Boehm', 'PByNdDlqtRiwK41', 2, 16);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (16, 'Orland Windler', 'Haylie_Bechtelar51', 'bcApA4Wne7iV9zH', 7, 10);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (17, 'Nannie Huels', 'Armando_Schumm', 'lrZXms2XOFEuzhY', 13, 3);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (18, 'Johan Huels', 'Baby_Jakubowski', 'ato72n3fz_0QkYn', 17, 13);
INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (19, 'Darlene Johnston', 'Libbie33', 'XPAleX_2nTeasBK', 6, 1);

INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (0, 'Global Operations Liaison', 1, 7, 18, 5, 1);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (1, 'Internal Accounts Coordinator', 2, 3, 2, 11, 13);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (2, 'Internal Integration Executive', 3, 15, 11, 11, 7);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (3, 'Senior Intranet Developer', 4, 10, 19, 7, 1);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (4, 'Product Configuration Officer', 5, 11, 6, 12, 2);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (5, 'Dynamic Data Planner', 6, 3, 13, 10, 7);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (6, 'District Factors Technician', 7, 2, 13, 10, 1);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (7, 'Principal Configuration Executive', 8, 18, 4, 17, 16);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (8, 'District Security Developer', 9, 10, 19, 17, 7);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (9, 'Dynamic Division Consultant', 10, 9, 8, 12, 6);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (10, 'Product Functionality Associate', 11, 10, 4, 8, 3);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (11, 'Chief Factors Technician', 12, 11, 3, 9, 17);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (12, 'Future Directives Strategist', 13, 7, 11, 2, 15);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (13, 'National Interactions Designer', 14, 6, 6, 3, 15);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (14, 'Senior Mobility Specialist', 15, 10, 11, 9, 5);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (15, 'Direct Markets Developer', 16, 18, 11, 12, 10);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (16, 'Human Accounts Administrator', 17, 3, 17, 18, 15);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (17, 'National Group Facilitator', 18, 7, 14, 9, 6);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (18, 'Forward Applications Director', 19, 16, 12, 2, 15);
INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (19, 'Chief Infrastructure Facilitator', 20, 3, 10, 7, 0);

INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (0, 0, 12);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (1, 0, 14);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (2, 1, 12);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (3, 1, 4);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (4, 2, 3);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (5, 2, 1);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (6, 3, 14);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (7, 3, 4);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (8, 4, 18);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (9, 4, 13);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (10, 5, 1);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (11, 5, 15);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (12, 6, 11);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (13, 6, 10);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (14, 7, 2);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (15, 7, 3);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (16, 8, 18);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (17, 8, 2);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (18, 9, 4);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (19, 9, 5);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (20, 10, 17);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (21, 10, 13);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (22, 11, 9);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (23, 11, 18);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (24, 12, 12);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (25, 12, 0);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (26, 13, 12);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (27, 13, 11);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (28, 14, 13);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (29, 14, 17);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (30, 15, 15);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (31, 15, 18);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (32, 16, 16);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (33, 16, 19);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (34, 17, 16);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (35, 17, 6);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (36, 18, 10);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (37, 18, 19);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (38, 19, 2);
INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (39, 19, 8);

INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (0, 0, 0);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (1, 0, 4);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (2, 1, 9);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (3, 1, 17);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (4, 2, 9);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (5, 2, 13);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (6, 3, 11);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (7, 3, 8);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (8, 4, 16);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (9, 4, 9);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (10, 5, 12);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (11, 5, 19);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (12, 6, 19);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (13, 6, 9);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (14, 7, 11);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (15, 7, 12);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (16, 8, 13);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (17, 8, 15);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (18, 9, 3);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (19, 9, 14);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (20, 10, 11);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (21, 10, 9);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (22, 11, 13);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (23, 11, 4);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (24, 12, 15);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (25, 12, 12);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (26, 13, 7);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (27, 13, 10);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (28, 14, 2);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (29, 14, 8);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (30, 15, 15);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (31, 15, 8);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (32, 16, 8);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (33, 16, 9);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (34, 17, 6);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (35, 17, 19);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (36, 18, 7);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (37, 18, 10);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (38, 19, 10);
INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (39, 19, 8);


SELECT * FROM LIVRO WHERE ID = 5;
SELECT * FROM LIVRO;

INSERT INTO EVENTO (ID, USUARIO_ID, LIVRO_ID, TIPO) VALUES (1, 12, 3, 'OFERECER');
INSERT INTO EVENTO (ID, USUARIO_ID, LIVRO_ID, TIPO) VALUES (2, 7, 18, 'OFERECER');
INSERT INTO EVENTO (ID, USUARIO_ID, LIVRO_ID, TIPO) VALUES (3, 7, 19, 'OFERECER');
INSERT INTO EVENTO (ID, USUARIO_ID, LIVRO_ID, TIPO) VALUES (4, 9, 5, 'OFERECER');
INSERT INTO EVENTO (ID, USUARIO_ID, LIVRO_ID, TIPO) VALUES (6, 9, 1, 'OFERECER');


INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (1, 2, 9, 1,  TO_DATE('2019/11/20 21:12:59', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (2, 14, 7, 18,  TO_DATE('2019/11/20 21:13:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (3, 5, 8, 19,  TO_DATE('2019/11/20 12:02:41', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (4, 17, 9, 5,  TO_DATE('2019/11/20 23:02:32', 'yyyy/mm/dd hh24:mi:ss');
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (5, 14, 7, 18,  TO_DATE('2019/11/20 15:02:52', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (6, 5, 7, 19,  TO_DATE('2019/11/20 10:12:23', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (7, 9, 9, 5,  TO_DATE('2019/11/20 00:21:25', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (8,12,13,9,  TO_DATE('2019/12/23 09:02:14', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (10, 1, 19,15,  TO_DATE('2019/12/30 06:52:23', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (11, 3, 9, 12,  TO_DATE('2019/11/2 18:22:59', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (12, 15, 1, 18,  TO_DATE('2019/11/12 00:13:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (13, 12, 19, 19,  TO_DATE('2019/11/13 08:28:41', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (14, 7, 17, 5,  TO_DATE('2019/11/10 23:05:32', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (15, 16,13, 18,  TO_DATE('2019/11/01 15:15:52', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (16, 9, 6, 19,  TO_DATE('2019/11/20 20:32:23', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (17, 8, 5, 5,  TO_DATE('2019/11/22 00:29:25', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (18,2,3,9,  TO_DATE('2019/12/27 09:02:14', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO HISTORICO (ID, USUARIO_DESTINATARIO_ID, USUARIO_REMETENTE_ID, LIVRO_ID, DATA_TROCA) VALUES (20, 1, 19,15,  TO_DATE('2019/12/30 06:52:23', 'yyyy/mm/dd hh24:mi:ss'));

SELECT * FROM HISTORICO;


/* Consultas Simples */

/* 1 Ranking dos três gêneros mais escritos */
SELECT COUNT(GENERO_ID) AS "Quantidade", GENERO_ID 
FROM GENERO_LIVRO
GROUP BY GENERO_ID
ORDER BY "Quantidade" DESC
FETCH FIRST 3 ROWS ONLY;


/* 2 Qual o livro mais trocado */
SELECT COUNT(LIVRO_ID) AS "Quantidade", LIVRO_ID
FROM HISTORICO
GROUP BY LIVRO_ID
ORDER BY "Quantidade" DESC
FETCH FIRST 1 ROWS ONLY;

/* 3 Quantas trocas de livros foram feitas no mês Novembro ?*/
SELECT to_char(DATA_TROCA, 'MONTH') AS "Mes", COUNT(DATA_TROCA) as "Quantidade de trocas"
FROM HISTORICO
WHERE to_char(DATA_TROCA, 'MONTH') = 'NOVEMBER '
GROUP BY to_char(DATA_TROCA, 'MONTH');

