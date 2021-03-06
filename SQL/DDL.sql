------------------------------------------------------------
-- DDL.sql                                                 -
------------------------------------------------------------
-- Instrucciones para crear esquema de la BD, restringiendo
-- integridad referencial, de dominio, y entidad. 
--
-- Autor: Diego Villalpando
-- Mail:  diego.a.villalpando@ciencias.unam.mx
------------------------------------------------------------

CREATE DATABASE Transportate;
COMMENT ON DATABASE Transportate IS 
'Base de datos sobre la empresa ficticia Transpórtate';

------------------------------------------------------------ OK
--ESTRUCURA DE TABLAS EN LA BASE DE DATOS ------------------
------------------------------------------------------------

----TABLAS CON LLAVES PRIMARIAS

--CLIENTES
CREATE TABLE cliente (
    curp                CHAR(18)    NOT NULL,
 	nombres             TEXT	 	NOT NULL,
	apellidos	        TEXT		NOT NULL,
	fecha_nacimiento    DATE		NOT NULL
);
COMMENT ON TABLE cliente IS
'Tabla que almacena datos de clientes de la empresa.';
COMMENT ON COLUMN cliente.curp IS
'Clave Única de Registro de Población. [Llave Primaria]';
COMMENT ON COLUMN cliente.nombres IS
'Nombre(s) de pila.';
COMMENT ON COLUMN cliente.apellidos IS
'Ambos apellidos.';
COMMENT ON COLUMN cliente.fecha_nacimiento IS
'Fecha de nacimiento en formato YYYY-MM-DD.';

--C2.1 O CHOFER PERSONA
CREATE TABLE chofer_persona (
    curp                CHAR(18)    NOT NULL,
 	nombres             TEXT	 	NOT NULL,
	apellidos	        TEXT		NOT NULL,
	fecha_nacimiento    DATE		NOT NULL
);
COMMENT ON TABLE chofer_persona IS
'Tabla que almacena datos básicos de choferes de la empresa.';
COMMENT ON COLUMN chofer_persona.curp IS
'Clave Única de Registro de Población. [Llave Primaria]';
COMMENT ON COLUMN chofer_persona.nombres IS
'Nombre(s) de pila.';
COMMENT ON COLUMN chofer_persona.apellidos IS
'Ambos apellidos.';
COMMENT ON COLUMN chofer_persona.fecha_nacimiento IS
'Fecha de nacimiento en formato YYYY-MM-DD.';

--C2.2 O CHOFER FISCAL
CREATE TABLE chofer_fiscal (
    rfc                 CHAR(22)    NOT NULL,
    curp                CHAR(18)    NOT NULL,
    regimen_fiscal      CHAR(1)     NOT NULL
);
COMMENT ON TABLE chofer_fiscal IS
'Tabla que almacena datos fiscales de choferes de la empresa.';
COMMENT ON COLUMN chofer_fiscal.rfc IS
'Registro Federal de Contribuyentes. [Llave Primaria]';
COMMENT ON COLUMN chofer_fiscal.curp IS
'Clave Única de Registro de Población. [Llave Secundaria]';
COMMENT ON COLUMN chofer_fiscal.regimen_fiscal IS
'Figura Fiscal: Persona Moral := M, Persona Física := F, o 
Persona Física con Capacidad Empresarial := E.';

--A1 o AUTOMÓVIL CUALIDAD
CREATE TABLE automovil_cualidad (
    placas              VARCHAR(8)  NOT NULL,
    rfc                 CHAR(22)    NOT NULL,
    modelo              TEXT        NOT NULL,
    marca               TEXT        NOT NULL,
    anio                NUMERIC     NOT NULL,
    color               TEXT        NOT NULL
);
COMMENT ON TABLE automovil_cualidad IS
'Tabla que almacena datos cualitativos de los automóviles de la
empresa.';
COMMENT ON COLUMN automovil_cualidad.placas IS
'Código del emplacado del automóvil. [Llave Primaria]';
COMMENT ON COLUMN automovil_cualidad.rfc IS
'Registro Federal de Contribuyentes del chofer al que está
asignado el automóvil. [Llave Secundaria]';
COMMENT ON COLUMN automovil_cualidad.modelo IS
'Modelo del automóvil.';
COMMENT ON COLUMN automovil_cualidad.marca IS
'Marca del automóvil';
COMMENT ON COLUMN automovil_cualidad.anio IS
'Año del modelo de serie del automóvil.';
COMMENT ON COLUMN automovil_cualidad.color IS
'Color de la pintura del automóvil.';

