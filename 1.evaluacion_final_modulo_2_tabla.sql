--Script completo con la creación de la base de datos

-- TABLAS

drop table USUARIO;
CREATE TABLE USUARIO(   --Creando Tabla USUARIO
    RUNUSUARIO NUMBER(9) CONSTRAINT USUARIO_PK PRIMARY KEY, 
	USNOMBRE VARCHAR2(30) CONSTRAINT USUARIO_nn1 NOT NULL, 
	USAPELLIDO VARCHAR2(50) CONSTRAINT USUARIO_nn2 NOT NULL, 
	USNACIMIENTO DATE
    );

drop table CLIENTE;
CREATE TABLE CLIENTE(   --Creando Tabla CLIENTE  perfil 1
    RUTCLIENTE NUMBER(9) CONSTRAINT CLIENTE_PK PRIMARY KEY, 
	CLITELEFONO VARCHAR2(20) CONSTRAINT CLIENTE_nn1 NOT NULL , 
	CLIAFP VARCHAR2(30), 
	CLISISTEMASALUD NUMBER(2), 
	CLIDIRECCION VARCHAR2(100)CONSTRAINT CLIENTE_nn2 NOT NULL, 
	CLICOMUNA VARCHAR2(50)CONSTRAINT CLIENTE_nn3 NOT NULL, 
	CLIEDAD NUMBER(3) CONSTRAINT CLIENTE_nn4 NOT NULL,
    USUARIO_RUNUSUARIO NUMBER(9) CONSTRAINT CLIENTE_nn5 NOT NULL
    );

drop table CAPACITACION;
CREATE TABLE CAPACITACION(   --Creando Tabla CAPACITACION
    IDCAPACITACION NUMBER(9) CONSTRAINT CAPACITACION_PK PRIMARY KEY,
    CAPFECHA DATE CONSTRAINT CAPACITACION_nn1 NOT NULL ,
    CAPHORA DATE,
    CAPLUGAR VARCHAR2(100) CONSTRAINT CAPACITACION_nn2 NOT NULL,
    CAPDURACION NUMBER(4),
    CLIENTE_RUTCLIENTE NUMBER(9) CONSTRAINT CAPACITACION_nn3 NOT NULL
    );

drop table Asistentes;
create table Asistentes (   --Creando Tabla Asistentes
idasistente number(9) CONSTRAINT Asistentes_pk PRIMARY KEY,
asistnombrecompleto varchar2(100) CONSTRAINT  asistentes_nn1 not null,
asistedad number(3) CONSTRAINT  asistentes_nn2 not null,
asistcorreo varchar2 (70),
asisttelefono varchar2(20),
Capacitacion_idcapacitacion number (9) CONSTRAINT  asistentes_nn3 not null
);

drop table visita;
CREATE TABLE visita (   --Creando Tabla visita
idvisita number(9) CONSTRAINT visita_pk PRIMARY KEY,
visfecha date CONSTRAINT visita_nn1 NOT NULL,
vishora date ,
vislugar varchar2(50) CONSTRAINT visita_nn2 NOT NULL,
viscomentarios varchar2(250) CONSTRAINT visita_nn3 NOT NULL,
cliente_rutcliente number(9) CONSTRAINT visita_nn4 NOT NULL
);

drop table chequeo;
CREATE TABLE chequeo (   --Creando Tabla registrochequeo
idchequeo number(9) CONSTRAINT chequeo_pk PRIMARY KEY,
nombre varchar2(30) CONSTRAINT chequeo_nn1 NOT NULL,
detalle varchar2(100) CONSTRAINT chequeo_nn2 NOT NULL
);

drop table registrochequeo;
CREATE TABLE registrochequeo (   --Creando Tabla registrochequeo
visita_idvisita number(9) ,
chequeo_idchequeo number(9),
CONSTRAINT registrochequeo_pk PRIMARY KEY(visita_idvisita,chequeo_idchequeo),
estado varchar2(50) CONSTRAINT registrochequeo_nn1 NOT NULL
);

drop table accidente;
create table accidente (   --Creando Tabla accidente
idaccidente number(9) CONSTRAINT accidente_pk PRIMARY KEY,
accifecha date CONSTRAINT acidente_nn1 not null,
accihora date CONSTRAINT acidente_nn2 not null,
accilugar varchaR2(150),
acciorigen varchar2(100) CONSTRAINT acidente_nn3 not null,
acciconsecuencias varchar2(100),
cliente_rutcliente number (9) CONSTRAINT acidente_nn4 not null
);

drop table administrativo;
create table administrativo (   --Creando Tabla administrativo perfil 2
usuario_runusuario number(9) CONSTRAINT administrativo_pk PRIMARY KEY,
adcorreo varchar2(70),
adarea varchar2(20) CONSTRAINT administrativo_nn1 not null,
);

drop table PROFESIONAL;
CREATE TABLE PROFESIONAL(   --Creando Tabla PROFESIONAL perfil 3
    USUARIO_RUNUSUARIO NUMBER(9) CONSTRAINT PROFESIONAL_PK PRIMARY KEY,
    PROTELEFONO NUMBER(20),
    PROTITULO VARCHAR(50)CONSTRAINT PROFESIONAL_nn1 not null,
    PROPORYECTO VARCHAR(80),
);

drop table ASESORIAS;
CREATE TABLE ASESORIAS(
    IDASESORIA NUMBER(9) CONSTRAINT ASESORIAS_PK PRIMARY KEY, 
    ASFECHA DATE CONSTRAINT ASESORIAS_nn1 not null,
    ASMOTIVO VARCHAR2(100) CONSTRAINT ASESORIAS_nn2 not null,
    PROFESIONAL_RUNPROFESIONAL NUMBER(9) CONSTRAINT ASESORIAS_nn3 not null,
    CLIENTE_RUTCLIENTE NUMBER(9) CONSTRAINT ASESORIAS_nn4 not null
);    

