------------------------------------------------------------ OK
-- funciones.sql                                           -
------------------------------------------------------------
-- 5 funciones para la BD documentadas. 
--
-- Autor: Diego Villalpando
-- Mail:  diego.a.villalpando@ciencias.unam.mx
------------------------------------------------------------

--ENCONTRAR VEHICULO(CLASE) -> PLACAS VARCHAR(8) OK
CREATE FUNCTION fn_encontrar_vehiculo(
    c servicio.clase%TYPE)
RETURNS VARCHAR(8) AS $placs$
BEGIN
    DECLARE
        maxi NUMERIC;
        mini NUMERIC;
    BEGIN
    	IF c LIKE 'c' OR 'n'
    	    THEN  maxi = 499000, mini = 0;
    	ELSEIF c LIKE 'l' 
    	    THEN maxi = 1000000, mini = 450000;
    	ELSEIF c LIKE 's'
    	    THEN maxi = 1000000, mini = 500000;
    	ELSE
    	    ROLLBACK;
    	END IF;

     	SELECT placas 
      	FROM automovil_valor 
      	WHERE valor >= mini AND valor <= maxi
      	ORDER BY random()
      	LIMIT 1;
	END;
END;
$placs$
LANGUAGE plpgsql;
COMMENT ON FUNCTION fn_encontrar_vehiculo (NUMERIC) IS
'Regresa las placas de un vehículo que cumpla con los requisitos 
que requiere un servicio.';

--CALCULAR DISTANCIA(LAO,LOO,LAD,LOD) -> DISTANCIA REAL OK
CREATE FUNCTION fn_calcular_distancia(
    lao servicio.latitud_origen%TYPE,
    loo servicio.longitud_origen%TYPE,
    lad servicio.latitud_destino%TYPE,
    lod servicio.longitud_destino%TYPE)
RETURNS REAL AS $dist$
BEGIN
    DECLARE
        dist float = 0;
        radlao float;
        radlad float;
        theta float;
        radtheta float;
    BEGIN
        IF lao = lad OR loo = lod
            THEN RETURN dist;
        ELSE
            radlao = pi() * lao / 180;
            radlad = pi() * lad / 180;
            theta = loo - lod;
            radtheta = pi() * theta / 180;
            dist = sin(radlao) * sin(radlad) + cos(radlao) * cos(radlad) * cos(radtheta);

            IF dist > 1 THEN dist = 1; END IF;

            dist = acos(dist);
            dist = dist * 180 / pi();
            dist = dist * 60 * 1.1515;

            dist = dist * 1.609344; --Millas nauticas a kilometros

            RETURN CAST (dist AS REAL);
        END IF;
    END;
END;
$dist$ 
LANGUAGE plpgsql;
COMMENT ON FUNCTION fn_calcular_distancia (FLOAT, FLOAT, FLOAT, FLOAT) IS
'Regresa la distancia lineal expresada en kilómetros sobre un
 cuerpo esférico utilizando coordenadas geográficas.';

--CALCULAR CANTIDAD(TIEMPO, DISTANCIA, CLASE) -> CANTIDAD MONEY OK
CREATE FUNCTION fn_calcular_cantidad(
    t servicio.tiempo%TYPE,
    d servicio.distancia%TYPE,
    c servicio.clase%TYPE)
RETURNS MONEY AS $mny$
BEGIN
    DECLARE 
        base    NUMERIC = 20;
        km      NUMERIC = 21;
        min     NUMERIC = 1.2;
        bmin    NUMERIC = 60;
        fare    NUMERIC;
    BEGIN
        IF c LIKE 'c' 
            THEN  fare = base + d * km + t * min;
        ELSEIF c LIKE 'n' 
            THEN fare = base * 1.6 + d * km + t * min * 1.2;
        ELSEIF c LIKE 'l' 
            THEN fare = base * 2 + d * km * 1.2 + t * min * 1.4;
        ELSEIF c LIKE 's'
            THEN fare = base * 2.6 + d * km * 1.2 + t * min * 1.8;
        ELSE
            ROLLBACK;
        END IF;
    END;
    RETURN CAST (fare AS REAL);
END; $mny$
LANGUAGE plpgsql;
COMMENT ON FUNCTION fn_calcular_cantidad (TIME, REAL, CHAR) IS
'Regresa la cantidad a pagar por el usuario que requirió un servicio';

--CALCULAR PUNTOS(DISTANCIA, CANTIDAD) -> PUNTOS NUMERIC OK
CREATE FUNCTION fn_calcular_puntos(
    d servicio.distancia%TYPE,
    can servicio.cantidad%TYPE)
RETURNS NUMERIC AS $pnt$   
DECLARE 
    pts  NUMERIC;
BEGIN
    pts = can * 0.1 + d * 0.8 * 0.1;
    RETURN pts;
END; $pnt$
LANGUAGE plpgsql;
COMMENT ON FUNCTION fn_calcular_puntos (REAL, MONEY) IS
'Regresa la cantidad de puntos generados con el servicio por
ser abonados a la tarjeta del usuario.';

--CALCULAR DEPRECIACION(PLACAS, DISTANCIA) -> VALOR MONEY OK
CREATE FUNCTION fn_calcular_depreciacion(
    p servicio.placas%TYPE, 
    d servicio.distancia%TYPE)
RETURNS MONEY AS $mon$
BEGIN
    DECLARE
        v MONEY;
        coef NUMERIC;
    BEGIN
        SELECT v = automovil_valor.valor 
        FROM valor automovil_valor
        WHERE automovil_valor.placas LIKE p
        LIMIT 1;
        coef = v / 150000;
        coef = coef * distancia;
        v = v - coef;
    END;
    RETURN CAST (v AS MONEY);
END; $mon$
LANGUAGE plpgsql;
COMMENT ON FUNCTION fn_calcular_depreciacion (VARCHAR, REAL) IS
'Regresa la cantidad monetaria por devaluar a un automóvil
en función de la distancia recorrida.';