--SERVICIO
CREATE TABLE servicio (
    ids                 BIGSERIAL   NOT NULL,
    curp                CHAR(18)    NOT NULL,
    rfc                 CHAR(22),
    placas              VARCHAR(8),
    num_pasajeros       CHAR(1)     NOT NULL,
    latitud_origen      float       NOT NULL,
    longitud_origen    float       NOT NULL,
    latitud_destino     float       NOT NULL,
    longitud_destino    float       NOT NULL,
    tiempo              TIME        NOT NULL,
    distancia           real,
    clase               CHAR(1)     NOT NULL,
    cantidad            MONEY,
    metodo              BOOLEAN     NOT NULL,
    puntos_generados    NUMERIC
);
COMMENT ON TABLE servicio IS
'Tabla que almacena datos de cada servicio -viaje- que es realizado
por la empresa.';
COMMENT ON COLUMN servicio.ids IS
'Identificador serializable único de cada servicio.
[Llave Primaria]';
COMMENT ON COLUMN servicio.curp IS
'Clave Única de Registro de Población del cliente atendido.
[Llave Secundaria]';
COMMENT ON COLUMN servicio.rfc IS
'Registro Federal de Contribuyentes del chofer que atendió el 
servicio. [Llave Secundaria]';
COMMENT ON COLUMN servicio.placas IS
'Código del emplacado del automóvil que fue usado en el servicio.
[Llave Secundaria]';
COMMENT ON COLUMN servicio.num_pasajeros IS
'Cantidad de pasajeros que fueron transportados.';
COMMENT ON COLUMN servicio.latitud_origen IS
'Medida del arco geográfico de latitud de donde se inició el 
servicio.';
COMMENT ON COLUMN servicio.longitud_origen IS
'Medida del arco geográfico de longitud de donde se inició el 
servicio.';
COMMENT ON COLUMN servicio.latitud_destino IS
'Medida del arco geográfico de latitud de donde se terminó el 
servicio.';
COMMENT ON COLUMN servicio.longitud_destino IS
'Medida del arco geográfico de longitud de donde se terminó el 
servicio.';
COMMENT ON COLUMN servicio.tiempo IS
'Tiempo transcurrido desde que inició hasta que terminó el 
servicio.';
COMMENT ON COLUMN servicio.distancia IS
'Distancia entre los puntos geográficos desde donde se originó y 
terminó el servicio.';
COMMENT ON COLUMN servicio.clase IS
'Clase del servicio en función del tipo de viaje solicitado y
las características del vehículo. [c]: compartido [n]: lite
[l]: luxory [s]: luxurySUV';
COMMENT ON COLUMN servicio.cantidad IS
'Cantidad pagada por el cliente, generada en función de la
distancia, tiempo, y clase.';
COMMENT ON COLUMN servicio.metodo IS
'Método de pago usado por el cliente.';
COMMENT ON COLUMN servicio.puntos_generados IS
'Cantidad de puntos abonados a la tarjeta del cliente en función
de la cantidad.';

------------------------------------------------------------ OK
----TABLAS CON LLAVES SECUNDARIAS SIN LLAVES PRIMARIAS -----
------------------------------------------------------------

--CLIENTE TELEFONO
CREATE TABLE cliente_telefono (
    curp                CHAR(18)    NOT NULL,
    numero              varchar(13) NOT NULL
);
COMMENT ON TABLE cliente_telefono IS
'Tabla que almacena los números telefónicos de 
clientes y choferes.';
COMMENT ON COLUMN cliente_telefono.curp IS
'Clave Única de Registro de Población de clientes o choferes.
[Llave Secundaria]';
COMMENT ON COLUMN cliente_telefono.numero IS
'Número telefónico de clientes o choferes.';

--CLIENTE CORREO-E
CREATE TABLE cliente_correo_e (
    curp                CHAR(18)    NOT NULL,
    direccion           TEXT        NOT NULL
);
COMMENT ON TABLE cliente_correo_e IS
'Tabla que almacena las direcciones de correo electrónico de 
clientes.';
COMMENT ON COLUMN cliente_correo_e.curp IS
'Clave Única de Registro de Población de clientes.
[Llave Secundaria]';
COMMENT ON COLUMN cliente_correo_e.direccion IS
'Dirección de correo electrónico de clientes.';