drop table MEJORAS;
CREATE TABLE MEJORAS(
    IDMEJORA NUMBER(9) CONSTRAINT MEJORAS_PK PRIMARY KEY,
    METITULO VARCHAR2(50) CONSTRAINT MEJORAS_nn1 not null, 
    MEDESCRIPCION VARCHAR2(250) CONSTRAINT MEJORAS_nn2 not null,
    MEPLAZO NUMBER(9) CONSTRAINT MEJORAS_nn3 not null,
    ASESORIAS_IDASESORIA NUMBER(9) CONSTRAINT MEJORAS_nn4 not null
    );

drop table pago;
create table pago (
idpago NUMBER(9) CONSTRAINT pagO_pk PRIMARY KEY,
PAGfecha date CONSTRAINT pago_nn1  not null,
PAGmonto NUMBER(12) CONSTRAINT pago_nn2 not null,
PAGmes VARCHAR2(2) CONSTRAINT pago_nn3 not null,
PAGanyo VARCHAR2(4) CONSTRAINT pago_nn4 not null,
CLIENTE_RUTCLIENTE NUMBER(9) CONSTRAINT pago_nn5 not null
);

commit;
  
-- CREANDO FOREIGN KEY

ALTER TABLE CLIENTE   --llave foranea CLIENTE
ADD CONSTRAINT CLIENTE_USUARIO_FK
FOREIGN KEY(USUARIO_RUNUSUARIO)
REFERENCES USUARIO(RUNUSUARIO); 

ALTER TABLE CAPACITACION   --llave foranea CAPACITACION
ADD CONSTRAINT CAPACITACION_CLIENTE_FK
FOREIGN KEY(CLIENTE_RUTCLIENTE)
REFERENCES CLIENTE(RUTCLIENTE);

ALTER TABLE Asistentes   --llave foranea Asistentes
ADD CONSTRAINT Asistentes_CAPACITACION_FK
FOREIGN KEY(CAPACITACION_IDCAPACITACION)
REFERENCES CAPACITACION(IDCAPACITACION); 

ALTER TABLE visita   --llave foranea visita
ADD CONSTRAINT visita_cliente_fk
FOREIGN KEY ( cliente_rutcliente )
REFERENCES cliente ( rutcliente );

ALTER TABLE registrochequeo   --llave foranea registrochequeo con visita
ADD CONSTRAINT registrochequeo_visita_fk
FOREIGN KEY ( visita_idvisita )
REFERENCES visita ( idvisita );

ALTER TABLE registrochequeo   --llave foranea registrochequeo con chequeo
ADD CONSTRAINT registrochequeo_chequeo_fk
FOREIGN KEY ( chequeo_idchequeo )
REFERENCES chequeo ( idchequeo );

ALTER TABLE accidente   --llave foranea accidente
ADD CONSTRAINT accidente_CLIENTE_fk
FOREIGN KEY ( CLIENTE_RUTCLIENTE )
REFERENCES CLIENTE ( RUTCLIENTE );

ALTER TABLE administrativo   --llave foranea administrativo
ADD CONSTRAINT administrativo_usuario_fk
FOREIGN KEY ( usuario_runusuario )
REFERENCES usuario ( runusuario );

ALTER TABLE PROFESIONAL   --llave foranea PROFESIONAL 
ADD CONSTRAINT PROFESIONAL_USUARIO_FK
FOREIGN KEY(USUARIO_RUNUSUARIO)
REFERENCES USUARIO(RUNUSUARIO);

ALTER TABLE ASESORIAS   --llave foranea ASESORIAS con PROFESIONAL
ADD CONSTRAINT ASESORIAS_PROFESIONAL_FK
FOREIGN KEY(PROFESIONAL_RUNPROFESIONAL)
REFERENCES PROFESIONAL(RUNPROFESIONAL);

ALTER TABLE ASESORIAS   --llave foranea ASESORIAS con CLIENTE
ADD CONSTRAINT ASESORIAS_CLIENTE_FK
FOREIGN KEY(CLIENTE_RUTCLIENTE)
REFERENCES CLIENTE(RUTCLIENTE);

ALTER TABLE MEJORAS   --llave foranea MEJORAS 
ADD CONSTRAINT MEJORAS_ASESORIAS_FK
FOREIGN KEY(ASESORIAS_IDASESORIA)
REFERENCES ASESORIAS(IDASESORIA);

ALTER TABLE pago   --llave foranea pago
ADD CONSTRAINT pago_cliente_FK
FOREIGN KEY(cliente_rutcliente)
REFERENCES cliente(rutcliente);

commit;

-- CREANDO SECUENCIAS

-- identificador correlativo autoincremental tabla pago
create sequence idpago_seq;   --secuencia  

CREATE OR REPLACE TRIGGER idpago_trigger   -- Disparador
BEFORE INSERT ON pago
FOR EACH ROW
WHEN (new.idpago IS NULL)
BEGIN
 SELECT idpago_seq.NEXTVAL
 INTO :new.idpago
 FROM dual;
END;
/

-- identificador correlativo autoincremental tabla asesorias
create sequence idasesoria_seq;   --secuencia 

CREATE OR REPLACE TRIGGER idasesoria_trigger   -- Disparador
BEFORE INSERT ON asesorias
FOR EACH ROW
WHEN (new.idasesoria IS NULL)
BEGIN
 SELECT idasesoria_seq.NEXTVAL
 INTO :new.idasesoria
 FROM dual;
END;
/

commit;

