-- Consultas para tablas de catálogos/tipos
SELECT 'TIPOCLIENTE' as tabla, COUNT(*) as total FROM TIPOCLIENTE UNION ALL
SELECT 'TIPOCUENTAS', COUNT(*) FROM TIPOCUENTAS UNION ALL
SELECT 'TIPOTARJETA', COUNT(*) FROM TIPOTARJETA UNION ALL
SELECT 'TIPOSERVICIO', COUNT(*) FROM TIPOSERVICIO UNION ALL
SELECT 'TIPOSEGURO', COUNT(*) FROM TIPOSEGURO UNION ALL
SELECT 'TIPOTRANSACCION', COUNT(*) FROM TIPOTRANSACCION UNION ALL
SELECT 'TIPOREMESA', COUNT(*) FROM TIPOREMESA UNION ALL
SELECT 'TIPONOTIFICACION', COUNT(*) FROM TIPONOTIFICACION;

-- Consulta detallada por cada tabla
-- TIPOCLIENTE
SELECT * FROM TIPOCLIENTE ORDER BY id;

-- TIPOCUENTAS
SELECT * FROM TIPOCUENTAS ORDER BY id;

-- TIPOTARJETA
SELECT * FROM TIPOTARJETA ORDER BY id;

-- TIPOSERVICIO
SELECT * FROM TIPOSERVICIO ORDER BY id;

-- TIPOSEGURO
SELECT * FROM TIPOSEGURO ORDER BY id;

-- TIPOTRANSACCION
SELECT * FROM TIPOTRANSACCION ORDER BY id;

-- TIPOREMESA
SELECT * FROM TIPOREMESA ORDER BY id;

-- TIPONOTIFICACION
SELECT * FROM TIPONOTIFICACION ORDER BY id;

-- INFOCLIENTE
SELECT * FROM INFOCLIENTE ORDER BY id;

-- ACCESOS
SELECT * FROM ACCESOS ORDER BY id;

-- Consultas para tablas principales con relaciones
-- CLIENTE con información relacionada
SELECT c.id, c.nombre, c.apellido, c.fecha_nacimiento, 
       tc.nombre as tipo_cliente,
       ic.telefono, ic.correo
FROM CLIENTE c
JOIN TIPOCLIENTE tc ON c.id_tipo_cliente = tc.id
JOIN INFOCLIENTE ic ON c.id_info_cliente = ic.id
ORDER BY c.id;

-- CUENTA con tipo de cuenta
SELECT c.id, c.numero_cuenta, c.MontoApertura, c.Saldo, c.fecha_apertura,
       tc.nombre as tipo_cuenta,
       cl.nombre || ' ' || cl.apellido as nombre_cliente
FROM CUENTA c
JOIN TIPOCUENTAS tc ON c.id_tipo_cuenta = tc.id
JOIN CLIENTE cl ON c.id_cliente = cl.id
ORDER BY c.id;

-- TARJETA con tipo y cliente
SELECT t.id, t.tipo, t.Numero_Tarjeta, t.moneda, t.monto_limite,
       tt.nombre as tipo_tarjeta,
       c.nombre || ' ' || c.apellido as nombre_cliente
FROM TARJETA t
JOIN TIPOTARJETA tt ON t.id_tipo_tarjeta = tt.id
JOIN CLIENTE c ON t.id_cliente = c.id
ORDER BY t.id;

-- SERVICIO con tipo
SELECT s.*, ts.nombre as tipo_servicio
FROM SERVICIO s
JOIN TIPOSERVICIO ts ON s.id_tipo_servicio = ts.id
ORDER BY s.id;

-- TIPOPREMIO
SELECT tp.*, c.nombre || ' ' || c.apellido as nombre_cliente
FROM TIPOPREMIO tp
JOIN CLIENTE c ON tp.id_cliente = c.id
ORDER BY tp.id;

-- NOTIFICACION
SELECT n.*, tn.nombre as tipo_notificacion,
       c.nombre || ' ' || c.apellido as nombre_cliente
FROM NOTIFICACION n
JOIN TIPONOTIFICACION tn ON n.id_tipo_notificacion = tn.id
JOIN CLIENTE c ON n.id_cliente = c.id
ORDER BY n.id;

-- PRODUCTO_SERVICIO
SELECT ps.*, 
       c.nombre || ' ' || c.apellido as nombre_cliente,
       s.nombre as servicio
FROM PRODUCTO_SERVICIO ps
JOIN CLIENTE c ON ps.id_cliente = c.id
JOIN SERVICIO s ON ps.id_servicio = s.id
ORDER BY ps.id;

-- SEGURO
SELECT * FROM SEGURO ORDER BY id;

-- TRANSACCION
SELECT t.*, 
       tt.nombre as tipo_transaccion,
       c.nombre || ' ' || c.apellido as nombre_cliente,
       co.numero_cuenta as cuenta_origen,
       cd.numero_cuenta as cuenta_destino
FROM TRANSACCION t
JOIN TIPOTRANSACCION tt ON t.id_tipotrans = tt.id
JOIN CLIENTE c ON t.id_cliente = c.id
JOIN CUENTA co ON t.id_cuenta_origen = co.id
JOIN CUENTA cd ON t.id_cuenta_destino = cd.id
ORDER BY t.id;

-- PRESTAMO
SELECT p.*, 
       c.nombre || ' ' || c.apellido as nombre_cliente
FROM PRESTAMO p
JOIN CLIENTE c ON p.id_cliente = c.id
ORDER BY p.id;

-- REMESA
SELECT r.*, 
       tr.nombre as tipo_remesa,
       c.nombre || ' ' || c.apellido as nombre_cliente,
       cu.numero_cuenta as cuenta
FROM REMESA r
JOIN TIPOREMESA tr ON r.id_tipo_remesa = tr.id
JOIN CLIENTE c ON r.id_cliente = c.id
JOIN CUENTA cu ON r.id_tipo_cuenta = cu.id
ORDER BY r.id;