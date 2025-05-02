-- Inserts para TIPOCLIENTE
INSERT INTO TIPOCLIENTE (id, nombre, descripcion) VALUES (1, 'Cliente Regular', 'Cliente con servicios básicos bancarios');
INSERT INTO TIPOCLIENTE (id, nombre, descripcion) VALUES (2, 'Cliente Premium', 'Cliente con beneficios especiales y atención preferencial');
INSERT INTO TIPOCLIENTE (id, nombre, descripcion) VALUES (3, 'Cliente Empresarial', 'Cliente con servicios especializados para empresas');

-- Inserts para TIPOCUENTAS
INSERT INTO TIPOCUENTAS (id, nombre, descripcion) VALUES (1, 'Cuenta de Ahorro', 'Cuenta para ahorrar dinero con intereses');
INSERT INTO TIPOCUENTAS (id, nombre, descripcion) VALUES (2, 'Cuenta Corriente', 'Cuenta para transacciones diarias');
INSERT INTO TIPOCUENTAS (id, nombre, descripcion) VALUES (3, 'Cuenta Premium', 'Cuenta con beneficios especiales');

-- Inserts para TIPOTARJETA
INSERT INTO TIPOTARJETA (id, nombre) VALUES (1, 'Débito Clásica');
INSERT INTO TIPOTARJETA (id, nombre) VALUES (2, 'Crédito Oro');
INSERT INTO TIPOTARJETA (id, nombre) VALUES (3, 'Crédito Platinum');

-- Inserts para TIPOSERVICIO
INSERT INTO TIPOSERVICIO (id, nombre) VALUES (1, 'Préstamo');
INSERT INTO TIPOSERVICIO (id, nombre) VALUES (2, 'Seguro');
INSERT INTO TIPOSERVICIO (id, nombre) VALUES (3, 'Inversión');

-- Inserts para TIPOSEGURO
INSERT INTO TIPOSEGURO (id, nombre) VALUES (1, 'Seguro de Vida');
INSERT INTO TIPOSEGURO (id, nombre) VALUES (2, 'Seguro de Vivienda');
INSERT INTO TIPOSEGURO (id, nombre) VALUES (3, 'Seguro de Vehículo');

-- Inserts para TIPOTRANSACCION
INSERT INTO TIPOTRANSACCION (id, nombre) VALUES (1, 'Depósito');
INSERT INTO TIPOTRANSACCION (id, nombre) VALUES (2, 'Retiro');
INSERT INTO TIPOTRANSACCION (id, nombre) VALUES (3, 'Transferencia');

-- Inserts para TIPOREMESA
INSERT INTO TIPOREMESA (id, nombre) VALUES (1, 'Nacional');
INSERT INTO TIPOREMESA (id, nombre) VALUES (2, 'Externa');

-- Inserts para TIPONOTIFICACION
INSERT INTO TIPONOTIFICACION (id, nombre) VALUES (1, 'SMS');
INSERT INTO TIPONOTIFICACION (id, nombre) VALUES (2, 'Email');
INSERT INTO TIPONOTIFICACION (id, nombre) VALUES (3, 'Push');

-- Limpieza previa de la tabla
DELETE FROM INFOCLIENTE;

-- Inserts para INFOCLIENTE con formato estricto de Oracle
INSERT INTO INFOCLIENTE (id, telefono, correo, usuario, pass) 
    VALUES (1, '502-1234-567', 'juan.perez@email.com', 'jperez', 'password123');
INSERT INTO INFOCLIENTE (id, telefono, correo, usuario, pass) 
    VALUES (2, '502-8765-432', 'maria.garcia@email.com', 'mgarcia', 'password456');
INSERT INTO INFOCLIENTE (id, telefono, correo, usuario, pass) 
    VALUES (3, '502-9876-543', 'pedro.lopez@email.com', 'plopez', 'password789');

