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
        En caso de que no encuentre la información, dará un error.
    */
    BEGIN
        SELECT nombre || ' ' || apellido INTO v_nombre_cliente
        FROM CLIENTE
        WHERE id = p_id_cliente;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se encontró ningún cliente con ID: ' || p_id_cliente);
    END;

    /*
        Obtiene el número de cuenta en base al ID.
        En caso de que no encuentre la información, dará un error.
    */
    BEGIN
        SELECT numero_cuenta INTO v_numero_cuenta
        FROM CUENTA
        WHERE id = p_id_cuenta;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'No se encontró ninguna cuenta con ID: ' || p_id_cuenta);
    END;

    /*
        SELECT COUNT(*) cuenta el número de filas que cumplen la condición.
        Si el resultado es 0, significa que no existe el cliente o la cuenta.
        Si el resultado es mayor que 0, significa que existe el cliente o la cuenta.
    */

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

/*
    Función que obtiene la cantidad de productos o srtvicios de un cliente entre las fechas establecidas.
    Toma como parámetros el ID del cliente y dos fechas, la inicial y la final para determinar el rango de tiempo.
    Además se valida que el cliente exista (si no existe da un error), y que las fechas sean válidas.
*/

CREATE OR REPLACE FUNCTION fn_amount_servicies_by_client(
    p_id_cliente IN NUMBER,
    p_fecha_inicial IN DATE,
    p_fecha_final IN DATE
) RETURN NUMBER IS
    v_cantidad NUMBER := 0;
    v_nombre_cliente VARCHAR(30);
    v_existe_cliente NUMBER;
BEGIN
    /*
        Obtiene el nombre y el apellido del cliente en base al ID.
        En caso de que no encuentre la información, dará un error.
    */
    BEGIN
        SELECT nombre || ' ' || apellido INTO v_nombre_cliente
        FROM CLIENTE
        WHERE id = p_id_cliente;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se encontró ningún cliente con ID: ' || p_id_cliente);
    END;

    -- Valida que las fechas no sean nulas
    IF p_fecha_inicial IS NULL OR p_fecha_final IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Las fechas no pueden ser nulas.');
    END IF;

    -- Valida que las fechas sean válidas
    IF p_fecha_inicial > p_fecha_final THEN
        RAISE_APPLICATION_ERROR(-20002, 'La fecha inicial no puede ser mayor a la fecha final.');
    END IF;

    -- Ahora sí realiza la consulta
    SELECT COUNT(*) INTO v_cantidad
    FROM PRODUCTO_SERVICIO ps -- Se le da el nombre de ps a la tabla 
    WHERE ps.id_cliente = p_id_cliente;
    
    RETURN v_cantidad;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error al obtener los datos');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20004, 'Error inesperado: ' || SQLERRM);
END fn_amount_servicies_by_client;
/

/*
    Funcion que calcula el promedio de los servicios o productos de los clientes.
    Toma como parámetros dos fechas, la inicial y la final, con esto determina el rango de tiempo a consultar.
    Valida que las fechas sean válidas y no sean nulas.
*/
CREATE OR REPLACE FUNCTION fn_avg_servicies(
    p_fecha_inicial IN DATE,
    p_fecha_final IN DATE
) RETURN NUMBER IS
    v_promedio NUMBER;
BEGIN
    -- Valida que las fechas no sean nulas
    IF p_fecha_inicial IS NULL OR p_fecha_final IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'Las fechas no pueden ser nulas.');
    END IF;

    -- Valida que las fechas sean válidas
    IF p_fecha_inicial > p_fecha_final THEN
        RAISE_APPLICATION_ERROR(-20002, 'La fecha inicial no puede ser mayor a la fecha final.');
    END IF;

    -- Ahora sí realiza la consulta
    SELECT AVG(cantidad_servicios) INTO v_promedio
    FROM (
        SELECT COUNT(*) AS cantidad_servicios
        FROM PRODUCTO_SERVICIO ps -- Se le da el nombre de ps a la tabla 
        BETWEEN p_fecha_inicial AND p_fecha_final
        GROUP BY ps.id_cliente
    );
    
    RETURN NVL(v_promedio, 0);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20004, 'Error inesperado: ' || SQLERRM);
