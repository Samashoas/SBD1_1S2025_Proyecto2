BEGIN
    sp_transactions_by_client(2, TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2025-06-02', 'YYYY-MM-DD'));
    sp_notifications_by_client(2);
    sp_products_by_client(1);
    sp_awards_by_client(1);
    sp_comming_money_by_client(1);
END;
/


/*
SELECT * FROM TRANSACCION;
SELECT * FROM NOTIFICACION;
*/

-- SELECT * FROM CLIENTE;

-- SELECT * FROM TARJETA;