-- Procedimientos almacenados para la visualización de datos

--1. Todos los seguros que se encuentren con activos, listando
--a. Tipo seguro
--b. Información del seguro
--c. Cliente
--nombre: vw_active_insurances

-- Eliminar la vista existente si existe
DROP VIEW vw_active_insurances;

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE vw_active_insurances 
IS
BEGIN
    FOR r IN (
        SELECT 
            ts.nombre AS tipo_seguro,
            s.monto_asegurado,
            s.fecha_vencimiento,
            c.nombre AS nombre_cliente,
            c.apellido AS apellido_cliente
        FROM SEGURO s
        JOIN TIPOSEGURO ts ON s.id_tipo_seguro = ts.id
        JOIN CLIENTE c ON s.id_cliente = c.id
        JOIN INFOCLIENTE ic ON c.id_info_cliente = ic.id
        WHERE s.fecha_vencimiento > SYSDATE
        ORDER BY s.fecha_vencimiento
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Tipo de Seguro: ' || r.tipo_seguro ||
            ', Cliente: ' || r.nombre_cliente || ' ' || r.apellido_cliente ||
            ', Monto Asegurado: ' || r.monto_asegurado ||
            ', Vencimiento: ' || TO_CHAR(r.fecha_vencimiento, 'DD/MM/YYYY')
        );
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END;
/

-- Ejemplo de uso:
EXEC vw_active_insurances;


-- 2. Todos los seguros que se encuentren inactivos
DROP VIEW vw_inactive_insurances;

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE vw_inactive_insurances 
IS
BEGIN
    FOR r IN (
        SELECT 
            ts.nombre AS tipo_seguro,
            s.monto_asegurado,
            s.fecha_vencimiento,
            c.nombre AS nombre_cliente,
            c.apellido AS apellido_cliente
        FROM SEGURO s
        JOIN TIPOSEGURO ts ON s.id_tipo_seguro = ts.id
        JOIN CLIENTE c ON s.id_cliente = c.id
        JOIN INFOCLIENTE ic ON c.id_info_cliente = ic.id
        WHERE s.fecha_vencimiento <= SYSDATE  -- Filtro para seguros inactivos/vencidos
        ORDER BY s.fecha_vencimiento DESC  -- Ordenado por fecha de vencimiento, más recientes primero
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Tipo de Seguro: ' || r.tipo_seguro ||
            ', Cliente: ' || r.nombre_cliente || ' ' || r.apellido_cliente ||
            ', Monto Asegurado: ' || r.monto_asegurado ||
            ', Vencimiento: ' || TO_CHAR(r.fecha_vencimiento, 'DD/MM/YYYY')
        );
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END;
/

-- Ejemplo de uso:
EXEC vw_inactive_insurances;


-- 3. Todos los préstamos que se encuentren activos
DROP VIEW vw_active_loans;

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE vw_active_loans 
IS
BEGIN
    FOR r IN (
        SELECT 
            p.monto_prestamo,
            p.tasa_interes,
            p.meses,
            p.contratacion,
            p.fecha_vencimiento,
            c.nombre AS nombre_cliente,
            c.apellido AS apellido_cliente,
            ic.telefono,
            ic.correo
        FROM PRESTAMO p
        JOIN CLIENTE c ON p.id_cliente = c.id
        JOIN INFOCLIENTE ic ON c.id_info_cliente = ic.id
        WHERE p.fecha_vencimiento > SYSDATE  -- Filtro para préstamos activos
        ORDER BY p.fecha_vencimiento
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Cliente: ' || r.nombre_cliente || ' ' || r.apellido_cliente ||
            ', Monto: ' || r.monto_prestamo ||
            ', Tasa: ' || (r.tasa_interes * 100) || '%' ||
            ', Plazo: ' || r.meses || ' meses' ||
            ', Vencimiento: ' || TO_CHAR(r.fecha_vencimiento, 'DD/MM/YYYY')
        );
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END;
/

-- Ejemplo de uso:
EXEC vw_active_loans;