END fn_avg_servicies;
/

/*
    Funcion que consulta el valor de todos los servicios pagados de un cliente en una fecha determinada.
    Toma como parámetros el ID del cliente y dos fechas, inicial y final para determinar el rango de tiempo.
    Valida que el cliente exista (si no existe da un error), y que las fechas sean válidas.
*/
CREATE OR REPLACE FUNCTION fn_total_amount_servicies_by_client(
    p_id_cliente IN NUMBER,
    p_fecha_inicial IN DATE,
    p_fecha_final IN DATE
) RETURN NUMBER IS
    v_total NUMBER := 0;
    v_nombre_cliente VARCHAR(30);
BEGIN
    -- Valida que exista el cliente
    BEGIN
        SELECT nombre || ' ' || apellido INTO v_nombre_cliente
        FROM CLIENTE
        WHERE id = p_id_cliente;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se encontró ningún cliente con ID: ' || p_id_cliente);
    END;

    -- Valida que las fechas sean válidas
    IF p_fecha_inicial IS NULL OR p_fecha_final IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Las fechas no pueden ser nulas.');
    END IF;
    
    IF p_fecha_inicial > p_fecha_final THEN
        RAISE_APPLICATION_ERROR(-20003, 'La fecha inicial no puede ser mayor a la fecha final.');
    END IF;

    -- Calcula la suma del valor de todos los servicios del cliente
    SELECT NVL(SUM(s.monto), 0) INTO v_total
    FROM PRODUCTO_SERVICIO ps
    JOIN SERVICIO s ON ps.id_servicio = s.id
    WHERE ps.id_cliente = p_id_cliente;
    
    RETURN v_total;
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20004, 'Error inesperado: ' || SQLERRM);
END fn_total_amount_servicies_by_client;
/

/*
    Funcion que consulta el valor mensual a pagar del prestamo de un cliente-
    Toma como parámetros el ID del cliente y el ID del prestaom.
    Valida que el cliente exista (si no existe da un error), y que el prestamo exista (si no existe da un error).
*/
CREATE OR REPLACE FUNCTION fn_next_payment(
    p_id_cliente IN NUMBER,
    p_id_prestamo IN NUMBER
) RETURN NUMBER IS
    v_pago_mensual NUMBER := 0;
    v_nombre_cliente VARCHAR(100);
    v_monto_prestamo NUMBER;
    v_tasa_interes NUMBER;
    v_meses NUMBER;
    v_prestamo_cliente NUMBER;
BEGIN
    -- Validar que exista el cliente
    BEGIN
        SELECT nombre || ' ' || apellido INTO v_nombre_cliente
        FROM CLIENTE
        WHERE id = p_id_cliente;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se encontró ningún cliente con ID: ' || p_id_cliente);
    END;
    
    -- Validar que exista el préstamo
    BEGIN
        SELECT COUNT(*) INTO v_prestamo_cliente
        FROM PRESTAMO
        WHERE id = p_id_prestamo;
        
        IF v_prestamo_cliente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'No se encontró ningún préstamo con ID: ' || p_id_prestamo);
        END IF;
    END;
    
    -- Validar que el préstamo pertenezca al cliente
    SELECT COUNT(*) INTO v_prestamo_cliente
    FROM PRESTAMO
    WHERE id = p_id_prestamo AND id_cliente = p_id_cliente;
    
    IF v_prestamo_cliente = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'El préstamo no pertenece al cliente: ' || v_nombre_cliente);
    END IF;
    
    -- Obtener los datos del préstamo
    SELECT monto_prestamo, tasa_interes, meses
    INTO v_monto_prestamo, v_tasa_interes, v_meses
    FROM PRESTAMO
    WHERE id = p_id_prestamo;
    
    v_pago_mensual := (v_monto_prestamo / v_meses) + (v_monto_prestamo * (v_tasa_interes / 12));
    
    RETURN v_pago_mensual;
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20004, 'Error inesperado: ' || SQLERRM);
END fn_next_payment;
/