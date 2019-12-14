------------------------------------------------------------ OK
-- disparadores.sql                                        -
------------------------------------------------------------
-- 5 disparadores para la BD documentados.
--
-- Autor: Diego Villalpando
-- Mail:  diego.a.villalpando@ciencias.unam.mx
------------------------------------------------------------

--COMPLETAR SERVICIO OK
CREATE TRIGGER tr_af_in_servicio
    AFTER INSERT ON servicio
    FOR EACH ROW
    EXECUTE PROCEDURE pr_completar_servicio();
COMMENT ON TRIGGER tr_af_in_servicio ON servicio IS
'Disparador que calcula la información faltante en un servicio
sin procesar, como la distancia recorrida entre dos puntos, 
cantidad a pagar, y automóvil utilizado.';

--ACTUALIZAR HISTORIAL OK
CREATE TRIGGER tr_af_in_servicio_historial
    AFTER INSERT ON servicio
    FOR EACH ROW
    EXECUTE PROCEDURE pr_actualizar_historial();
COMMENT ON TRIGGER tr_af_in_servicio_historial ON servicio IS
'Disparador que registra el nuevo servicio en la tabla de historial
según el curp del cliente que solicitó el servicio.';

--ACTUALIZAR TARJETA OK
CREATE TRIGGER tr_af_in_servicio_tarjeta
    AFTER INSERT ON servicio
    FOR EACH ROW
    EXECUTE PROCEDURE pr_actualizar_tarjeta();
COMMENT ON TRIGGER tr_af_in_servicio_tarjeta ON servicio IS
'Disparador que registra los datos de nuevo servicio en
 a tabla de tarjeta que suma los puntos generados, distancia
 recorrida, y número de viajes, según el curp del
 cliente que solicitó el servicio.';

--ACTUALIZAR AUTOMOVIL VALOR OK
CREATE TRIGGER tr_af_up_automovil_cualitativo
    AFTER INSERT ON servicio
    FOR EACH ROW
    EXECUTE PROCEDURE pr_actualizar_automovil_valor();
COMMENT ON TRIGGER tr_af_in_servicio_tarjeta ON servicio IS
'Disparador que actualiza la tabla automovil_valor cuando se 
completa un servicio, se hace el ajuste de depreciación sobre
el valor del vehículo utilizado, según las placas del automóvil'

--POBLAR AUTOMOVIL VALOR OK
CREATE TRIGGER tr_af_in_automovil_cualidad
    AFTER INSERT ON automovil_cualidad
    FOR EACH ROW
    EXECUTE PROCEDURE pr_poblar_automovil_valor();

'Disparador que actualiza la tabla automovil_valor cuando se 
ingresan nuevos automóviles en tabla automovil_cualitativo,
según las placas del automovil.'