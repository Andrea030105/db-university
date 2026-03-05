-- ============================================================
--  db_university.sql  --  Struttura + Dati (ottimizzato per esercizi)
--  Compatibile con MySQL / phpMyAdmin
-- ============================================================

SET FOREIGN_KEY_CHECKS = 0;
DROP DATABASE IF EXISTS `db_university`;
CREATE DATABASE `db_university`
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `db_university`;

-- -----------------------------------------------------------
-- DIPARTIMENTI  (id=54 richiesto per Matematica)
-- -----------------------------------------------------------
CREATE TABLE `dipartimenti` (
  `id`        INT          NOT NULL AUTO_INCREMENT,
  `nome`      VARCHAR(100) NOT NULL,
  `indirizzo` VARCHAR(150),
  `num_tel`   VARCHAR(20),
  `citta`     VARCHAR(50),
  `email`     VARCHAR(100),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

INSERT INTO `dipartimenti` (`id`, `nome`, `indirizzo`, `num_tel`, `citta`, `email`) VALUES
(1,  'Ingegneria Informatica',   'Via Tiburtina 205',         '06-11111111', 'Roma', 'inginfo@univroma.it'),
(2,  'Economia e Management',    'Via dei Fori Imperiali 1',  '06-22222222', 'Roma', 'economia@univroma.it'),
(3,  'Scienze della Formazione', 'Piazza della Repubblica 3', '06-33333333', 'Roma', 'sciforma@univroma.it'),
(4,  'Neuroscienze',             'Viale Regina Elena 291',    '06-44444444', 'Roma', 'neuroscienze@univroma.it'),
(54, 'Matematica',               'Piazzale Aldo Moro 5',      '06-55555555', 'Roma', 'matematica@univroma.it');
ALTER TABLE `dipartimenti` AUTO_INCREMENT = 55;

-- -----------------------------------------------------------
-- CORSO DI LAUREA
-- -----------------------------------------------------------
CREATE TABLE `corso_di_laurea` (
  `id`              INT          NOT NULL AUTO_INCREMENT,
  `dipartimenti_id` INT          NOT NULL,
  `nome`            VARCHAR(100) NOT NULL,
  `indirizzo`       VARCHAR(150),
  `sito`            VARCHAR(100),
  `email`           VARCHAR(100),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cdl_dip` FOREIGN KEY (`dipartimenti_id`)
    REFERENCES `dipartimenti`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO `corso_di_laurea` (`id`, `dipartimenti_id`, `nome`, `indirizzo`, `sito`, `email`) VALUES
(1,  1,  'Informatica (Triennale)',              'Via Tiburtina 205',        'www.inftri.univroma.it',    'inf.tri@univroma.it'),
(2,  1,  'Ingegneria del Software (Magistrale)', 'Via Tiburtina 205',        'www.infsw.univroma.it',     'inf.sw@univroma.it'),
(3,  2,  'Economia Aziendale (Triennale)',       'Via dei Fori Imperiali 1', 'www.ecotri.univroma.it',    'eco.tri@univroma.it'),
(4,  2,  'Management Digitale (Magistrale)',     'Via dei Fori Imperiali 1', 'www.mgtdig.univroma.it',    'mgt.dig@univroma.it'),
(5,  3,  'Scienze dell''Educazione (Triennale)','Piazza della Repubblica 3', 'www.sciedu.univroma.it',    'sci.edu@univroma.it'),
(6,  3,  'Pedagogia (Magistrale)',               'Piazza della Repubblica 3','www.pedag.univroma.it',     'pedagogia@univroma.it'),
(7,  4,  'Neuroscienze (Triennale)',             'Viale Regina Elena 291',   'www.neuro.univroma.it',     'neuro.tri@univroma.it'),
(8,  4,  'Neuroscienze Cognitive (Magistrale)',  'Viale Regina Elena 291',   'www.neurocog.univroma.it',  'neuro.mag@univroma.it'),
(9,  54, 'Matematica (Triennale)',               'Piazzale Aldo Moro 5',     'www.mattri.univroma.it',    'mat.tri@univroma.it'),
(10, 54, 'Matematica Applicata (Magistrale)',    'Piazzale Aldo Moro 5',     'www.matapp.univroma.it',    'mat.app@univroma.it');
ALTER TABLE `corso_di_laurea` AUTO_INCREMENT = 11;

-- -----------------------------------------------------------
-- STUDENTE  (anni iscrizione variati: 2020-2024)
-- -----------------------------------------------------------
CREATE TABLE `studente` (
  `id`              INT          NOT NULL AUTO_INCREMENT,
  `corso_laurea_id` INT          NOT NULL,
  `nome`            VARCHAR(50)  NOT NULL,
  `cognome`         VARCHAR(50)  NOT NULL,
  `matricola`       VARCHAR(20)  NOT NULL UNIQUE,
  `data_nascita`    DATE,
  `email`           VARCHAR(100),
  `codice_fiscale`  CHAR(16),
  `data_iscrizione` DATE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_stu_cdl` FOREIGN KEY (`corso_laurea_id`)
    REFERENCES `corso_di_laurea`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO `studente`
  (`corso_laurea_id`,`nome`,`cognome`,`matricola`,`data_nascita`,`email`,`codice_fiscale`,`data_iscrizione`) VALUES
-- Iscritti 2020
(1,  'Luca',       'Rossi',     'MAT001', '2001-03-15', 'luca.rossi@stud.it',       'RSSLCU01C15H501A', '2020-09-01'),
(3,  'Giulia',     'Bianchi',   'MAT002', '2000-07-22', 'giulia.bianchi@stud.it',   'BNCGLI00L62H501B', '2020-09-01'),
(9,  'Marco',      'Ferrari',   'MAT003', '2001-11-05', 'marco.ferrari@stud.it',    'FRRMRC01S05H501C', '2020-09-01'),
-- Iscritti 2021
(1,  'Sara',       'Conti',     'MAT004', '2001-01-30', 'sara.conti@stud.it',       'CNTSRA01A70H501D', '2021-09-01'),
(2,  'Alessandro', 'Mancini',   'MAT005', '1999-06-18', 'a.mancini@stud.it',        'MNCALS99H18H501E', '2021-09-01'),
(3,  'Chiara',     'Lombardi',  'MAT006', '2001-04-09', 'chiara.lombardi@stud.it',  'LMBCHR01D49H501F', '2021-09-01'),
(7,  'Davide',     'Ricci',     'MAT007', '2001-09-27', 'davide.ricci@stud.it',     'RCCDVD01P27H501G', '2021-09-01'),
-- Iscritti 2022
(4,  'Valentina',  'Marino',    'MAT008', '2000-12-03', 'v.marino@stud.it',         'MRNVNT00T43H501H', '2022-09-01'),
(4,  'Simone',     'Greco',     'MAT009', '1999-08-14', 'simone.greco@stud.it',     'GRCSMN99M14H501I', '2022-09-01'),
(5,  'Francesca',  'Bruno',     'MAT010', '2002-02-28', 'f.bruno@stud.it',          'BRNFNC02B68H501J', '2022-09-01'),
(8,  'Matteo',     'Gallo',     'MAT011', '2001-05-11', 'matteo.gallo@stud.it',     'GLLMTT01E11H501K', '2022-09-01'),
(10, 'Elena',      'Costa',     'MAT012', '2000-10-20', 'elena.costa@stud.it',      'CSTLNE00R60H501L', '2022-09-01'),
-- Iscritti 2023
(6,  'Giorgio',    'Esposito',  'MAT013', '2001-03-07', 'g.esposito@stud.it',       'SPSGRG01C07H501M', '2023-09-01'),
(1,  'Alessia',    'De Luca',   'MAT014', '2002-08-16', 'alessia.deluca@stud.it',   'DLCLSS02M56H501N', '2023-09-01'),
(3,  'Roberto',    'Barbieri',  'MAT015', '2001-11-24', 'r.barbieri@stud.it',       'BRBRRT01S24H501O', '2023-09-01'),
(7,  'Federica',   'Moretti',   'MAT016', '2002-06-30', 'f.moretti@stud.it',        'MRTFDR02H70H501P', '2023-09-01'),
(9,  'Antonio',    'Palumbo',   'MAT017', '2001-04-12', 'a.palumbo@stud.it',        'PLMNTN01D12H501Q', '2023-09-01'),
-- Iscritti 2024
(2,  'Claudia',    'Ferrara',   'MAT018', '2002-09-05', 'c.ferrara@stud.it',        'FRRCLD02P45H501R', '2024-09-01'),
(5,  'Stefano',    'Leone',     'MAT019', '2003-01-17', 's.leone@stud.it',          'LNESTF03A17H501S', '2024-09-01'),
(8,  'Maria',      'Santoro',   'MAT020', '2002-07-08', 'maria.santoro@stud.it',    'SNTMRA02L48H501T', '2024-09-01');

-- -----------------------------------------------------------
-- CORSI
-- -----------------------------------------------------------
CREATE TABLE `corsi` (
  `id`              INT          NOT NULL AUTO_INCREMENT,
  `corso_laurea_id` INT          NOT NULL,
  `nome`            VARCHAR(100) NOT NULL,
  `descrizione`     TEXT,
  `durata`          INT          COMMENT 'ore',
  `cfu`             INT,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cor_cdl` FOREIGN KEY (`corso_laurea_id`)
    REFERENCES `corso_di_laurea`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO `corsi` (`id`, `corso_laurea_id`, `nome`, `descrizione`, `durata`, `cfu`) VALUES
(1,  1,  'Programmazione I',             'Fondamenti di programmazione in C e Python',       60, 9),
(2,  1,  'Basi di Dati',                 'Progettazione e gestione di database relazionali', 60, 9),
(3,  1,  'Reti di Calcolatori',          'Architetture e protocolli di rete',                48, 6),
(4,  2,  'Ingegneria del Software',      'Metodologie agili e design pattern',               60, 9),
(5,  2,  'Machine Learning',             'Algoritmi di apprendimento automatico',            60, 9),
(6,  3,  'Microeconomia',                'Teoria del consumatore e dell''impresa',           60, 9),
(7,  3,  'Diritto Commerciale',          'Contratti e normative aziendali',                  48, 6),
(8,  4,  'Marketing Digitale',           'SEO, SEM e social media strategy',                48, 6),
(9,  4,  'Business Intelligence',        'Analisi dei dati aziendali',                      60, 9),
(10, 5,  'Pedagogia Generale',           'Teorie e metodi educativi',                       60, 9),
(11, 5,  'Psicologia dell''Educazione',  'Sviluppo cognitivo e apprendimento',              48, 6),
(12, 6,  'Didattica Speciale',           'Metodologie per l''inclusione scolastica',        60, 9),
(13, 7,  'Biologia Cellulare',           'Struttura e funzione delle cellule',              60, 9),
(14, 7,  'Anatomia del Sistema Nervoso', 'Struttura del sistema nervoso centrale',          60, 9),
(15, 8,  'Neuropsicologia',              'Basi neurali delle funzioni cognitive',           60, 9),
(16, 8,  'Neuroimaging',                 'Tecniche di imaging cerebrale avanzate',          48, 6),
(17, 9,  'Analisi Matematica I',         'Calcolo differenziale e integrale',               72, 12),
(18, 9,  'Algebra Lineare',              'Spazi vettoriali e trasformazioni lineari',       60, 9),
(19, 10, 'Equazioni Differenziali',      'Metodi analitici e numerici',                    60, 9),
(20, 10, 'Statistica Avanzata',          'Modelli statistici e inferenza',                 60, 9);
ALTER TABLE `corsi` AUTO_INCREMENT = 21;

-- -----------------------------------------------------------
-- INSEGNANTI  (campo ufficio per GROUP BY; id=44 = Fulvio Amato)
-- -----------------------------------------------------------
CREATE TABLE `insegnanti` (
  `id`       INT         NOT NULL AUTO_INCREMENT,
  `corsi_id` INT         NOT NULL,
  `nome`     VARCHAR(50) NOT NULL,
  `cognome`  VARCHAR(50) NOT NULL,
  `livello`  VARCHAR(50),
  `ufficio`  VARCHAR(50) COMMENT 'Edificio dove si trova l''ufficio',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ins_cor` FOREIGN KEY (`corsi_id`)
    REFERENCES `corsi`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO `insegnanti` (`id`, `corsi_id`, `nome`, `cognome`, `livello`, `ufficio`) VALUES
(1,  1,  'Giovanni', 'Ferretti',  'Professore Ordinario', 'Edificio A'),
(2,  2,  'Maria',    'Santoro',   'Professore Associato', 'Edificio A'),
(3,  3,  'Paolo',    'Vitale',    'Ricercatore',          'Edificio A'),
(4,  4,  'Laura',    'Pellegrino','Professore Ordinario', 'Edificio B'),
(5,  5,  'Antonio',  'Serra',     'Professore Associato', 'Edificio B'),
(6,  6,  'Claudia',  'Fabbri',    'Professore Ordinario', 'Edificio C'),
(7,  7,  'Renato',   'Silvestri', 'Ricercatore',          'Edificio C'),
(8,  8,  'Cristina', 'Orlando',   'Professore Associato', 'Edificio C'),
(9,  9,  'Daniele',  'Caruso',    'Professore Ordinario', 'Edificio D'),
(10, 10, 'Federica', 'Basile',    'Professore Ordinario', 'Edificio D'),
(11, 11, 'Stefano',  'Montanari', 'Ricercatore',          'Edificio D'),
(12, 12, 'Paola',    'Catalano',  'Professore Associato', 'Edificio E'),
(13, 13, 'Roberto',  'Ferrario',  'Professore Ordinario', 'Edificio E'),
(14, 14, 'Silvia',   'Russo',     'Professore Associato', 'Edificio E'),
(15, 15, 'Marco',    'Moretti',   'Professore Ordinario', 'Edificio F'),
(16, 16, 'Anna',     'Conti',     'Ricercatore',          'Edificio F'),
(17, 17, 'Pietro',   'Romano',    'Professore Ordinario', 'Edificio G'),
(18, 18, 'Luisa',    'Gatti',     'Professore Associato', 'Edificio G'),
(19, 19, 'Carlo',    'Ricci',     'Professore Ordinario', 'Edificio G'),
(20, 20, 'Teresa',   'Marini',    'Ricercatore',          'Edificio G'),
(44, 17, 'Fulvio',   'Amato',     'Professore Associato', 'Edificio G');
ALTER TABLE `insegnanti` AUTO_INCREMENT = 45;

-- -----------------------------------------------------------
-- ESAMI  (voto incluso; appelli variati per GROUP BY)
-- -----------------------------------------------------------
CREATE TABLE `esami` (
  `id`               INT        NOT NULL AUTO_INCREMENT,
  `corso_id`         INT        NOT NULL,
  `studente_id`      INT        NOT NULL,
  `n_appello`        INT,
  `data`             DATE,
  `luogo`            VARCHAR(100),
  `ora`              TIME,
  `validita_esonero` TINYINT(1) DEFAULT 0,
  `voto`             TINYINT    COMMENT '18-30, NULL = non sostenuto',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_esa_cor` FOREIGN KEY (`corso_id`)
    REFERENCES `corsi`(`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_esa_stu` FOREIGN KEY (`studente_id`)
    REFERENCES `studente`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO `esami`
  (`corso_id`,`studente_id`,`n_appello`,`data`,`luogo`,`ora`,`validita_esonero`,`voto`) VALUES
-- Appello 1 (gennaio)
(1,  1,  1, '2024-01-15', 'Aula A1',  '09:00:00', 0, 28),
(1,  4,  1, '2024-01-15', 'Aula A1',  '09:00:00', 0, 22),
(1, 14,  1, '2024-01-15', 'Aula A1',  '09:00:00', 0, 25),
(2,  1,  1, '2024-01-22', 'Aula B2',  '11:00:00', 1, 27),
(2,  4,  1, '2024-01-22', 'Aula B2',  '11:00:00', 1, 18),
(6,  2,  1, '2024-01-20', 'Aula C1',  '09:00:00', 0, 24),
(6,  6,  1, '2024-01-20', 'Aula C1',  '09:00:00', 0, 21),
(6, 15,  1, '2024-01-20', 'Aula C1',  '09:00:00', 0, 19),
(17, 3,  1, '2024-01-18', 'Aula G1',  '09:00:00', 0, 30),
(17,17,  1, '2024-01-18', 'Aula G1',  '09:00:00', 0, 26),
(15,11,  1, '2024-01-25', 'Aula F1',  '10:00:00', 0, 28),
(15,20,  1, '2024-01-25', 'Aula F1',  '10:00:00', 0, 23),
-- Appello 2 (febbraio)
(1,  1,  2, '2024-02-10', 'Aula A1',  '09:00:00', 0, 30),
(3,  1,  2, '2024-02-05', 'Lab Reti', '14:00:00', 0, 29),
(3, 14,  2, '2024-02-05', 'Lab Reti', '14:00:00', 0, 22),
(6,  2,  2, '2024-02-12', 'Aula C1',  '09:00:00', 0, 26),
(18, 3,  2, '2024-02-08', 'Aula G2',  '11:00:00', 0, 27),
(18,12,  2, '2024-02-08', 'Aula G2',  '11:00:00', 0, 24),
(4,  5,  2, '2024-02-14', 'Aula B3',  '10:00:00', 0, 25),
(4, 18,  2, '2024-02-14', 'Aula B3',  '10:00:00', 0, 29),
-- Appello 3 (giugno)
(2,  1,  3, '2024-06-17', 'Aula B2',  '11:00:00', 0, 29),
(5,  5,  3, '2024-06-24', 'Aula B3',  '09:00:00', 1, 30),
(5, 18,  3, '2024-06-24', 'Aula B3',  '09:00:00', 1, 28),
(7,  6,  3, '2024-06-10', 'Aula C2',  '11:00:00', 0, 24),
(7, 15,  3, '2024-06-10', 'Aula C2',  '11:00:00', 0, 20),
(19,12,  3, '2024-06-20', 'Aula H1',  '09:00:00', 0, 27),
(19, 3,  3, '2024-06-20', 'Aula H1',  '09:00:00', 0, 25),
(13, 7,  3, '2024-06-15', 'Aula E1',  '10:00:00', 0, 22),
(16,11,  3, '2024-06-18', 'Aula F2',  '14:00:00', 0, 26),
(20,12,  3, '2024-06-22', 'Aula H2',  '11:00:00', 1, 30);

SET FOREIGN_KEY_CHECKS = 1;
