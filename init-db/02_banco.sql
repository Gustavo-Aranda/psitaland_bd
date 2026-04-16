-- Gerado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   em:        2026-03-26 14:12:10 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE ESPECIES 
    ( 
     esp_id   NUMBER (5)  NOT NULL , 
     esp_nome VARCHAR2 (100) 
         CONSTRAINT CK_ESP_NN_01 NOT NULL 
    ) 
;

COMMENT ON TABLE ESPECIES IS 'A tabela ESPECIES tem a função de armazenar os nomes das espécies de aves cadastradas no sistema. Sua criação permite a classificação correta dos pássaros e evita a redundância de nomes. '
;

COMMENT ON COLUMN ESPECIES.esp_id IS 'chave primária da tabela ESPECIES
' 
;

COMMENT ON COLUMN ESPECIES.esp_nome IS 'nome da espécie' 
;

ALTER TABLE ESPECIES 
    ADD CONSTRAINT PK_ESP PRIMARY KEY ( esp_id ) ;

CREATE TABLE GAIOLAS 
    ( 
     gai_id     NUMBER (5)  NOT NULL , 
     gai_numero VARCHAR2 (10) 
         CONSTRAINT CK_GAI_NN_01 NOT NULL 
    ) 
;

COMMENT ON TABLE GAIOLAS IS 'Tabela criada para gerenciar as unidades de alojamento (gaiolas) disponíveis, permitindo o controle de onde cada pássaro está localizado. '
;

COMMENT ON COLUMN GAIOLAS.gai_id IS 'chave primária da tabela GAIOLAS' 
;

COMMENT ON COLUMN GAIOLAS.gai_numero IS 'numero da gaiola' 
;

ALTER TABLE GAIOLAS 
    ADD CONSTRAINT PK_GAI PRIMARY KEY ( gai_id ) ;

CREATE TABLE MUTACOES 
    ( 
     mut_id        NUMBER (5)  NOT NULL , 
     mut_descriçao VARCHAR2 (100) 
         CONSTRAINT CK_MUT_NN_01 NOT NULL 
    ) 
;

COMMENT ON TABLE MUTACOES IS 'A tabela MUTACOES armazena as variações genéticas ou tipos específicos de cores/características que uma ave pode possuir. '
;

COMMENT ON COLUMN MUTACOES.mut_id IS 'chave primária da tabela MUTACOES
' 
;

COMMENT ON COLUMN MUTACOES.mut_descriçao IS 'descrição da mutação' 
;

ALTER TABLE MUTACOES 
    ADD CONSTRAINT PK_MUT PRIMARY KEY ( mut_id ) ;

CREATE TABLE PASSAROS 
    ( 
     pas_id        NUMBER (5)  NOT NULL , 
     pas_anilha    VARCHAR2 (100) 
         CONSTRAINT CK_PASS_NN_01 NOT NULL , 
     pas_data_nasc DATE 
         CONSTRAINT CK_PASS_NN_02 NOT NULL , 
     pas_sexo      VARCHAR2 (1) 
         CONSTRAINT CK_PASS_NN_03 NOT NULL , 
     pas_esp_id    NUMBER (5) 
         CONSTRAINT CK_PAS_NN_04 NOT NULL , 
     pas_mut_id    NUMBER (5) 
         CONSTRAINT CK_PAS_NN_05 NOT NULL , 
     pas_gai_id    NUMBER (5) 
         CONSTRAINT CK_PAS_NN_06 NOT NULL , 
     pas_stt_id    NUMBER (5) 
         CONSTRAINT CK_PAS_NN_07 NOT NULL , 
     pas_not_fis   VARCHAR2 (100) 
         CONSTRAINT CK_PASS_NN_08 NOT NULL 
    ) 
;

COMMENT ON TABLE PASSAROS IS 'Tabela principal responsável por armazenar os dados individuais de cada ave, centralizando as informações de identificação, nascimento, sexo e nota fiscal, além de relacionar o pássaro com sua espécie, mutação, localização e status atual. '
;

COMMENT ON COLUMN PASSAROS.pas_id IS 'chave primária da tabela PASSAROS' 
;

COMMENT ON COLUMN PASSAROS.pas_anilha IS 'Campo destinado para a anilha do pássaro' 
;