--CHOFER TELEFONO
CREATE TABLE chofer_telefono (
    curp                CHAR(18)    NOT NULL,
    numero              varchar(13) NOT NULL
);
COMMENT ON TABLE chofer_telefono IS
'Tabla que almacena los números telefónicos de choferes.';
COMMENT ON COLUMN chofer_telefono.curp IS
'Clave Única de Registro de Población de choferes.
[Llave Secundaria]';
COMMENT ON COLUMN chofer_telefono.numero IS
'Número telefónico de choferes.';

--CHOFER CORREO-E
CREATE TABLE chofer_correo_e (
    curp                CHAR(18)    NOT NULL,
    direccion           TEXT        NOT NULL
);
COMMENT ON TABLE chofer_correo_e IS
'Tabla que almacena las direcciones de correo electrónico de 
choferes.';
COMMENT ON COLUMN chofer_correo_e.curp IS
'Clave Única de Registro de Población de choferes.
[Llave Secundaria]';
COMMENT ON COLUMN chofer_correo_e.direccion IS
'Dirección de correo electrónico de choferes.';

--C3 o CHOFER DIRECCION
CREATE TABLE chofer_direccion (
    calle               TEXT        NOT NULL,
    delegacion          TEXT        NOT NULL,
    estado              TEXT        NOT NULL
);
COMMENT ON TABLE chofer_direccion IS
'Tabla que almacena datos del paradero de los choferes.';
COMMENT ON COLUMN chofer_direccion.calle IS
'Nombre y número de la calle del chofer. [Llave Secundaria]';
COMMENT ON COLUMN chofer_direccion.delegacion IS
'Nombre de la delegación donde se encuentra la calle del chofer.';
COMMENT ON COLUMN chofer_direccion.estado IS
'Nombre del estado donde se encuentra la delegación del chofer.';

--C1 O CHOFER REF
CREATE TABLE chofer_ref (
    rfc                 CHAR(22)    NOT NULL,
    calle               TEXT        NOT NULL
);
COMMENT ON TABLE chofer_ref IS
'Tabla que almacena las referencias del RFC con el paradero de 
los choferes.';
COMMENT ON COLUMN chofer_ref.rfc IS
'Registro Federal de Contribuyentes del chofer. [Llave Secundaria]';
COMMENT ON COLUMN chofer_ref.calle IS
'Nombre y número de la calle del chofer. [Llave Candidata]';

--A2 O AUTOMOVIL VALOR
CREATE TABLE automovil_valor (
    placas              VARCHAR(8)  NOT NULL,
    modelo              TEXT        NOT NULL,
    anio                NUMERIC     NOT NULL,
    valor               MONEY       NOT NULL              
);
COMMENT ON TABLE automovil_valor IS
'Tabla que almacena los datos importantes para estimar el valor
de un automovil con ciertas placas.';
COMMENT ON COLUMN automovil_valor.placas IS
'Emplacado del automóvil. [Llave Secundaria]';
COMMENT ON COLUMN automovil_valor.modelo IS
'Modelo del automóvil.';
COMMENT ON COLUMN automovil_valor.anio IS
'Año de linea del modelo del automóvil.';
COMMENT ON COLUMN automovil_valor.valor IS
'Valor en pesos del automóvil.';

--TARJETA
CREATE TABLE tarjeta (
    curp                CHAR(18)    NOT NULL,
    distancia           REAL        NOT NULL,
    puntos              NUMERIC     NOT NULL,
    num_viajes          NUMERIC     NOT NULL
);
COMMENT ON TABLE tarjeta IS
'Tabla que almacena los datos de las tarjetas de puntos de los
clientes.';
COMMENT ON COLUMN tarjeta.curp IS
'Clave Única de Registro de Población del cliente. 
[Llave Secundaria]';
COMMENT ON COLUMN tarjeta.distancia IS
'Distancia acumulada por un cliente en función del total de sus
servicios.';
COMMENT ON COLUMN tarjeta.puntos IS
'Puntos generados acumulados por un cliente en función del total
de sus servicios';
COMMENT ON COLUMN tarjeta.num_viajes IS
'Número de viajes totales por cliente';

--HISTORIAL
CREATE TABLE historial (
    curp                CHAR(18)    NOT NULL,
    ids                 BIGSERIAL   NOT NULL
);
COMMENT ON TABLE historial IS
'Tabla que almacena el historial de servicios que ha tenido un
cliente.';
COMMENT ON COLUMN historial.curp IS
'Clave Única de Registro de Población del Cliente. 
[Llave Secundaria]';
COMMENT ON COLUMN historial.ids IS
'Identificador serializable único de un servicio. 
[Llave Secundaria]';

