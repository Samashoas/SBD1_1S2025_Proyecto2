
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

--TIPO DE SERVICIO
INSERT INTO TIPOSERVICIO (id, nombre) VALUES (1, 'Préstamo');
INSERT INTO TIPOSERVICIO (id, nombre) VALUES (2, 'Seguro');
INSERT INTO TIPOSERVICIO (id, nombre) VALUES (3, 'Inversión');

--TIPO SEGURO
INSERT INTO TIPOSEGURO (id, nombre) VALUES (1, 'Seguro de Vida');
INSERT INTO TIPOSEGURO (id, nombre) VALUES (2, 'Seguro de Vivienda');
INSERT INTO TIPOSEGURO (id, nombre) VALUES (3, 'Seguro de Vehículo');

--TIPO TRANSacccion (es clave)
INSERT INTO TIPOTRANSACCION (id, nombre) VALUES (1, 'Depósito');
INSERT INTO TIPOTRANSACCION (id, nombre) VALUES (2, 'Retiro');
INSERT INTO TIPOTRANSACCION (id, nombre) VALUES (3, 'Transferencia');

--TIPO DE PREMIO
/*
INSERT INTO TIPOPREMIO (id, nombre, descripcion, id_cliente)
VALUES (1, 'Cashback', 'Devolución del 2% en compras', 1);
INSERT INTO TIPOPREMIO (id, nombre, descripcion, id_cliente)
VALUES (2, 'Millas', 'Acumulación de millas por compras', 2);
INSERT INTO TIPOPREMIO (id, nombre, descripcion, id_cliente)
VALUES (3, 'Puntos', 'Puntos canjeables por productos', 3);
*/
COMMIT;