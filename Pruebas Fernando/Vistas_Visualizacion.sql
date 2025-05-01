SET SERVEROUTPUT ON;

-- 1. Vista de seguros activos
BEGIN
   EXECUTE IMMEDIATE 'DROP VIEW vw_active_insurances_v2';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN  -- Si el error no es "vista no existe"
         RAISE;
      END IF;
END;
/

CREATE OR REPLACE VIEW vw_active_insurances_v2 AS
SELECT 
    ts.nombre AS tipo_seguro,
    -- Información del seguro
    s.monto_asegurado,
    s.valor_seguro,
    s.cantidad_pagos,
    s.meses_asegurado,
    s.contratacion,
    s.fecha_vencimiento,
    -- Información del cliente
    c.nombre AS nombre_cliente,
    c.apellido AS apellido_cliente,
    ic.telefono,
    ic.correo
FROM 
    SEGURO s
    JOIN TIPOSEGURO ts ON s.id_tipo_seguro = ts.id
    JOIN CLIENTE c ON s.id_cliente = c.id
    JOIN INFOCLIENTE ic ON c.id_info_cliente = ic.id
WHERE 
    s.fecha_vencimiento > SYSDATE  -- Solo seguros activos
ORDER BY 
    s.fecha_vencimiento  -- Ordenar por fecha de vencimiento más cercana primero
/

-- Para verificar que la vista se creó correctamente
SELECT * FROM vw_active_insurances_v2;

-- 2. Vista de seguros inactivos
BEGIN
   EXECUTE IMMEDIATE 'DROP VIEW vw_inactive_insurances_v2';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN  -- Si el error no es "vista no existe"
         RAISE;
      END IF;
END;
/

CREATE OR REPLACE VIEW vw_inactive_insurances_v2 AS
SELECT 
    ts.nombre AS tipo_seguro,
    -- Información del seguro
    s.monto_asegurado,
    s.valor_seguro,
    s.cantidad_pagos,
    s.meses_asegurado,
    s.contratacion,
    s.fecha_vencimiento,
    -- Información del cliente
    c.nombre AS nombre_cliente,
    c.apellido AS apellido_cliente,
    ic.telefono,
    ic.correo
FROM 
    SEGURO s
    JOIN TIPOSEGURO ts ON s.id_tipo_seguro = ts.id
    JOIN CLIENTE c ON s.id_cliente = c.id
    JOIN INFOCLIENTE ic ON c.id_info_cliente = ic.id
WHERE 
    s.fecha_vencimiento <= SYSDATE  -- Solo seguros inactivos/vencidos
ORDER BY 
    s.fecha_vencimiento DESC  -- Ordenar por fecha de vencimiento más reciente primero
/

-- Para verificar que la vista se creó correctamente
SELECT * FROM vw_inactive_insurances_v2;

-- 3. Vista de préstamos activos
BEGIN
   EXECUTE IMMEDIATE 'DROP VIEW vw_active_loans_v2';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN  -- Si el error no es "vista no existe"
         RAISE;
      END IF;
END;
/

CREATE OR REPLACE VIEW vw_active_loans_v2 AS
SELECT 
    -- Información del préstamo
    p.monto_prestamo,
    p.tasa_interes,
    p.meses,
    p.contratacion,
    p.fecha_vencimiento,
    -- Información del cliente
    c.nombre AS nombre_cliente,
    c.apellido AS apellido_cliente,
    ic.telefono,
    ic.correo
FROM 
    PRESTAMO p
    JOIN CLIENTE c ON p.id_cliente = c.id
    JOIN INFOCLIENTE ic ON c.id_info_cliente = ic.id
WHERE 
    p.fecha_vencimiento > SYSDATE  -- Solo préstamos activos
ORDER BY 
    p.fecha_vencimiento  -- Ordenar por fecha de vencimiento más cercana primero
/

-- Para verificar que la vista se creó correctamente
SELECT * FROM vw_active_loans_v2;