-- 5. Todos los préstamos que se encuentren inactivos
DROP VIEW vw_inactive_loans;

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE vw_inactive_loans 
IS
BEGIN
    FOR r IN (
        SELECT 
            p.monto_prestamo,
            p.tasa_interes,
            p.meses,
            p.contratacion,
            p.fecha_vencimiento,
            c.nombre AS nombre_cliente,
            c.apellido AS apellido_cliente,
            ic.telefono,
            ic.correo
        FROM PRESTAMO p
        JOIN CLIENTE c ON p.id_cliente = c.id
        JOIN INFOCLIENTE ic ON c.id_info_cliente = ic.id
        WHERE p.fecha_vencimiento <= SYSDATE  -- Filtro para préstamos inactivos/vencidos
        ORDER BY p.fecha_vencimiento DESC  -- Los más recientemente vencidos primero
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Cliente: ' || r.nombre_cliente || ' ' || r.apellido_cliente ||
            ', Monto: ' || r.monto_prestamo ||
            ', Tasa: ' || (r.tasa_interes * 100) || '%' ||
            ', Plazo: ' || r.meses || ' meses' ||
            ', Contratación: ' || TO_CHAR(r.contratacion, 'DD/MM/YYYY') ||
            ', Vencimiento: ' || TO_CHAR(r.fecha_vencimiento, 'DD/MM/YYYY') ||
            ', Contacto: Tel: ' || r.telefono || ', Email: ' || r.correo
        );
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END;
/

-- Ejemplo de uso:
EXEC vw_inactive_loans;


-- 6. Listar todas las tarjetas de crédito vigentes
DROP VIEW vw_active_credit_cards;

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE vw_active_credit_cards 
IS
BEGIN
    FOR r IN (
        SELECT 
            tt.nombre AS tipo_tarjeta,
            t.Numero_Tarjeta,
            t.moneda,
            t.monto_limite,
            t.Dia_corte,
            t.Dia_pago,
            t.Tasa_interes,
            t.fecha_expedicion,
            c.nombre AS nombre_cliente,
            c.apellido AS apellido_cliente,
            ic.telefono,
            ic.correo
        FROM TARJETA t
        JOIN TIPOTARJETA tt ON t.id_tipo_tarjeta = tt.id
        JOIN CLIENTE c ON t.id_cliente = c.id
        JOIN INFOCLIENTE ic ON c.id_info_cliente = ic.id
        WHERE t.tipo = 'C'  -- Solo tarjetas de crédito
        AND t.fecha_expedicion <= SYSDATE  -- Tarjetas ya expedidas
        AND (
            -- Asumimos que una tarjeta está vigente si:
            -- 1. Tiene fecha de expedición
            -- 2. Es de tipo crédito (ya filtrado en WHERE)
            -- 3. Tiene límite de crédito activo (monto_limite > 0)
            t.monto_limite > 0
        )
        ORDER BY tt.nombre, c.apellido, c.nombre
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Tipo: ' || r.tipo_tarjeta ||
            ', Cliente: ' || r.nombre_cliente || ' ' || r.apellido_cliente ||
            ', Número: ' || r.Numero_Tarjeta ||
            ', Límite: ' || r.monto_limite || ' ' || r.moneda ||
            ', Tasa: ' || (r.Tasa_interes * 100) || '%' ||
            ', Corte: ' || r.Dia_corte ||
            ', Pago: ' || r.Dia_pago
        );
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END;
/

-- Ejemplo de uso:
EXEC vw_active_credit_cards;


-- 7. Listar todas las tarjetas de débito vigentes
DROP VIEW vw_active_debit_cards;

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE vw_active_debit_cards 
IS
BEGIN
    FOR r IN (
        SELECT 
            tt.nombre AS tipo_tarjeta,
            t.Numero_Tarjeta,
            t.moneda,
            t.fecha_expedicion,
            c.nombre AS nombre_cliente,
            c.apellido AS apellido_cliente,
            ic.telefono,
            ic.correo
        FROM TARJETA t
        JOIN TIPOTARJETA tt ON t.id_tipo_tarjeta = tt.id
        JOIN CLIENTE c ON t.id_cliente = c.id
        JOIN INFOCLIENTE ic ON c.id_info_cliente = ic.id
        WHERE t.tipo = 'D'  -- Solo tarjetas de débito
        AND t.fecha_expedicion <= SYSDATE  -- Tarjetas ya expedidas
        ORDER BY tt.nombre, c.apellido, c.nombre
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Tipo: ' || r.tipo_tarjeta ||
            ', Cliente: ' || r.nombre_cliente || ' ' || r.apellido_cliente ||
            ', Número: ' || r.Numero_Tarjeta ||
            ', Moneda: ' || r.moneda ||
            ', Expedición: ' || TO_CHAR(r.fecha_expedicion, 'DD/MM/YYYY')
        );
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END;
/

-- Ejemplo de uso:
EXEC vw_active_debit_cards;


