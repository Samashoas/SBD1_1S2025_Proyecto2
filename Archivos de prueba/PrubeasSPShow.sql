BEGIN
    sp_transactions_by_client(1, TO_DATE('2025-04-27', 'YYYY-MM-DD'), TO_DATE('2025-04-30', 'YYYY-MM-DD'));
END;
/

-- SELECT * FROM TRANSACCION;