-- 5. Vista de préstamos inactivos
BEGIN
   EXECUTE IMMEDIATE 'DROP VIEW vw_inactive_loans_v2';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN  -- Si el error no es "vista no existe"
         RAISE;
      END IF;
END;
/

CREATE OR REPLACE VIEW vw_inactive_loans_v2 AS
SELECT 
    -- Información del préstamo
    p.monto_prestamo,
    p.tasa_interes,
    p.meses,
    p.contratacion,
    p.fecha_vencimiento,
    -- Información del cliente
    c.nombre AS nombre_cliente,
    c.apellido AS apellido_cliente,
    ic.telefono,
    ic.correo
FROM 
    PRESTAMO p
    JOIN CLIENTE c ON p.id_cliente = c.id
    JOIN INFOCLIENTE ic ON c.id_info_cliente = ic.id
WHERE 
    p.fecha_vencimiento <= SYSDATE  -- Solo préstamos inactivos/vencidos
ORDER BY 
    p.fecha_vencimiento DESC  -- Ordenar por fecha de vencimiento más reciente primero
/

-- Para verificar que la vista se creó correctamente
SELECT * FROM vw_inactive_loans_v2;

-- 6. Vista de tarjetas de crédito vigentes
BEGIN
   EXECUTE IMMEDIATE 'DROP VIEW vw_active_credit_cards_v2';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN  -- Si el error no es "vista no existe"
         RAISE;
      END IF;
END;
/

CREATE OR REPLACE VIEW vw_active_credit_cards_v2 AS
SELECT 
    -- Información de la tarjeta
    tt.nombre AS tipo_tarjeta,
    t.Numero_Tarjeta,
    t.moneda,
    t.monto_limite,
    t.Dia_corte,
    t.Dia_pago,
    t.Tasa_interes,
    t.fecha_expedicion,
    -- Información del cliente
    c.nombre AS nombre_cliente,
    c.apellido AS apellido_cliente,
    ic.telefono,
    ic.correo
FROM 
    TARJETA t
    JOIN TIPOTARJETA tt ON t.id_tipo_tarjeta = tt.id
    JOIN CLIENTE c ON t.id_cliente = c.id
    JOIN INFOCLIENTE ic ON c.id_info_cliente = ic.id
WHERE 
    t.tipo = 'C'  -- Solo tarjetas de crédito
    AND t.fecha_expedicion <= SYSDATE  -- Tarjetas ya expedidas
    AND t.monto_limite > 0  -- Con límite de crédito activo
ORDER BY 
    tt.nombre, c.apellido, c.nombre
/

-- Para verificar que la vista se creó correctamente
SELECT * FROM vw_active_credit_cards_v2;


-- 7. Vista de tarjetas de débito vigentes
BEGIN
   EXECUTE IMMEDIATE 'DROP VIEW vw_active_debit_cards_v2';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN  -- Si el error no es "vista no existe"
         RAISE;
      END IF;
END;
/

CREATE OR REPLACE VIEW vw_active_debit_cards_v2 AS
SELECT 
    -- Información de la tarjeta
    tt.nombre AS tipo_tarjeta,
    t.Numero_Tarjeta,
    t.moneda,
    t.fecha_expedicion,
    -- Información del cliente
    c.nombre AS nombre_cliente,
    c.apellido AS apellido_cliente,
    ic.telefono,
    ic.correo
FROM 
    TARJETA t
    JOIN TIPOTARJETA tt ON t.id_tipo_tarjeta = tt.id
    JOIN CLIENTE c ON t.id_cliente = c.id
    JOIN INFOCLIENTE ic ON c.id_info_cliente = ic.id
WHERE 
    t.tipo = 'D'  -- Solo tarjetas de débito
    AND t.fecha_expedicion <= SYSDATE  -- Tarjetas ya expedidas
ORDER BY 
    tt.nombre, c.apellido, c.nombre
/

-- Para verificar que la vista se creó correctamente
SELECT * FROM vw_active_debit_cards_v2;