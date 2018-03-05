--Biblioteca
--Script para creacion de tablas en la BD
--Por Gabriel,Bryan,Nelson y Leonardo
--Creado sábado,4 de marzo de 2018
--Universidad Centroamericana ISI

-- Tabla Usuario
CREATE TABLE usuario (
    idusuario        NUMBER(5) PRIMARY KEY,
    nombre           VARCHAR2(20) NOT NULL,
    apellido         VARCHAR2(20) NOT NULL,
    identificacion   VARCHAR2(20) NOT NULL,
    sexo             VARCHAR2(15),
    nacionalidad     VARCHAR2(20)
);

-- Tabla Ubicación

CREATE TABLE ubicacion (
    idubicacion   NUMBER(3) PRIMARY KEY,
    nombre        VARCHAR2(20) NOT NULL
);

-- TABLA Autor

CREATE TABLE autor (
    idautor           NUMBER(5) PRIMARY KEY,
    nombre            VARCHAR2(20) NOT NULL,
    apellido          VARCHAR2(20) NOT NULL,
    sexo              NUMBER(10) NULL,
    nacionalidad      VARCHAR2(15) NULL,
    fechanacimiento   DATE NULL
);

-- TABLA Bibliotecario

CREATE TABLE bibliotecario (
    idbibliotecario   NUMBER(3) PRIMARY KEY,
    nombre            VARCHAR2(20) NOT NULL,
    apellido          VARCHAR2(20) NOT NULL
);

-- Tabla Estado

CREATE TABLE estado (
    idestado   NUMBER(2) PRIMARY KEY,
    estado     VARCHAR2(20)
);

-- Tabla TipoDocumento

CREATE TABLE tipodocumento (
    idtipodocumento   NUMBER(2) PRIMARY KEY,
    nombre            VARCHAR2(10) NOT NULL
);

-- TABLA CategoriaGeneral

CREATE TABLE categoriageneral (
    codigogeneral   NUMBER(3) PRIMARY KEY,
    nombre          VARCHAR(50) NOT NULL
);

-- TABLA CategoriaEspecial

CREATE TABLE categoriaespecial (
    codigoespecial   NUMBER(3) PRIMARY KEY,
    nombre           VARCHAR2(50) NOT NULL,
    codigogeneral    NUMBER(3) NOT NULL
        CONSTRAINT fk_catespecial_catgeneral
            REFERENCES categoriageneral ( codigogeneral )
);

-- Tabla Editorial

CREATE TABLE editorial (
    ideditorial   NUMBER(3) PRIMARY KEY,
    nombre        VARCHAR(30) NOT NULL,
    idubicacion   NUMBER(3) NOT NULL
        CONSTRAINT fk_editorial_ubicacion
            REFERENCES ubicacion ( idubicacion )
);

-- TABLA LIBRO

CREATE TABLE libro (
    idlibro            NUMBER(7),
    isbn               VARCHAR2(13),
    CONSTRAINT pk_libro PRIMARY KEY ( idlibro,isbn ),
    titulo             VARCHAR2(50) NOT NULL,
    fechapublicacion   DATE NOT NULL,
    edicion            VARCHAR2(10),
    descripcion        VARCHAR2(300),
    paginas            NUMBER(4),
    numejemplares      NUMBER(2) NOT NULL,
    idubicacion        NUMBER(3) NOT NULL
        CONSTRAINT fk_ubicacion_libro
            REFERENCES ubicacion ( idubicacion ),
    idestado           NUMBER(2) NOT NULL
        CONSTRAINT fk_estado_libro
            REFERENCES estado ( idestado ),
    idtipodocumento    NUMBER(3) NOT NULL
        CONSTRAINT fk_tipodocumento_libro
            REFERENCES tipodocumento ( idtipodocumento ),
    codigo             NUMBER(3) NOT NULL
        CONSTRAINT fk_codigogeneral_libro
            REFERENCES categoriageneral ( codigogeneral ),
    codigoespecial     NUMBER(3) NOT NULL
        CONSTRAINT fk_codigoespecial_libro
            REFERENCES categoriaespecial ( codigoespecial )
);

-- TABLA PRESTAMO

CREATE TABLE prestamo (
    idprestamo        NUMBER(6) PRIMARY KEY,
    fechaprestamo     DATE NOT NULL,
    fechadevolucion   DATE NOT NULL,
    cantidad          NUMBER(2) NOT NULL,
    estado            VARCHAR2(10) NOT NULL,
    idusuario         NUMBER(4) NOT NULL
        CONSTRAINT fk_usuario_prestamo
            REFERENCES usuario ( idusuario ),
    identificacion    VARCHAR2(20) NOT NULL,
    idbibliotecario   NUMBER(4) NOT NULL
        CONSTRAINT fk_bibliotecario_prestamo
            REFERENCES bibliotecario ( idbibliotecario )
);

-- TABLA DETALLE LIBRO

CREATE TABLE detallelibro (
    iddetallelibro   NUMBER(6) PRIMARY KEY,
    idlibro          NUMBER(6) NOT NULL,
    isbn             VARCHAR2(13) NOT NULL,
    CONSTRAINT fk_libro_detallelibro FOREIGN KEY ( idlibro,isbn )
        REFERENCES libro ( idlibro,isbn ),
    idautor          NUMBER(5) NOT NULL
        CONSTRAINT fk_autor_detallelibro
            REFERENCES autor ( idautor ),
    ideditorial      NUMBER(3) NOT NULL
        CONSTRAINT fk_editorial_detallelibro
            REFERENCES editorial ( ideditorial )
);

-- Tabla DetallePrestamo

CREATE TABLE detalleprestamo (
    iddetalleprestamo   NUMBER(6) PRIMARY KEY,
    idprestamo          NUMBER(6) NOT NULL
        CONSTRAINT fk_detalleprestamo_prestamo
            REFERENCES prestamo ( idprestamo ),
    idlibro             NUMBER(6) NOT NULL,
    isbn                VARCHAR2(13) NOT NULL,
    CONSTRAINT fk_libro_detalleprestamo FOREIGN KEY ( idlibro,isbn )
        REFERENCES libro ( idlibro,isbn )
);