-- Inserts para CLIENTE
INSERT INTO CLIENTE (id, nombre, apellido, fecha_nacimiento, id_tipo_cliente, id_info_cliente) 
VALUES (1, 'Juan', 'Pérez', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 1, 1);
INSERT INTO CLIENTE (id, nombre, apellido, fecha_nacimiento, id_tipo_cliente, id_info_cliente) 
VALUES (2, 'María', 'García', TO_DATE('1985-08-20', 'YYYY-MM-DD'), 2, 2);
INSERT INTO CLIENTE (id, nombre, apellido, fecha_nacimiento, id_tipo_cliente, id_info_cliente) 
VALUES (3, 'Pedro', 'López', TO_DATE('1978-11-30', 'YYYY-MM-DD'), 3, 3);

-- Inserts para CUENTA
INSERT INTO CUENTA (id, numero_cuenta, MontoApertura, Saldo, fecha_apertura, id_tipo_cuenta, id_cliente)
VALUES (1, 1234567890123456, 1000.00, 1500.00, SYSTIMESTAMP, 1, 1);
INSERT INTO CUENTA (id, numero_cuenta, MontoApertura, Saldo, fecha_apertura, id_tipo_cuenta, id_cliente)
VALUES (2, 9876543210987654, 5000.00, 7500.00, SYSTIMESTAMP, 2, 2);
INSERT INTO CUENTA (id, numero_cuenta, MontoApertura, Saldo, fecha_apertura, id_tipo_cuenta, id_cliente)
VALUES (3, 4567890123456789, 10000.00, 15000.00, SYSTIMESTAMP, 3, 3);

-- Inserts para TARJETA
INSERT INTO TARJETA (id, tipo, Numero_Tarjeta, moneda, monto_limite, Dia_corte, Dia_pago, Tasa_interes, fecha_expedicion, id_cliente, id_tipo_tarjeta)
VALUES (1, 'D', 4532789456123456, 'Q', 5000.00, NULL, NULL, 0, SYSTIMESTAMP, 1, 1);
INSERT INTO TARJETA (id, tipo, Numero_Tarjeta, moneda, monto_limite, Dia_corte, Dia_pago, Tasa_interes, fecha_expedicion, id_cliente, id_tipo_tarjeta)
VALUES (2, 'C', 4532789456123457, 'Q', 25000.00, 1, 15, 0.15, SYSTIMESTAMP, 2, 2);
INSERT INTO TARJETA (id, tipo, Numero_Tarjeta, moneda, monto_limite, Dia_corte, Dia_pago, Tasa_interes, fecha_expedicion, id_cliente, id_tipo_tarjeta)
VALUES (3, 'C', 4532789456123458, 'Q', 50000.00, 5, 20, 0.12, SYSTIMESTAMP, 3, 3);

-- Inserts para SERVICIO
INSERT INTO SERVICIO (id, nombre, monto, id_tipo_servicio) VALUES (1, 'Préstamo Personal', 10000.00, 1);
INSERT INTO SERVICIO (id, nombre, monto, id_tipo_servicio) VALUES (2, 'Seguro de Vida Básico', 500.00, 2);
INSERT INTO SERVICIO (id, nombre, monto, id_tipo_servicio) VALUES (3, 'Inversión a Plazo Fijo', 25000.00, 3);

-- Inserts para TIPOPREMIO
INSERT INTO TIPOPREMIO (id, nombre, descripcion, id_cliente)
VALUES (1, 'Cashback', 'Devolución del 2% en compras', 1);
INSERT INTO TIPOPREMIO (id, nombre, descripcion, id_cliente)
VALUES (2, 'Millas', 'Acumulación de millas por compras', 2);
INSERT INTO TIPOPREMIO (id, nombre, descripcion, id_cliente)
VALUES (3, 'Puntos', 'Puntos canjeables por productos', 3);

-- Inserts para ACCESOS
INSERT INTO ACCESOS (id, nombre, pass) VALUES (1, 'admin', 'admin123');
INSERT INTO ACCESOS (id, nombre, pass) VALUES (2, 'supervisor', 'super456');
INSERT INTO ACCESOS (id, nombre, pass) VALUES (3, 'operador', 'oper789');

-- Inserts para NOTIFICACION
INSERT INTO NOTIFICACION (id, nombre, id_cliente, id_tipo_notificacion)
VALUES (1, 'Alerta de depósito', 1, 1);
INSERT INTO NOTIFICACION (id, nombre, id_cliente, id_tipo_notificacion)
VALUES (2, 'Aviso de pago', 2, 2);
INSERT INTO NOTIFICACION (id, nombre, id_cliente, id_tipo_notificacion)
VALUES (3, 'Notificación de transferencia', 3, 3);