------------------------------------------------------------ OK
--ASIGNACIÓN DE LLAVES PRIMARIAS ---------------------------
------------------------------------------------------------

ALTER TABLE cliente
    ADD CONSTRAINT pk_cliente_curp
        PRIMARY KEY (curp);

ALTER TABLE chofer_persona
    ADD CONSTRAINT pk_chofer_persona_curp
        PRIMARY KEY (curp);

ALTER TABLE chofer_fiscal
    ADD CONSTRAINT pk_chofer_fiscal_rfc
        PRIMARY KEY (rfc);

ALTER TABLE automovil_cualidad
    ADD CONSTRAINT pk_automovil_cualidad_placas
        PRIMARY KEY (placas);

ALTER TABLE servicio
    ADD CONSTRAINT pk_servicio_ids
        PRIMARY KEY (ids);


------------------------------------------------------------ OK
--ASIGNACIÓN DE LLAVES CANDIDATAS ---------------------------
------------------------------------------------------------

ALTER TABLE chofer_ref
    ADD CONSTRAINT tk_chofer_ref_calle
        UNIQUE (calle);

------------------------------------------------------------ OK
--ASIGNACIÓN DE LLAVES SECUNDARIAS -------------------------
------------------------------------------------------------

----REFERENCIAS A CLIENTE OK
ALTER TABLE cliente_correo_e 
    ADD CONSTRAINT fk_cliente_correo_e_curp
        FOREIGN KEY (curp)      REFERENCES cliente (curp);

ALTER TABLE cliente_telefono
    ADD CONSTRAINT fk_cliente_telefono_curp
        FOREIGN KEY (curp)      REFERENCES cliente (curp);

ALTER TABLE historial 
    ADD CONSTRAINT fk_historial_curp
        FOREIGN KEY (curp)      REFERENCES cliente (curp);

ALTER TABLE tarjeta 
    ADD CONSTRAINT fk_tarjeta_curp
        FOREIGN KEY (curp)      REFERENCES cliente (curp);

ALTER TABLE servicio 
    ADD CONSTRAINT fk_servicio_curp
        FOREIGN KEY (curp)      REFERENCES cliente (curp);

----REFERENCIAS A CHOFER PERSONA OK
ALTER TABLE chofer_correo_e 
    ADD CONSTRAINT fk_chofer_correo_e_curp
        FOREIGN KEY (curp)      REFERENCES chofer_persona (curp);

ALTER TABLE chofer_telefono
    ADD CONSTRAINT fk_chofer_telefono_curp
        FOREIGN KEY (curp)      REFERENCES chofer_persona (curp);

ALTER TABLE chofer_fiscal 
    ADD CONSTRAINT fk_chofer_fiscal_curp
        FOREIGN KEY (curp)      REFERENCES chofer_persona (curp);

----REFERENCIAS A CHOFER FISCAL OK
ALTER TABLE servicio
    ADD CONSTRAINT fk_servicio_rfc
        FOREIGN KEY (rfc)       REFERENCES chofer_fiscal (rfc);

ALTER TABLE automovil_cualidad
    ADD CONSTRAINT fk_automovil_cualidad_rfc
        FOREIGN KEY (rfc)       REFERENCES chofer_fiscal (rfc);

ALTER TABLE chofer_ref
    ADD CONSTRAINT fk_chofer_ref_rfc
        FOREIGN KEY (rfc)       REFERENCES chofer_fiscal (rfc);

----REFERENCIAS A CHOFER REF OK
ALTER TABLE chofer_direccion
    ADD CONSTRAINT fk_chofer_direccion_calle
        FOREIGN KEY (calle)     REFERENCES chofer_ref (calle);

----REFERENCIAS A AUTOMÓVIL CUALIDAD OK
ALTER TABLE servicio
    ADD CONSTRAINT fk_servicio_placas
        FOREIGN KEY (placas)    REFERENCES automovil_cualidad (placas);

ALTER TABLE automovil_valor
    ADD CONSTRAINT fk_automovil_valor_placas
        FOREIGN KEY (placas)    REFERENCES automovil_cualidad (placas);

