BEGIN
    sp_transactions_by_client(2, TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-06-02', 'YYYY-MM-DD'));
END;
/

SELECT * FROM TRANSACCION;