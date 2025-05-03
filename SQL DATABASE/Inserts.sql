
-- TIPOS DE TARJETA
INSERT INTO TIPOTARJETA (id, nombre) VALUES (1, 'Tarjeta Basica');
INSERT INTO TIPOTARJETA (id, nombre) VALUES (2, 'Tarjeta Plus');
INSERT INTO TIPOTARJETA (id, nombre) VALUES (3, 'Tarjeta Black');
 
-- TIPO DE REMASA (CAMBIAR)
INSERT INTO TIPOREMESA (id, nombre) VALUES (1, 'Nacional');
INSERT INTO TIPOREMESA (id, nombre) VALUES (2, 'Externa');

--TIPO DE NOTIFICACION
INSERT INTO TIPONOTIFICACION (id, nombre) VALUES (1, 'SMS');
INSERT INTO TIPONOTIFICACION (id, nombre) VALUES (2, 'Email');
INSERT INTO TIPONOTIFICACION (id, nombre) VALUES (3, 'Push');

--TIPO DE SERVICIO (REVISAR)
INSERT INTO TIPOSERVICIO (id, nombre) VALUES (1, 'Energía E');
INSERT INTO TIPOSERVICIO (id, nombre) VALUES (2, 'Agua P');
INSERT INTO TIPOSERVICIO (id, nombre) VALUES (3, 'Matrícula');
INSERT INTO TIPOSERVICIO (id, nombre) VALUES (4, 'Vacaciones');
INSERT INTO TIPOSERVICIO (id, nombre) VALUES (5, 'Seguro');
INSERT INTO TIPOSERVICIO (id, nombre) VALUES (6, 'P. tarjeta');
INSERT INTO TIPOSERVICIO (id, nombre) VALUES (7, 'Préstamo');
INSERT INTO TIPOSERVICIO (id, nombre) VALUES (8, 'T. débito');
INSERT INTO TIPOSERVICIO (id, nombre) VALUES (9, 'T.crédito');
INSERT INTO TIPOSERVICIO (id, nombre) VALUES (10, 'Chequera');



--TIPO SEGURO
INSERT INTO TIPOSEGURO (id, nombre) VALUES (1, 'Seguro Basico');
INSERT INTO TIPOSEGURO (id, nombre) VALUES (2, 'Seguro Regular');
INSERT INTO TIPOSEGURO (id, nombre) VALUES (3, 'Seguro Premium');
INSERT INTO TIPOSEGURO (id, nombre) VALUES (4, 'Seguro Platino');

--TIPO TRANSacccion (es clave) (REVISAR)
INSERT INTO TIPOTRANSACCION (id, nombre) VALUES (1, 'Débito');
INSERT INTO TIPOTRANSACCION (id, nombre) VALUES (2, 'Crédito');
INSERT INTO TIPOTRANSACCION (id, nombre) VALUES (3, 'Consumo con tarjeta');
INSERT INTO TIPOTRANSACCION (id, nombre) VALUES (4, 'Remesa');
INSERT INTO TIPOTRANSACCION (id, nombre) VALUES (5, 'Pago de servicio/producto');

/*
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
*/

COMMIT;