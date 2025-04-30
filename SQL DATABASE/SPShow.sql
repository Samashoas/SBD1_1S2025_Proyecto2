CREATE OR REPLACE PROCEDURE sp_transactions_by_client (

    idClienteTransaccion IN NUMBER,
    fechaInicialTransaccion IN DATE,
    fechaFinalTransaccion IN DATE

)
    AS

    result SYS_REFCURSOR;

    BEGIN
        
        OPEN result FOR

            SELECT transaccionCliente.id, transaccionCliente.id_tipotrans, transaccionCliente.id_cliente, transaccionCliente.id_cuenta_origen, transaccionCliente.id_cuenta_destino, transaccionCliente.fecha_inicial_transaccion
            FROM TRANSACCION transaccionCliente
            WHERE transaccionCliente.id_cliente = idClienteTransaccion

                AND transaccionCLiente.fecha_inicial_transaccion BETWEEN fechaInicialTransaccion AND fechaFinalTransaccion;
        
        DBMS_SQL.RETURN_RESULT(result);

    END;
/

CREATE OR REPLACE PROCEDURE sp_notifications_by_client (
    idClienteNotificacion IN INTEGER
)
AS
    result SYS_REFCURSOR;
BEGIN

    OPEN result FOR

        SELECT 
            TIPONOTIFICACION.nombre AS TipoNotificacion,
            NOTIFICACION.nombre AS Notificacion,
            CLIENTE.nombre || ' ' || CLIENTE.apellido AS Cliente,
            TIPOCLIENTE.nombre AS TipoCliente,
            INFOCLIENTE.telefono AS Telefono,
            INFOCLIENTE.correo AS Correo

        FROM NOTIFICACION

        INNER JOIN TIPONOTIFICACION ON NOTIFICACION.id_tipo_notificacion = TIPONOTIFICACION.id
        INNER JOIN CLIENTE ON NOTIFICACION.id_cliente = CLIENTE.id
        INNER JOIN TIPOCLIENTE ON CLIENTE.id_tipo_cliente = TIPOCLIENTE.id
        INNER JOIN INFOCLIENTE ON CLIENTE.id_info_cliente = INFOCLIENTE.id

        WHERE NOTIFICACION.id_cliente = idClienteNotificacion;

    DBMS_SQL.RETURN_RESULT(result);
END;
/

CREATE OR REPLACE PROCEDURE sp_products_by_client (
    idCliente IN INTEGER
)
AS
    result SYS_REFCURSOR;
BEGIN
    OPEN result FOR
        SELECT 
            TIPOSERVICIO.nombre AS TIPOSERVICIO,
            SERVICIO.nombre AS Servicio,
            CASE 
                WHEN CUENTA.id IS NOT NULL THEN 'Cuenta'
                WHEN TARJETA.id IS NOT NULL THEN 'Tarjeta'
            END AS "T.PRODUCTO",
            CASE 
                WHEN CUENTA.id IS NOT NULL THEN TIPOCUENTAS.nombre
                WHEN TARJETA.id IS NOT NULL THEN TIPOTARJETA.nombre
            END AS "TIPO.CUENTA/TARJETA",
            CLIENTE.nombre || ' ' || CLIENTE.apellido AS Cliente
        FROM CLIENTE
        LEFT JOIN PRODUCTO_SERVICIO ON CLIENTE.id = PRODUCTO_SERVICIO.id_cliente
        LEFT JOIN SERVICIO ON PRODUCTO_SERVICIO.id_servicio = SERVICIO.id
        LEFT JOIN TIPOSERVICIO ON SERVICIO.id_tipo_servicio = TIPOSERVICIO.id
        LEFT JOIN CUENTA ON CLIENTE.id = CUENTA.id_cliente
        LEFT JOIN TIPOCUENTAS ON CUENTA.id_tipo_cuenta = TIPOCUENTAS.id
        LEFT JOIN TARJETA ON CLIENTE.id = TARJETA.id_cliente
        LEFT JOIN TIPOTARJETA ON TARJETA.id_tipo_tarjeta = TIPOTARJETA.id
        WHERE CLIENTE.id = idCliente;

    DBMS_SQL.RETURN_RESULT(result);
END;
/

CREATE OR REPLACE PROCEDURE sp_awards_by_client (
    idCliente IN INTEGER
)
AS
    result SYS_REFCURSOR;
BEGIN
    OPEN result FOR
        SELECT 
            TIPOPREMIO.nombre AS PREMIO,
            TARJETA.Numero_Tarjeta AS TARJETA,
            TIPOTARJETA.nombre AS "TIPO TARJETA",
            CLIENTE.nombre || ' ' || CLIENTE.apellido AS Cliente
        FROM CLIENTE
        LEFT JOIN TIPOPREMIO ON CLIENTE.id = TIPOPREMIO.id_cliente
        LEFT JOIN TARJETA ON CLIENTE.id = TARJETA.id_cliente
        LEFT JOIN TIPOTARJETA ON TARJETA.id_tipo_tarjeta = TIPOTARJETA.id
        WHERE CLIENTE.id = idCliente;

    DBMS_SQL.RETURN_RESULT(result);
END;
/

CREATE OR REPLACE PROCEDURE sp_comming_money_by_client (
    idCliente IN INTEGER
)
AS
    result SYS_REFCURSOR;

    BEGIN

        OPEN result FOR

            SELECT 
                REMESA.pais AS "Origen Remesa",
                REMESA.fecha AS "Fecha",
                TIPOREMESA.nombre AS "TipoRemesa",
                CLIENTE.nombre || ' ' || CLIENTE.apellido AS "Cliente"
            FROM REMESA
            INNER JOIN CLIENTE ON REMESA.id_cliente = CLIENTE.id
            INNER JOIN TIPOREMESA ON REMESA.id_tipo_remesa = TIPOREMESA.id
            WHERE CLIENTE.id = idCliente;

        DBMS_SQL.RETURN_RESULT(result);
    END;
/