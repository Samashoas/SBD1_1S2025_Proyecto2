-- Inserts para NOTIFICACION
INSERT INTO NOTIFICACION (id, nombre, id_cliente, id_tipo_notificacion)
VALUES (1, 'Deposito', 1, 1);
INSERT INTO NOTIFICACION (id, nombre, id_cliente, id_tipo_notificacion)
VALUES (2, 'Aviso de pago', 2, 2);
INSERT INTO NOTIFICACION (id, nombre, id_cliente, id_tipo_notificacion)
VALUES (3, 'Aviso de transferencia', 3, 3);

-- Inserts para REMESA
INSERT INTO REMESA (id, pais, fecha, id_cliente, id_tipo_remesa, id_tipo_cuenta)
VALUES (1, 'Ialio', TO_DATE('2025-05-2', 'YYYY-MM-DD'), 1, 1, 1);
INSERT INTO REMESA (id, pais, fecha, id_cliente, id_tipo_remesa, id_tipo_cuenta)
VALUES (2, 'Estados Unidos', TO_DATE('2025-05-2', 'YYYY-MM-DD'), 2, 2, 2);
INSERT INTO REMESA (id, pais, fecha, id_cliente, id_tipo_remesa, id_tipo_cuenta)
VALUES (3, 'España', TO_DATE('2025-05-2', 'YYYY-MM-DD'), 3, 2, 3);



--TIPO DE PREMIO

INSERT INTO TIPOPREMIO (id, nombre, descripcion, id_cliente)
VALUES (1, 'Cashback', 'Devolución del 2% en compras', 1);
INSERT INTO TIPOPREMIO (id, nombre, descripcion, id_cliente)
VALUES (2, 'Millas', 'Acumulación de millas por compras', 2);
INSERT INTO TIPOPREMIO (id, nombre, descripcion, id_cliente)
VALUES (3, 'Puntos', 'Puntos canjeables por productos', 3);

COMMIT;