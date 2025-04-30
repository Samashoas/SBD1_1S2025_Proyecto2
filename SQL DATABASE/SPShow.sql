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