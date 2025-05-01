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
CREATE TABLE CUENTA(
    id NUMBER PRIMARY KEY,
    numero_cuenta NUMBER(16,0) NOT NULL, --Generar random no repetible
    MontoApertura DECIMAL NOT NULL,
    Saldo DECIMAL NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    fecha_apertura TIMESTAMP NOT NULL,
    id_tipo_cuenta NUMBER NOT NULL REFERENCES TIPOCUENTAS(id),
    id_cliente NUMBER NOT NULL REFERENCES CLIENTE(id),
    detalles_extra VARCHAR(100),
    creation DATE DEFAULT SYSDATE,
    Data_Update DATE DEFAULT SYSDATE
);
CREATE SEQUENCE seq_cuenta START WITH 1 INCREMENT BY 1;
*/
-- sp_register_new_account(montoApertura, saldoCuenta, Descripcion, FechaApertura, TipoCuenta, idCliente, otrosDetalles)
CREATE OR REPLACE PROCEDURE sp_register_new_account(
    p_monto_apertura IN DECIMAL,
    p_saldo IN DECIMAL,
    p_descripcion IN VARCHAR2,
    p_fecha_apertura IN TIMESTAMP,
    p_id_tipo_cuenta IN NUMBER,
    p_id_cliente IN NUMBER,
    P_detalles_extra IN VARCHAR2 DEFAULT NULL
)AS
BEGIN
    -- sp_register_new_account(1000, 1000, 'Cuenta', SYSTIMESTAMP, 1, 1, 'Cuenta de ahorro personal de Juan Pérez'); -- id debe ser 1
    INSERT INTO CUENTA (id, MontoApertura, Saldo, descripcion, fecha_apertura, id_tipo_cuenta, id_cliente, detalles_extra)
    VALUES (seq_cuenta.NEXTVAL, p_monto_apertura, p_saldo,  p_descripcion, p_fecha_apertura, p_id_tipo_cuenta, p_id_cliente, p_detalles_extra);
    COMMIT;
END;
/

/*
CREATE TABLE TARJETA(
    id NUMBER PRIMARY KEY,
    tipo CHAR NOT NULL,
    Numero_Tarjeta NUMBER(16,0) NOT NULL,
    moneda CHAR NOT NULL,
    monto_limite DECIMAL NOT NULL,
    Dia_corte NUMBER,
    Dia_pago NUMBER,
    Tasa_interes DECIMAL NOT NULL,
    fecha_expedicion TIMESTAMP NOT NULL,
    id_cliente NUMBER NOT NULL REFERENCES CLIENTE(id),
    id_tipo_tarjeta NUMBER NOT NULL REFERENCES TIPOTARJETA(id)
);
*/

-- sp_register_new_card(idCliente, idTipoTarjeta, Tipo, NumeroTarjeta, Moneda, MontoLimite, DiaCorte, DiaPago, TasaInteres, FechaExpiracion)
CREATE OR REPLACE PROCEDURE sp_register_new_card(
    p_id_cliente IN NUMBER,
    p_id_tipo_tarjeta IN NUMBER,
    p_tipo IN CHAR,
    p_numero_tarjeta IN NUMBER,
    p_moneda IN CHAR,
    p_monto_limite IN DECIMAL,
    p_dia_corte IN NUMBER,
    p_dia_pago IN NUMBER,
    p_tasa_interes IN DECIMAL,
    p_fecha_expedicion IN VARCHAR
) AS
    v_fecha DATE;
BEGIN
     IF LENGTH(TO_CHAR(p_numero_tarjeta)) != 16 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El número de tarjeta debe tener 16 dígitos');
    END IF;

    v_fecha := TO_DATE(p_fecha_expedicion, 'DD-MM-YYYY');
    -- sp_register_new_card(1, 1, 'C', 1234567823458765, 'Q', 10000, 17, 12, 5, '24-04-2029'); -- id debe ser 1
    INSERT INTO TARJETA (id, id_cliente, id_tipo_tarjeta, tipo, Numero_Tarjeta, moneda, monto_limite, Dia_corte, Dia_pago, Tasa_interes, fecha_expedicion)
    VALUES (seq_tarjeta.NEXTVAL,  p_id_cliente, p_id_tipo_tarjeta, p_tipo, p_numero_tarjeta, p_moneda, p_monto_limite, p_dia_corte, p_dia_pago, p_tasa_interes, v_fecha);
    COMMIT;
END;
/




/*
DROP PROCEDURE sp_register_new_type_client;
DROP PROCEDURE sp_register_new_type_account;
DROP PROCEDURE sp_register_new_client;
DROP PROCEDURE sp_register_new_account;
DROP PROCEDURE sp_register_new_card;
*/