COMMENT ON COLUMN PASSAROS.pas_data_nasc IS 'Campo destinado para a data de nascimento do pássaro' 
;

COMMENT ON COLUMN PASSAROS.pas_sexo IS 'Campo para designar o sexo do pássaro (M ou F)' 
;

COMMENT ON COLUMN PASSAROS.pas_esp_id IS 'Chave estrangeira para referência do id da espécie  do pássaro' 
;

COMMENT ON COLUMN PASSAROS.pas_mut_id IS 'Chave estrangeira para referência do id da mutação do pássaro' 
;

COMMENT ON COLUMN PASSAROS.pas_gai_id IS 'Chave estrangeira para referência do id da gaiola  do pássaro' 
;

COMMENT ON COLUMN PASSAROS.pas_stt_id IS 'Chave estrangeira para referência do id da status do pássaro' 
;

COMMENT ON COLUMN PASSAROS.pas_not_fis IS 'Campo destinado para a nota fiscal do pássaro' 
;

ALTER TABLE PASSAROS 
    ADD CONSTRAINT PK_PAS PRIMARY KEY ( pas_id ) ;

CREATE TABLE STATUS 
    ( 
     stt_id       NUMBER (5)  NOT NULL , 
     stt_situacao VARCHAR2 (100) 
         CONSTRAINT CK_STT_NN_01 NOT NULL 
    ) 
;

COMMENT ON TABLE STATUS IS 'Registra as possíveis situações em que um pássaro pode se encontrar no plantel (ex: disponível,  vendido). '
;

COMMENT ON COLUMN STATUS.stt_id IS 'chave primária da tabela STATUS' 
;

COMMENT ON COLUMN STATUS.stt_situacao IS 'Campo para o status da ave' 
;

ALTER TABLE STATUS 
    ADD CONSTRAINT PK_STT PRIMARY KEY ( stt_id ) ;

ALTER TABLE PASSAROS 
    ADD CONSTRAINT FK_PAS_ESP FOREIGN KEY 
    ( 
     pas_esp_id
    ) 
    REFERENCES ESPECIES 
    ( 
     esp_id
    ) 
;

ALTER TABLE PASSAROS 
    ADD CONSTRAINT FK_PAS_GAI FOREIGN KEY 
    ( 
     pas_gai_id
    ) 
    REFERENCES GAIOLAS 
    ( 
     gai_id
    ) 
;

ALTER TABLE PASSAROS 
    ADD CONSTRAINT FK_PAS_MUT FOREIGN KEY 
    ( 
     pas_mut_id
    ) 
    REFERENCES MUTACOES 
    ( 
     mut_id
    ) 
;

ALTER TABLE PASSAROS 
    ADD CONSTRAINT FK_PAS_STT FOREIGN KEY 
    ( 
     pas_stt_id
    ) 
    REFERENCES STATUS 
    ( 
     stt_id
    ) 
;

CREATE TABLE HESPECIES 
(
    ESP_ID NUMBER(5),
    ESP_NOME VARCHAR2(100),
    HESP_DT_INCLUSAO DATE
);

CREATE TABLE HMUTACOES 
(
    MUT_ID NUMBER(5),
    MUT_DESCRICAO VARCHAR2(100),
    HMUT_DT_INCLUSAO DATE
);

CREATE TABLE HSTATUS 
(
    STT_ID NUMBER(5),
    STT_SITUACAO VARCHAR2(100),
    HSTT_DT_INCLUSAO DATE
);

CREATE TABLE HPASSAROS 
(
    PAS_ID NUMBER(5),
    PAS_ANILHA VARCHAR2(100),
    PAS_DATA_NASC DATE,
    PAS_SEXO VARCHAR2(10),
    PAS_ESP_ID NUMBER(5),
    PAS_MUT_ID NUMBER(5),
    PAS_GAI_ID NUMBER(5),
    PAS_STT_ID NUMBER(5),
    PAS_NOT_FIS VARCHAR2(100),
    HPAS_DT_INCLUSAO DATE
);

CREATE TABLE HGAIOLAS 
(
    GAI_ID NUMBER(5),
    GAI_NUMERO VARCHAR2(10),
    HGAI_DT_INCLUSAO DATE
);




-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             5
-- CREATE INDEX                             0
-- ALTER TABLE                              9
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
