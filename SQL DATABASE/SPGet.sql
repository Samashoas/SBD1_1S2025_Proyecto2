CREATE SEQUENCE seq_producto_servicio START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_servicio START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE sp_get_product_service (

    idTipoProducto IN INTEGER, 
    tipo IN INTEGER, 
    pagadoCon IN INTEGER, 
    descripcion IN VARCHAR, 
    monto IN DECIMAL
    )
    AS
        atrTempTipoServicio INTEGER;
        atrTempServicio INTEGER;
        atrTempSaldo DECIMAL;
        atrTempCliente INTEGER; 
        atrFechaContratacion DATE := SYSDATE;
    BEGIN

        BEGIN
            SELECT id INTO atrTempTipoServicio
            FROM TIPOSERVICIO
            WHERE id = idTipoProducto;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20001, 'El tipo de servicio no es válido.');
        END;


        INSERT INTO SERVICIO (id, nombre, monto, id_tipo_servicio)
        VALUES (seq_servicio.NEXTVAL, descripcion, monto, atrTempTipoServicio)
        RETURNING id INTO atrTempServicio;


        IF tipo = 1 AND monto IS NULL THEN
            RAISE_APPLICATION_ERROR(-20003, 'Falta el monto para el servicio o producto.');
        END IF;

        IF monto < 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Solamente se permiten montos mayores o igual a 0.');
        END IF;


        BEGIN
            SELECT saldo, id_cliente INTO atrTempSaldo, atrTempCliente
            FROM CUENTA
            WHERE id = pagadoCon;

            IF atrTempSaldo < monto THEN
                RAISE_APPLICATION_ERROR(-20005, 'El saldo no es suficiente para adquirir el producto.');
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20006, 'La cuenta ingresada no existe.');
        END;

        INSERT INTO PRODUCTO_SERVICIO (id, id_cliente, id_servicio)
        VALUES (seq_producto_servicio.NEXTVAL, atrTempCliente, atrTempServicio);


        /*
        UPDATE CUENTA
        SET saldo = saldo - monto
        WHERE id = pagadoCon;
        */

        COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE;
    END;
/


--CREATE SEQUENCE seq_seguro START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE sp_get_insurance (
    idTipoSeguro IN INTEGER,
    montoAsegurado IN DECIMAL,
    valorSeguro IN DECIMAL,
    cantidadPagos IN INTEGER,
    mesesAsegurado IN INTEGER,
    idClienteR IN INTEGER
    )   
    AS
        atrTempTipoSeguro NUMBER;
        atrTempCliente NUMBER;
        atrFechaContratacion DATE := SYSDATE;
        atrFechaVencimiento DATE;
        BEGIN

            BEGIN
                SELECT id INTO atrTempTipoSeguro
                FROM TIPOSEGURO
                WHERE id = idTipoSeguro;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RAISE_APPLICATION_ERROR(-20001, 'El tipo de seguro ingresado no existe.');
            END;

            BEGIN
                SELECT id INTO atrTempCliente
                FROM CLIENTE
                WHERE id = idClienteR;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RAISE_APPLICATION_ERROR(-20002, 'El cliente no existe.');
            END;


            IF montoAsegurado < 0 THEN
                RAISE_APPLICATION_ERROR(-20003, 'El monto del seguro debe ser mayor o igual a 0.');
            END IF;


            IF valorSeguro < 0 THEN
                RAISE_APPLICATION_ERROR(-20004, 'El valor del seguro debe ser mayor o igual a 0.');
            END IF;

            IF cantidadPagos < 0 THEN
                RAISE_APPLICATION_ERROR(-20005, 'La cantidad de pagos debe ser mayor o igual a 0.');
            END IF;

            IF mesesAsegurado < 0 THEN
                RAISE_APPLICATION_ERROR(-20006, 'Los meses deben de ser mayor o iguales a 0.');
            END IF;

            atrFechaVencimiento := ADD_MONTHS(atrFechaContratacion, mesesAsegurado);

            INSERT INTO SEGURO (id, monto_asegurado, valor_seguro, cantidad_pagos, meses_asegurado, contratacion, fecha_vencimiento, id_tipo_seguro, id_cliente)
            VALUES (seq_seguro.NEXTVAL, montoAsegurado, valorSeguro, cantidadPagos, mesesAsegurado, atrFechaContratacion, atrFechaVencimiento, idTipoSeguro, idClienteR);

            COMMIT;
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    RAISE;
            END;