----REFERENCIAS A SERVICIO OK
ALTER TABLE historial 
    ADD CONSTRAINT fk_historial_ids
        FOREIGN KEY (ids)       REFERENCES servicio (ids);

------------------------------------------------------------ OK
--ASIGNACIÓN DE CHECKS--------------------------------------
------------------------------------------------------------

-----CLIENTE OK
ALTER TABLE cliente
    ADD CONSTRAINT ck_cliente_curp
        CHECK (
            curp ~ '\w'
        );

ALTER TABLE cliente
    ADD CONSTRAINT ck_cliente_nombres
        CHECK (
            nombres ~ '\w' AND nombres !~ '.+\d+.+'
        );

ALTER TABLE cliente
    ADD CONSTRAINT ck_cliente_apellidos
        CHECK (
            apellidos ~ '\w' AND apellidos !~ '.+\d+.+'
        );
ALTER TABLE cliente
    ADD CONSTRAINT ck_cliente_fecha_nacimiento
        CHECK (
            fecha_nacimiento > '1900-01-01'
        );

-----CLIENTE CORREO E OK
ALTER TABLE cliente_correo_e
    ADD CONSTRAINT ck_cliente_correo_e_direccion
        CHECK (
            direccion ~* '[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+'
        );

-----CLIENTE TELEFONO OK
ALTER TABLE cliente_telefono
    ADD CONSTRAINT ck_cliente_telefono_numero
        CHECK (
            numero ~ '.+\d+.+' 
            AND numero !~ '.+^[[:alpha:]]+.+' 
            AND numero !~ '.+\s+.+' 
        );

-----TARJETA OK
ALTER TABLE tarjeta
    ADD CONSTRAINT ck_tarjeta_distancia
        CHECK (
            distancia >= 0
        );

ALTER TABLE tarjeta
    ADD CONSTRAINT ck_tarjeta_puntos
        CHECK (
            puntos >= 0
        );

ALTER TABLE tarjeta
    ADD CONSTRAINT ck_tarjeta_num_viajes
        CHECK (
            num_viajes >= 0
        );

-----CHOFER PERSONA OK
ALTER TABLE chofer_persona
    ADD CONSTRAINT ck_cliente_curp
        CHECK (
            curp ~ '\w'
        );

ALTER TABLE chofer_persona
    ADD CONSTRAINT ck_chofer_persona_nombres
        CHECK (
            nombres ~ '\w' AND nombres !~ '.+\d+.+'
        );

ALTER TABLE chofer_persona
    ADD CONSTRAINT ck_chofer_persona_apellidos
        CHECK (
            apellidos ~ '\w' AND apellidos !~ '.+\d+.+'
        );
ALTER TABLE chofer_persona
    ADD CONSTRAINT ck_chofer_persona_fecha_nacimiento
        CHECK (
            fecha_nacimiento >'1900-01-01'
        );

-----CHOFER CORREO E OK
ALTER TABLE chofer_correo_e
    ADD CONSTRAINT ck_chofer_correo_e_direccion
        CHECK (
            direccion ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'
        );

-----CHOFER TELEFONO OK
ALTER TABLE chofer_telefono
    ADD CONSTRAINT ck_chofer_telefono_numero
        CHECK (
            numero ~ '.+\d+.+' 
            AND numero !~ '+^[[:alpha:]]+.+' 
            AND numero !~ '.+\s+.+' 
        );

-----CHOFER FISCAL OK
ALTER TABLE chofer_fiscal
    ADD CONSTRAINT ck_chofer_fiscal_rfc
        CHECK (
            rfc ~ '\w'
        );

 ALTER TABLE chofer_fiscal
    ADD CONSTRAINT ck_chofer_fiscal_regimen_fiscal
        CHECK (
            regimen_fiscal = 'M'
            OR regimen_fiscal = 'F'
            OR regimen_fiscal = 'E'
        );
       
-----CHOFER REF OK
ALTER TABLE chofer_ref
    ADD CONSTRAINT ck_chofer_ref_calle
        CHECK (
            calle ~ '\w'
        );

-----CHOFER DIRECCION OK
ALTER TABLE chofer_direccion
    ADD CONSTRAINT ck_chofer_direccion_delegacion
        CHECK (
            delegacion ~ '\w'
            AND delegacion !~ '.+\d+.+'
        );

ALTER TABLE chofer_direccion
    ADD CONSTRAINT ck_chofer_direccion_estado
        CHECK (
            estado ~ '\w'
            AND estado !~ '.+\d+.+'
        );

