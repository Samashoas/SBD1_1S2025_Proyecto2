CREATE SEQUENCE seq_remesa START WITH 1 INCREMENT BY 1;

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

CREATE SEQUENCE seq_prestamo START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE sp_get_loan (
    montoPrestamo IN NUMBER,
    tasaInteres IN INTEGER,
    meses IN INTEGER,
    idClienteR IN INTEGER
)
AS
    atrTempCliente NUMBER;
    atrFechaContratacion DATE := SYSDATE;
    atrFechaVencimiento DATE;
BEGIN

    BEGIN
        SELECT id INTO atrTempCliente
        FROM CLIENTE
        WHERE id = idClienteR;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se ha encontrado coincidencias para el cliente introducido.');
    END;

    IF montoPrestamo < 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Para que el prestamo sea valido el monto debe de ser mayor o igual a 0.');
    END IF;

    IF tasaInteres < 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Para que el prestamo sea valido el monto debe de la tasa de interés debe ser mayor o igual a 0.');
    END IF;

    IF meses < 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'El numero de meses debe ser mayor o igual a 0.');
    END IF;

    atrFechaVencimiento := ADD_MONTHS(atrFechaContratacion, meses);

    INSERT INTO PRESTAMO (id, monto_prestamo, tasa_interes, meses, contratacion, fecha_vencimiento, id_cliente)
    VALUES (seq_prestamo.NEXTVAL, montoPrestamo, tasaInteres, meses, atrFechaContratacion, atrFechaVencimiento, idClienteR);

    COMMIT;
END;
/