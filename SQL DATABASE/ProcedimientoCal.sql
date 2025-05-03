/*
CREATE TABLE TARJETA_EXT(
    id NUMBER PRIMARY KEY,
    tipo CHAR NOT NULL,
    Numero_Tarjeta NUMBER(16,0) NOT NULL,
    moneda CHAR NOT NULL,
    monto_limite DECIMAL NOT NULL,
    Dia_corte NUMBER,
    Dia_pago NUMBER,
    Tasa_interes DECIMAL NOT NULL,
    fecha_expedicion DATE NOT NULL,
    id_cliente NUMBER NOT NULL REFERENCES CLIENTE(id),
    id_tipo_tarjeta NUMBER NOT NULL REFERENCES TIPOTARJETA(id),
    creation_date DATE DEFAULT SYSDATE,
    Data_Update DATE DEFAULT SYSDATE,
    id_tpadre NUMBER NOT NULL REFERENCES TARJETA(id)

);
*/

CREATE OR REPLACE PROCEDURE sp_register_Tarjeta_ext(
    p_tipo IN CHAR,
    p_numero_tarjeta IN NUMBER,
    p_moneda IN CHAR,
    p_montoLimite IN DECIMAL,
    p_diaCorte IN NUMBER,
    p_diaPago IN NUMBER,
    p_tasa IN DECIMAL,
    p_fechaExp IN VARCHAR,
    p_id_cliente IN NUMBER,
    p_id_TipoTarjeta IN NUMBER,
    p_id_padre IN NUMBER
) AS
    V_IDPADRE NUMBER;
    v_fecha DATE;
BEGIN
    v_fecha := TO_DATE(p_fechaExp, 'DD-MM-YYY');

    IF LENGTH(TO_CHAR(p_numero_tarjeta)) != 16 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El numero de la tarjeta no tiene 16 digitos');
    END IF;

    BEGIN
        SELECT id INTO V_IDPADRE
        FROM TARJETA
        WHERE id = p_id_padre;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'No existe la tarjeta padre');
    END;

    IF p_tipo = 'D' THEN
            RAISE_APPLICATION_ERROR(-20003, 'No puede extender tarjeta de debito');
    END IF;

    INSERT INTO TARJETA_EXT(id, tipo, Numero_Tarjeta, moneda, monto_limite, Dia_corte, Dia_pago, Tasa_interes, fecha_expedicion, id_cliente, id_tipo_tarjeta, id_tpadre)
    VALUES (seq_tarjeta_ext.NEXTVAL, p_tipo, p_numero_tarjeta, p_moneda, p_montoLimite, p_diaCorte, p_diaPago, p_tasa, v_fecha, p_id_cliente, p_id_TipoTarjeta, p_id_padre);
    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN 
        ROLLBACK;
        RAISE;
END;
/