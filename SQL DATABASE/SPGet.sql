CREATE OR REPLACE PROCEDURE sp_comming_money (
    idTipoRemesa IN INTEGER,
    fechaRemesa IN DATE,
    paisRemesa IN VARCHAR,
    idClienteR IN INTEGER,
    idCuentaR IN INTEGER
)
AS
    atrTempTipoRemesa NUMBER;
    atrTempCliente NUMBER;
    atrTempCuentaR NUMBER;
    atrTempCuenta NUMBER;
    
BEGIN

    SELECT COUNT(1)
    INTO atrTempTipoRemesa
    FROM TIPOREMESA
    WHERE id = idTipoRemesa;

    IF atrTempTipoRemesa = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se ha encontrado coincidencias para el tipo de remesa.');
    END IF;

    SELECT COUNT(1)
    INTO atrTempCliente
    FROM CLIENTE
    WHERE id = idClienteR;

    IF atrTempCliente = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se ha encontrado coincidencias para el cliente introducido.');
    END IF;

    SELECT COUNT(1)
    INTO atrTempCuentaR
    FROM CUENTA
    WHERE id = idCuentaR AND id_cliente = idClienteR;

    IF atrTempCuentaR = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Existe un error con la cuenta introducida, no pertenece al cliente o no existe.');
    END IF;

    SELECT id_tipo_cuenta
    INTO atrTempCuenta
    FROM CUENTA
    WHERE id = idCuentaR;

    INSERT INTO REMESA (id, pais, fecha, id_cliente, id_tipo_remesa, id_tipo_cuenta)
    VALUES (seq_remesa.NEXTVAL, paisRemesa, fechaRemesa, idClienteR, idTipoRemesa, atrTempCuenta);

    COMMIT;
END;
/