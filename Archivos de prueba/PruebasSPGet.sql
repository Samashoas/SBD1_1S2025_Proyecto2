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

BEGIN 
        sp_transaction(1, SYSDATE, 'Tipo 1', 1, 1, 300, 1, 1);

END;
/

BEGIN 

        sp_get_insurance(1, 10000, 500.00, 12, 24, 1);
END;
/

BEGIN 

        sp_get_product_service(1, 1, 1 , 'Pago de energía Eléctrica (EEGSA)', 1, 1);
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
 
SELECT * from REMESA;
SELECT * from PRESTAMO;
SELECT * from TRANSACCION;
SELECT * FROM SEGURO;
SELECT * FROM SERVICIO;
SELECT * FROM PRODUCTO_SERVICIO;