-- Inserts para PRODUCTO_SERVICIO (modificado para incluir fecha_contratacion)
INSERT INTO PRODUCTO_SERVICIO (id, id_cliente, id_servicio, fecha_contratacion)
VALUES (1, 1, 1, SYSDATE);
INSERT INTO PRODUCTO_SERVICIO (id, id_cliente, id_servicio, fecha_contratacion)
VALUES (2, 2, 2, SYSDATE);
INSERT INTO PRODUCTO_SERVICIO (id, id_cliente, id_servicio, fecha_contratacion)
VALUES (3, 3, 3, SYSDATE);

-- Inserts para SEGURO
INSERT INTO SEGURO (id, monto_asegurado, valor_seguro, cantidad_pagos, meses_asegurado, contratacion, fecha_vencimiento, id_tipo_seguro, id_cliente)
VALUES (1, 100000.00, 500.00, 12, 12, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2025-12-31', 'YYYY-MM-DD'), 1, 1);
INSERT INTO SEGURO (id, monto_asegurado, valor_seguro, cantidad_pagos, meses_asegurado, contratacion, fecha_vencimiento, id_tipo_seguro, id_cliente)
VALUES (2, 250000.00, 1200.00, 24, 24, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2026-12-31', 'YYYY-MM-DD'), 2, 2);
INSERT INTO SEGURO (id, monto_asegurado, valor_seguro, cantidad_pagos, meses_asegurado, contratacion, fecha_vencimiento, id_tipo_seguro, id_cliente)
VALUES (3, 500000.00, 2500.00, 36, 36, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2027-12-31', 'YYYY-MM-DD'), 3, 3);

-- Inserts para TRANSACCION (modificado para incluir fecha_inicial_transaccion)
INSERT INTO TRANSACCION (id, id_tipotrans, id_cliente, id_cuenta_origen, id_cuenta_destino, fecha_inicial_transaccion)
VALUES (1, 1, 1, 1, 2, SYSDATE);
INSERT INTO TRANSACCION (id, id_tipotrans, id_cliente, id_cuenta_origen, id_cuenta_destino, fecha_inicial_transaccion)
VALUES (2, 2, 2, 2, 3, SYSDATE);
INSERT INTO TRANSACCION (id, id_tipotrans, id_cliente, id_cuenta_origen, id_cuenta_destino, fecha_inicial_transaccion)
VALUES (3, 3, 3, 3, 1, SYSDATE);

-- Inserts para PRESTAMO
INSERT INTO PRESTAMO (id, monto_prestamo, tasa_interes, meses, contratacion, fecha_vencimiento, id_cliente)
VALUES (1, 10000.00, 0.15, 12, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2025-12-31', 'YYYY-MM-DD'), 1);
INSERT INTO PRESTAMO (id, monto_prestamo, tasa_interes, meses, contratacion, fecha_vencimiento, id_cliente)
VALUES (2, 25000.00, 0.12, 24, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2026-12-31', 'YYYY-MM-DD'), 2);
INSERT INTO PRESTAMO (id, monto_prestamo, tasa_interes, meses, contratacion, fecha_vencimiento, id_cliente)
VALUES (3, 50000.00, 0.10, 36, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2027-12-31', 'YYYY-MM-DD'), 3);

-- Inserts para REMESA
INSERT INTO REMESA (id, pais, fecha, id_cliente, id_tipo_remesa, id_tipo_cuenta)
VALUES (1, 'México', TO_DATE('2025-04-27', 'YYYY-MM-DD'), 1, 1, 1);
INSERT INTO REMESA (id, pais, fecha, id_cliente, id_tipo_remesa, id_tipo_cuenta)
VALUES (2, 'Estados Unidos', TO_DATE('2025-04-27', 'YYYY-MM-DD'), 2, 2, 2);
INSERT INTO REMESA (id, pais, fecha, id_cliente, id_tipo_remesa, id_tipo_cuenta)
VALUES (3, 'España', TO_DATE('2025-04-27', 'YYYY-MM-DD'), 3, 2, 3);

-- Commit para confirmar todos los cambios
COMMIT;