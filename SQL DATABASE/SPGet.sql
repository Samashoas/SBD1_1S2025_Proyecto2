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

    BEGIN
        SELECT id INTO atrTempTipoRemesa
        FROM TIPOREMESA
        WHERE id = idTipoRemesa;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se ha encontrado coincidencias para el tipo de remesa.');
    END;


    BEGIN
        SELECT id INTO atrTempCliente
        FROM CLIENTE
        WHERE id = idClienteR;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'No se ha encontrado coincidencias para el cliente introducido.');
    END;

    BEGIN
        SELECT id INTO atrTempCuentaR
        FROM CUENTA
        WHERE id = idCuentaR AND id_cliente = idClienteR;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20003, 'Existe un error con la cuenta introducida, no pertenece al cliente o no existe.');
    END;

    SELECT id_tipo_cuenta
    INTO atrTempCuenta
    FROM CUENTA
    WHERE id = idCuentaR;

    INSERT INTO REMESA (id, pais, fecha, id_cliente, id_tipo_remesa, id_tipo_cuenta)
    VALUES (seq_remesa.NEXTVAL, paisRemesa, fechaRemesa, idClienteR, idTipoRemesa, atrTempCuenta);

    COMMIT;
END;
/