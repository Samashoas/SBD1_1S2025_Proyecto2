/*
INSERT INTO REMESA (id, pais, fecha, id_cliente, id_tipo_remesa, id_tipo_cuenta)
VALUES (1, 'México', TO_DATE('2025-04-27', 'YYYY-MM-DD'), 1, 1, 1);
INSERT INTO REMESA (id, pais, fecha, id_cliente, id_tipo_remesa, id_tipo_cuenta)
VALUES (2, 'Estados Unidos', TO_DATE('2025-04-27', 'YYYY-MM-DD'), 2, 2, 2);
INSERT INTO REMESA (id, pais, fecha, id_cliente, id_tipo_remesa, id_tipo_cuenta)
VALUES (3, 'España', TO_DATE('2025-04-27', 'YYYY-MM-DD'), 3, 2, 3);
*/

BEGIN

    sp_comming_money(1, TO_DATE('2025-04-27', 'YYYY-MM-DD'), 'Italia', 1, 1);

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
