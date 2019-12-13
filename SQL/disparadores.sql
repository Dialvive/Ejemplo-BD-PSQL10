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

--ACTUALIZAR HISTORIAL OK
CREATE TRIGGER tr_af_in_servicio_historial
    AFTER INSERT ON servicio
    FOR EACH ROW
    EXECUTE PROCEDURE pr_actualizar_historial();

--ACTUALIZAR TARJETA OK
CREATE TRIGGER tr_af_in_servicio_tarjeta
    AFTER INSERT ON servicio
    FOR EACH ROW
    EXECUTE PROCEDURE pr_actualizar_tarjeta();

--ACTUALIZAR AUTOMOVIL VALOR OK
CREATE TRIGGER tr_af_up_automovil_cualitativo
    AFTER INSERT ON servicio
    FOR EACH ROW
    EXECUTE PROCEDURE pr_actualizar_automovil_valor();

--POBLAR AUTOMOVIL VALOR OK
CREATE TRIGGER tr_af_in_automovil_cualidad
    AFTER INSERT ON automovil_cualidad
    FOR EACH ROW
    EXECUTE PROCEDURE pr_poblar_automovil_valor();