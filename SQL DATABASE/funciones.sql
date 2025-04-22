/* 
    Función que obtiene el saldo de una cuenta de un cliente específico.
    Recibe como parámetros el ID del cliente y el ID de la cuenta.
    Valida que el cliente y la cuenta existan, y que la cuenta pertenezca al cliente.
*/
CREATE OR REPLACE FUNCTION fn_current_money_by_client(
    p_id_cliente IN NUMBER,
    p_id_cuenta IN NUMBER
) RETURN NUMBER IS
    v_saldo NUMBER;
    v_nombre_cliente VARCHAR(30);
    v_numero_cuenta NUMBER;
    v_existe_cliente NUMBER;
    v_existe_cuenta NUMBER;
    v_cuenta_de_cliente NUMBER;
BEGIN
    /*
        Obtiene el nombre y el apellido del cliente en base al ID.
        En caso de que no encuentre la información, se le asignará null
    */
    BEGIN
        SELECT nombre || ' ' || apellido INTO v_nombre_cliente
        FROM CLIENTE
        WHERE id = p_id_cliente;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            v_nombre_cliente := NULL;
    END;

    /*
        Obtiene el número de cuenta en base al ID.
        En caso de que no encuentre la información, se le asignará null
    */
    BEGIN
        SELECT numero_cuenta INTO v_numero_cuenta
        FROM CUENTA
        WHERE id = p_id_cuenta;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            v_numero_cuenta := NULL;
    END;

    /*
        SELECT COUNT(*) cuenta el número de filas que cumplen la condición.
        Si el resultado es 0, significa que no existe el cliente o la cuenta.
        Si el resultado es mayor que 0, significa que existe el cliente o la cuenta.
    */
    -- Valida que exista el cliente
    SELECT COUNT(*) INTO v_existe_cliente
    FROM CLIENTE
    WHERE id = p_id_cliente;
    
    IF v_existe_cliente = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El cliente: ' || v_nombre_cliente || ' no existe');
    END IF;
    
    -- Validar que exista la cuenta
    SELECT COUNT(*) INTO v_existe_cuenta
    FROM CUENTA
    WHERE id = p_id_cuenta;
    
    IF v_existe_cuenta = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'La cuenta: ' || v_numero_cuenta || ' no existe');
    END IF;
    
    -- Validar que la cuenta sea del cliente especificado
    SELECT COUNT(*) INTO v_cuenta_de_cliente
    FROM CUENTA
    WHERE id = p_id_cuenta AND id_cliente = p_id_cliente;
    
    IF v_cuenta_de_cliente = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'La cuenta: ' || v_numero_cuenta || ', no pertenece al cliente: ' || v_nombre_cliente);
    END IF;
    
    -- Obtener el saldo de la cuenta
    SELECT Saldo INTO v_saldo
    FROM CUENTA
    WHERE id = p_id_cuenta;
    
    RETURN v_saldo;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20004, 'Error al obtener los datos');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20005, 'Error inesperado: ' || SQLERRM);
END fn_current_money_by_client;
/