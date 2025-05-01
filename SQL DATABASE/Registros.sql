/*
CREATE TABLE TIPOCLIENTE(
    id NUMBER PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR2(500) NOT NULL
);
*/

CREATE OR REPLACE PROCEDURE sp_register_new_type_client(
    p_nombre IN VARCHAR,
    p_descripcion IN VARCHAR2
) AS
BEGIN
    INSERT INTO TIPOCLIENTE (id, nombre, descripcion)
    VALUES (seq_tipo_cliente.NEXTVAL, p_nombre, p_descripcion);
    COMMIT;
END;
/
/*
CREATE TABLE TIPOCUENTAS(
    id NUMBER PRIMARY KEY,
    nombre VARCHAR(35) NOT NULL,
    descripcion VARCHAR2(105) NOT NULL 
);
*/

CREATE OR REPLACE PROCEDURE sp_register_new_type_account(
    p_nombre IN VARCHAR,
    p_descripcion IN VARCHAR2
)AS
BEGIN
    INSERT INTO TIPOCUENTAS (id, nombre, descripcion)
    VALUES (seq_tipo_cuenta.NEXTVAL, p_nombre, p_descripcion);
    COMMIT;
END;
/

/*
DROP PROCEDURE sp_register_new_type_client;
DROP PROCEDURE sp_register_new_type_account;
*/