-- 8. Listar todas las transacciones de depósitos/débitos
DROP VIEW vw_transactions;

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE vw_transactions 
IS
BEGIN
    FOR r IN (
        SELECT 
            tc.nombre AS tipo_cuenta,
            c.numero_cuenta,
            c.Saldo,
            tt.nombre AS tipo_transaccion,
            cl.nombre AS nombre_cliente,
            cl.apellido AS apellido_cliente,
            ic.telefono,
            ic.correo
        FROM TRANSACCION t
        JOIN TIPOTRANSACCION tt ON t.id_tipotrans = tt.id
        JOIN CUENTA c ON t.id_cuenta_origen = c.id  -- Cuenta origen
        JOIN TIPOCUENTAS tc ON c.id_tipo_cuenta = tc.id  -- Tipo de la cuenta
        JOIN CLIENTE cl ON t.id_cliente = cl.id
        JOIN INFOCLIENTE ic ON cl.id_info_cliente = ic.id
        WHERE tt.nombre IN ('Depósito', 'Retiro')  -- Solo depósitos y retiros
        ORDER BY tt.nombre, cl.apellido, cl.nombre
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Tipo Transacción: ' || r.tipo_transaccion ||
            ', Cuenta: ' || r.numero_cuenta || ' (' || r.tipo_cuenta || ')' ||
            ', Cliente: ' || r.nombre_cliente || ' ' || r.apellido_cliente ||
            ', Saldo: Q' || r.Saldo ||
            ', Contacto: Tel: ' || r.telefono || ', Email: ' || r.correo
        );
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END;
/

-- Ejemplo de uso:
EXEC vw_transactions;


