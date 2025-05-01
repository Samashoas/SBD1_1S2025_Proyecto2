/*
INSERT INTO REMESA (id, pais, fecha, id_cliente, id_tipo_remesa, id_tipo_cuenta)
VALUES (1, 'México', TO_DATE('2025-04-27', 'YYYY-MM-DD'), 1, 1, 1);
INSERT INTO PRESTAMO (id, monto_prestamo, tasa_interes, meses, contratacion, fecha_vencimiento, id_cliente)
VALUES (1, 10000.00, 0.15, 12, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2025-12-31', 'YYYY-MM-DD'), 1);

*/

BEGIN

    sp_comming_money(1, TO_DATE('2025-04-27', 'YYYY-MM-DD'), 'Italia', 1, 1);


END;
/

BEGIN 
        sp_get_loan(10000, 15, 3, 1);
END;
/

BEGIN 
        sp_get_loan(10000, 15, 3, 1);
END;
/
-- sp_transaction(IdTipoTransacción, Fecha, OtrosDetalles, idCliente, IdCuenta/idTarjeta, Valor, idCuentaOrigen, idCuentaDestino)
-- Cada uno de las transacciones se pueden hacer desde una cuenta o tarjeta. Tener en cuenta todas las posibles variantes
BEGIN 
        sp_transaction(1, SYSDATE, 'Tipo 1', 1, 1, 300, 1, 1);
END;
/
-- SELECT MAX(id) AS max_id FROM REMESA;


/*
DROP SEQUENCE seq_remesa;

CREATE SEQUENCE seq_remesa START WITH 6 INCREMENT BY 1;

SELECT constraint_name, column_name
FROM all_cons_columns
WHERE table_name = 'REMESA';
*/
 
-- SELECT * from REMESA;
-- SELECT * from PRESTAMO;
SELECT * from TRANSACCION;