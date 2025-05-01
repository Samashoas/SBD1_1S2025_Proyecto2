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