/

CREATE SEQUENCE seq_transaccion START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE sp_transaction (
    idTipoTransaccion IN INTEGER,
    fechaTransaccion IN DATE, 
    otrosDetalles IN VARCHAR, 
    idClienteR IN INTEGER,
    idCuentaNumTarjeta IN INTEGER,
    valorTransaccion IN DECIMAL,
    idCuentaOrigenR IN INTEGER,
    idCuentaDestinoR IN INTEGER
    )
    AS
        atrTempTipoTransaccion INTEGER;
        atrTempCliente INTEGER;
        atrTempSaldoCuentaOrigen DECIMAL;
        atrTempCuentaTarjeta INTEGER;
        atrTempCuentaDestino INTEGER;
        BEGIN

            BEGIN
                SELECT id INTO atrTempTipoTransaccion
                FROM TIPOTRANSACCION
                WHERE id = idTipoTransaccion;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RAISE_APPLICATION_ERROR(-20001, 'El tipo de transaccion ingresada no existe');
            END;

            BEGIN
                SELECT id INTO atrTempCliente
                FROM CLIENTE
                WHERE id = idClienteR;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RAISE_APPLICATION_ERROR(-20002, 'El cliente no existe');
            END;

            BEGIN
                IF idCuentaNumTarjeta > 15 THEN

                    SELECT COUNT(*)
                    INTO atrTempCuentaTarjeta
                    FROM TARJETA
                    WHERE Numero_Tarjeta = idCuentaNumTarjeta AND id_cliente = idClienteR;

                    IF atrTempCuentaTarjeta = 0 THEN
                        RAISE_APPLICATION_ERROR(-20007, 'La tarjeta no pertenece al cliente o no existe.');
                    END IF;
                ELSE
                   
                    SELECT COUNT(*)
                    INTO atrTempCuentaTarjeta
                    FROM CUENTA
                    WHERE id = idCuentaNumTarjeta AND id_cliente = idClienteR;

                    IF atrTempCuentaTarjeta = 0 THEN
                        RAISE_APPLICATION_ERROR(-20003, 'La cuenta no pertenece al cliente o no existe.');
                    END IF;
                END IF;
            END;

            BEGIN

                SELECT COUNT(*)
                INTO atrTempCuentaTarjeta
                FROM CUENTA
                WHERE id = idCuentaOrigenR AND id_cliente = idClienteR;

                IF atrTempCuentaTarjeta = 0 THEN
                    RAISE_APPLICATION_ERROR(-20004, 'La cuenta origen no pertenece al cliente o no existe.');
                END IF;

                SELECT saldo INTO atrTempSaldoCuentaOrigen
                FROM CUENTA
                WHERE id = idCuentaOrigenR;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RAISE_APPLICATION_ERROR(-20004, 'La cuenta origen no pertenece al cliente o no existe.');
            END;

            BEGIN
                SELECT COUNT(*)
                INTO atrTempCuentaDestino
                FROM CUENTA
                WHERE id = idCuentaDestinoR;

                IF atrTempCuentaDestino = 0 THEN
                    RAISE_APPLICATION_ERROR(-20005, 'La cuenta destino no existe.');
                END IF;
            END;

            IF atrTempSaldoCuentaOrigen < valorTransaccion THEN
                RAISE_APPLICATION_ERROR(-20006, 'Saldo insuficiente para realizar la transaccion.');
            END IF;

            INSERT INTO TRANSACCION (id, id_tipotrans, id_cliente, id_cuenta_origen, id_cuenta_destino, fecha_inicial_transaccion)
            VALUES (seq_transaccion.NEXTVAL, idTipoTransaccion, idClienteR, idCuentaOrigenR, idCuentaDestinoR, fechaTransaccion);

            UPDATE CUENTA
            SET saldo = saldo - valorTransaccion
            WHERE id = idCuentaOrigenR;

            UPDATE CUENTA
            SET saldo = saldo + valorTransaccion
            WHERE id = idCuentaDestinoR;

            COMMIT;
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    RAISE;
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
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE;
END;
/

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
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE;
END;
/