-- 9. Listar todas las transacciones relacionadas con una tarjeta
DROP VIEW vw_card_transactions;

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE vw_card_transactions 
IS
BEGIN
    FOR r IN (
        SELECT 
            t.tipo AS tipo_tarjeta,
            t.Numero_Tarjeta,
            tt.nombre AS nombre_tipo_tarjeta,
            tr.id AS id_transaccion,
            ttr.nombre AS tipo_transaccion,
            c.nombre AS nombre_cliente,
            c.apellido AS apellido_cliente,
            ic.telefono,
            ic.correo,
            co.numero_cuenta AS cuenta_origen,
            cd.numero_cuenta AS cuenta_destino,
            co.Saldo AS saldo_actual
        FROM TARJETA t
        JOIN TIPOTARJETA tt ON t.id_tipo_tarjeta = tt.id
        JOIN CLIENTE c ON t.id_cliente = c.id
        JOIN INFOCLIENTE ic ON c.id_info_cliente = ic.id
        JOIN CUENTA co ON co.id_cliente = c.id  -- Cuentas del cliente
        JOIN TRANSACCION tr ON (tr.id_cuenta_origen = co.id OR tr.id_cuenta_destino = co.id)  -- Transacciones relacionadas con las cuentas
        JOIN TIPOTRANSACCION ttr ON tr.id_tipotrans = ttr.id
        JOIN CUENTA cd ON tr.id_cuenta_destino = cd.id  -- Cuenta destino de la transacción
        ORDER BY tr.id, tt.nombre, c.apellido, c.nombre
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Tarjeta: ' || r.nombre_tipo_tarjeta || ' (' || 
            CASE r.tipo_tarjeta 
                WHEN 'D' THEN 'Débito'
                WHEN 'C' THEN 'Crédito'
            END || ') - ' ||
            r.Numero_Tarjeta ||
            CHR(10) ||
            'Transacción: ' || r.tipo_transaccion ||
            ', De cuenta: ' || r.cuenta_origen ||
            ' A cuenta: ' || r.cuenta_destino ||
            CHR(10) ||
            'Cliente: ' || r.nombre_cliente || ' ' || r.apellido_cliente ||
            ', Saldo actual: ' || r.saldo_actual ||
            CHR(10) ||
            'Contacto: Tel: ' || r.telefono || ', Email: ' || r.correo ||
            CHR(10) || '----------------------------------------'
        );
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END;
/

-- Ejemplo de uso:
EXEC vw_card_transactions;


-- 10. Listar todos los productos/servicios adquiridos por los clientes
DROP VIEW vw_products;

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE vw_products 
IS
    -- Variables para controlar el formato de salida
    v_current_client VARCHAR2(100);
BEGIN
    -- Primero mostramos los servicios contratados
    FOR r IN (
        SELECT 
            ts.nombre AS tipo_servicio,
            s.nombre AS nombre_servicio,
            s.monto AS monto_servicio,
            c.nombre AS nombre_cliente,
            c.apellido AS apellido_cliente,
            ic.telefono,
            ic.correo
        FROM PRODUCTO_SERVICIO ps
        JOIN SERVICIO s ON ps.id_servicio = s.id
        JOIN TIPOSERVICIO ts ON s.id_tipo_servicio = ts.id
        JOIN CLIENTE c ON ps.id_cliente = c.id
        JOIN INFOCLIENTE ic ON c.id_info_cliente = ic.id
        ORDER BY c.apellido, c.nombre, ts.nombre
    ) LOOP
        IF v_current_client IS NULL OR v_current_client != (r.nombre_cliente || ' ' || r.apellido_cliente) THEN
            v_current_client := r.nombre_cliente || ' ' || r.apellido_cliente;
            DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Cliente: ' || v_current_client);
            DBMS_OUTPUT.PUT_LINE('Contacto: Tel: ' || r.telefono || ', Email: ' || r.correo);
            DBMS_OUTPUT.PUT_LINE('----------------------------------------');
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(
            'Servicio: ' || r.tipo_servicio || ' - ' || r.nombre_servicio ||
            ', Monto: Q' || r.monto_servicio
        );
    END LOOP;

    -- Luego mostramos las cuentas
    FOR r IN (
        SELECT 
            tc.nombre AS tipo_cuenta,
            tc.descripcion AS desc_cuenta,
            c.numero_cuenta,
            c.Saldo,
            cl.nombre AS nombre_cliente,
            cl.apellido AS apellido_cliente,
            ic.telefono,
            ic.correo
        FROM CUENTA c
        JOIN TIPOCUENTAS tc ON c.id_tipo_cuenta = tc.id
        JOIN CLIENTE cl ON c.id_cliente = cl.id
        JOIN INFOCLIENTE ic ON cl.id_info_cliente = ic.id
        ORDER BY cl.apellido, cl.nombre, tc.nombre
    ) LOOP
        IF v_current_client IS NULL OR v_current_client != (r.nombre_cliente || ' ' || r.apellido_cliente) THEN
            v_current_client := r.nombre_cliente || ' ' || r.apellido_cliente;
            DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Cliente: ' || v_current_client);
            DBMS_OUTPUT.PUT_LINE('Contacto: Tel: ' || r.telefono || ', Email: ' || r.correo);
            DBMS_OUTPUT.PUT_LINE('----------------------------------------');
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(
            'Cuenta: ' || r.tipo_cuenta ||
            ' (' || r.desc_cuenta || ')' ||
            ', Número: ' || r.numero_cuenta ||
            ', Saldo: Q' || r.Saldo
        );
    END LOOP;

    -- Finalmente mostramos las tarjetas
    FOR r IN (
        SELECT 
            t.tipo,
            tt.nombre AS tipo_tarjeta,
            t.Numero_Tarjeta,
            t.moneda,
            t.monto_limite,
            t.fecha_expedicion,
            c.nombre AS nombre_cliente,
            c.apellido AS apellido_cliente,
            ic.telefono,
            ic.correo
        FROM TARJETA t
        JOIN TIPOTARJETA tt ON t.id_tipo_tarjeta = tt.id
        JOIN CLIENTE c ON t.id_cliente = c.id
        JOIN INFOCLIENTE ic ON c.id_info_cliente = ic.id
        ORDER BY c.apellido, c.nombre, tt.nombre
    ) LOOP
        IF v_current_client IS NULL OR v_current_client != (r.nombre_cliente || ' ' || r.apellido_cliente) THEN
            v_current_client := r.nombre_cliente || ' ' || r.apellido_cliente;
            DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Cliente: ' || v_current_client);
            DBMS_OUTPUT.PUT_LINE('Contacto: Tel: ' || r.telefono || ', Email: ' || r.correo);
            DBMS_OUTPUT.PUT_LINE('----------------------------------------');
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(
            'Tarjeta: ' || r.tipo_tarjeta || ' (' || 
            CASE r.tipo 
                WHEN 'D' THEN 'Débito'
                WHEN 'C' THEN 'Crédito'
            END || ')' ||
            ', Número: ' || r.Numero_Tarjeta ||
            ', Moneda: ' || r.moneda ||
            CASE 
                WHEN r.tipo = 'C' THEN ', Límite: ' || r.monto_limite
                ELSE ''
            END ||
            ', Expedición: ' || TO_CHAR(r.fecha_expedicion, 'DD/MM/YYYY')
        );
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END;
/

-- Ejemplo de uso:
EXEC vw_products;