-----AUTOMOVIL CUALIDAD OK
ALTER TABLE automovil_cualidad
    ADD CONSTRAINT ck_automovil_cualidad_placas
        CHECK (
            placas ~ '\w'
            AND placas !~ '.+\d+.+'
        );

ALTER TABLE automovil_cualidad
    ADD CONSTRAINT ck_automovil_cualidad_marca
        CHECK (
            marca ~ '\w'
            AND marca !~ '.+\d+.+'
        );

ALTER TABLE automovil_cualidad
    ADD CONSTRAINT ck_automovil_cualidad_modelo
        CHECK (
            modelo ~ '\w'
        );

ALTER TABLE automovil_cualidad
    ADD CONSTRAINT ck_automovil_cualidad_anio
        CHECK (
            anio >= 2000 
            AND anio <= 2020
        );

ALTER TABLE automovil_cualidad
    ADD CONSTRAINT ck_automovil_cualidad_color
        CHECK (
            color ~ '\w'
            AND color !~ '.+\d+.+'
        );

-----AUTOMOVIL VALOR OK
ALTER TABLE automovil_valor
    ADD CONSTRAINT ck_automovil_valor_modelo
        CHECK (
            modelo ~ '\w'
        );

ALTER TABLE automovil_valor
    ADD CONSTRAINT ck_automovil_valor_anio
        CHECK (
            CAST (anio AS NUMERIC) >= 2000
        );

ALTER TABLE automovil_valor
    ADD CONSTRAINT ck_automovil_valor_valor
        CHECK (
            CAST (valor AS NUMERIC) > 0
        );

-----SERVICIO OK
ALTER TABLE servicio
    ADD CONSTRAINT ck_servicio_num_pasajeros
        CHECK (
            CASE 
                WHEN CAST (num_pasajeros AS NUMERIC) <= 4 
                    AND CAST (num_pasajeros AS NUMERIC) > 0
                    AND clase = 'D' OR clase = 'C' OR clase = 'B'
                    THEN TRUE
                WHEN CAST (num_pasajeros AS NUMERIC) <= 9
                    AND CAST (num_pasajeros AS NUMERIC) >= 5
                    AND clase = 'A'
                    THEN TRUE
                ELSE FALSE
            END
        );

ALTER TABLE servicio
    ADD CONSTRAINT ck_servicio_latitud_origen
        CHECK (
            latitud_origen >= -90 
            AND latitud_origen <= 90
        );

ALTER TABLE servicio
    ADD CONSTRAINT ck_servicio_longitud_origen
        CHECK (
            longitud_origen >= -180
            AND longitud_origen <= 180
        );

ALTER TABLE servicio
    ADD CONSTRAINT ck_servicio_latitud_destino
        CHECK (
            latitud_destino >= -90 
            AND latitud_destino <= 90
        );

ALTER TABLE servicio
    ADD CONSTRAINT ck_servicio_longitud_destino
        CHECK (
            longitud_destino >= -180
            AND longitud_destino <= 180
        );

ALTER TABLE servicio
    ADD CONSTRAINT ck_servicio_tiempo
        CHECK (
            CASE
                WHEN EXTRACT(MINUTE FROM tiempo) = 0
                    AND EXTRACT(HOUR FROM tiempo) > 0
                    THEN TRUE
                WHEN EXTRACT(MINUTE FROM tiempo) > 0
                    AND EXTRACT(HOUR FROM tiempo) >= 0
                    THEN TRUE
                ELSE FALSE
            END
        );

ALTER TABLE servicio
    ADD CONSTRAINT ck_servicio_distancia
        CHECK (
            distancia >= 0
        );

ALTER TABLE servicio
    ADD CONSTRAINT ck_servicio_clase
        CHECK (
            clase = 'D' --Lite compartido
            OR clase = 'C' --Lite
            OR clase = 'B' --Luxury
            OR clase = 'A' --Luxory SUV
        );

ALTER TABLE servicio
    ADD CONSTRAINT ck_servicio_cantidad
        CHECK (
            CAST (cantidad AS NUMERIC) > 0 
        );

ALTER TABLE servicio
    ADD CONSTRAINT ck_servicio_metodo
        CHECK (
            metodo = TRUE OR metodo = FALSE
        );

ALTER TABLE servicio
    ADD CONSTRAINT ck_servicio_puntos_generados
        CHECK (
            puntos_generados >= 1
        );
