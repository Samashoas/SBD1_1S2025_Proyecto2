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