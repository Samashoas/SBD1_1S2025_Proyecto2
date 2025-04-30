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
CREATE TABLE CLIENTE(
    id NUMBER PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    id_tipo_cliente NUMBER NOT NULL REFERENCES TIPOCLIENTE(id),
    id_info_cliente NUMBER NOT NULL REFERENCES INFOCLIENTE(id),
    creation DATE DEFAULT SYSDATE,
    Data_Update DATE DEFAULT SYSDATE
);

CREATE TABLE INFOCLIENTE(
    id NUMBER PRIMARY KEY,
    telefono varchar(12) NOT NULL,
    correo varchar(50) NOT NULL,
    usuario varchar(50) NOT NULL,
    pass varchar(100) NOT NULL
);
*/

CREATE OR REPLACE PROCEDURE sp_register_new_client(
    p_nombre IN VARCHAR,
    p_apellido IN VARCHAR,
    p_telefono IN VARCHAR,
    p_correo IN VARCHAR,
    p_fecha_nacimiento IN VARCHAR,
    p_usuario IN VARCHAR,
    p_pass IN VARCHAR2,
    p_id_tipo_cliente IN NUMBER
) AS
    --v_id NUMBER;
    v_fecha DATE;
BEGIN
    v_fecha := TO_DATE(p_fecha_nacimiento, 'DD-MM-YYYY');
    -- v_id := seq_cliente.NEXTVAL;

    INSERT INTO INFOCLIENTE (id, telefono, correo, usuario, pass)
    VALUES (seq_info_cliente.NEXTVAL, p_telefono, p_correo, p_usuario, p_pass);
    
    INSERT INTO CLIENTE (id, nombre, apellido, fecha_nacimiento, id_tipo_cliente, id_info_cliente)
    VALUES (SEQ_CLIENTE.nextval, p_nombre, p_apellido, p_fecha_nacimiento, p_id_tipo_cliente, SEQ_CLIENTE.nextval);
    
    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
END;
/
/*
DROP PROCEDURE sp_register_new_type_client;
DROP PROCEDURE sp_register_new_type_account;
DROP PROCEDURE sp_register_new_client;
*/
