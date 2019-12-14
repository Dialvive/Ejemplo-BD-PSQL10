------------------------------------------------------------ OK
-- procedimientos_almacenados.sql                          -
------------------------------------------------------------
-- 5 Procedimientos almacenados para la BD documentados. 
--
-- Autor: Diego Villalpando
-- Mail:  diego.a.villalpando@ciencias.unam.mx
------------------------------------------------------------

--COMPLETAR SERVICIO OK
CREATE OR REPLACE FUNCTION pr_completar_servicio()
RETURNS TRIGGER
AS $pcs$
BEGIN
    DECLARE
        plac    VARCHAR(8)  = fn_encontrar_vehiculo(clase);
        dis     NUMERIC     = fn_calcular_distancia(
                    new.latitud_origen, 
                    new.longitud_origen,
                    new.latitud_destino,
                    new.longitud_destino);
        cant    MONEY       = fn_calcular_cantidad(
                    new.tiempo,
                    dis,
                    new.clase);
        punt    NUMERIC     = fn_calcular_puntos(
                    dist,
                    cant);
        r       CHAR(22);
    BEGIN
        SELECT r = automovil_cualidad(rfc) FROM automovil_cualidad WHERE automovil_cualidad.placas = plac LIMIT 1;
        UPDATE servicio
        SET 
            placas = plac,
            rfc = r,
            distancia = dis,
            cantidad = cant,
            puntos_generados = punt
        WHERE ids LIKE new.ids;
        COMMIT;
    END;
END;
$pcs$
LANGUAGE plpgsql;

--ACTUALIZAR HISTORIAL OK
CREATE OR REPLACE FUNCTION pr_actualizar_historial()
RETURNS trigger
AS $pah$
BEGIN
    INSERT INTO historial(curp, ids)
    VALUES(new.curp, new.ids);

    COMMIT;
END;
$pah$
LANGUAGE plpgsql;

--ACTUALIZAR TARJETA OK
CREATE OR REPLACE FUNCTION pr_actualizar_tarjeta()
RETURNS trigger
AS $pat$
DECLARE
    d_tarjeta   REAL;
    d_servicio  REAL;
    p_tarjeta   NUMERIC;
    p_servicio  NUMERIC;
    n_tarjeta   NUMERIC;
BEGIN
    SELECT  d_tarjeta = distancia, p_tarjeta = puntos, n_tarjeta = num_viajes
    FROM    tarjeta
    WHERE   curp LIKE new.curp;
    
    SELECT  d_servicio = distancia, p_servicio = puntos_generados
    FROM    servicio
    WHERE   ids LIKE new.ids;

    UPDATE tarjeta
    SET 
        distancia = d_tarjeta + d_servicio,
        puntos = p_tarjeta + p_servicio,
        num_viajes = n_tarjeta + 1
    WHERE curp LIKE new.curp;
    
    COMMIT;
END;
$pat$
LANGUAGE plpgsql;

--POBLAR AUTOMOVIL VALOR OK
CREATE OR REPLACE FUNCTION pr_poblar_automovil_valor()
RETURNS trigger
AS $ppav$
DECLARE 
    p   VARCHAR(8);
    m   TEXT;
    a   CHAR(4);
    v   NUMERIC;
BEGIN
    SELECT p = placas, m = modelo, a = anio FROM automovil_cualidad WHERE placas LIKE new.placas;
    v = random_between(150000, 900000);
    INSERT INTO automovil_valor(placas, modelo, anio, valor)
    VALUES(p, m, a, v);
    COMMIT;
END;
$ppav$
LANGUAGE plpgsql;

--ACTUALIZAR AUTOMOVIL VALOR OK
CREATE OR REPLACE FUNCTION pr_actualizar_automovil_valor()   
RETURNS trigger
AS $paav$
BEGIN
    UPDATE automovil_valor
        SET valor = fn_calcular_depreciacion(new.placas, new.distancia)
        WHERE placas = new.placas;
    COMMIT;
END;
$paav$
LANGUAGE plpgsql;