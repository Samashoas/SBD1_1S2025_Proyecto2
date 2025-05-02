-- Atributo faltante de fecha de contratacion para PRODUCTO_SERVICIO 

ALTER TABLE PRODUCTO_SERVICIO ADD fecha_contratacion DATE NOT NULL;

-- Trigger para manejar la fecha de contratacion de forma automática

CREATE OR REPLACE TRIGGER tg_atr_faltante_fecha_contratacion_ps

    BEFORE INSERT ON PRODUCTO_SERVICIO

    FOR EACH ROW
    
    BEGIN
    
      IF :NEW.fecha_contratacion IS NULL THEN
        :NEW.fecha_contratacion := SYSDATE;
    
      END IF;
  
    END;
/

-------------------------------------------------

-- Atributos y triggers para la fecha de creacion y modificacion de TRANSACCION

ALTER TABLE TRANSACCION ADD fecha_inicial_transaccion DATE NOT NULL;


CREATE OR REPLACE TRIGGER tg_atrf_fecha_inicial_transaccion

BEFORE INSERT ON TRANSACCION

    FOR EACH ROW

    BEGIN
      
      IF :NEW.fecha_inicial_transaccion IS NULL THEN
        :NEW.fecha_inicial_transaccion := SYSDATE;

      END IF;

    END;

/


ALTER TABLE TRANSACCION ADD fecha_modificacion_transaccion DATE;

CREATE OR REPLACE TRIGGER tg_atr_fecha_mod_transaccion

    BEFORE UPDATE OR INSERT ON TRANSACCION

    FOR EACH ROW

    BEGIN
      
      IF INSERTING THEN

        IF :NEW.fecha_inicial_transaccion IS NULL THEN
          :NEW.fecha_inicial_transaccion := SYSDATE;

        END IF;

        :NEW.fecha_modificacion_transaccion := :NEW.fecha_inicial_transaccion;
      
      END IF;

      IF UPDATING THEN

        :NEW.fecha_modificacion_transaccion := SYSDATE;

      END IF;
      
    END;
/

CREATE OR REPLACE TRIGGER tg_fecha_contratacion_prestamo
BEFORE INSERT ON PRESTAMO
FOR EACH ROW
BEGIN
    IF :NEW.contratacion IS NULL THEN
        :NEW.contratacion := SYSDATE;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER tg_fecha_vencimiento_prestamo
BEFORE INSERT ON PRESTAMO
FOR EACH ROW
BEGIN
    IF :NEW.fecha_vencimiento IS NULL THEN
        :NEW.fecha_vencimiento := ADD_MONTHS(SYSDATE, :NEW.meses);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER tg_fecha_contratacion_seguro
BEFORE INSERT ON SEGURO
FOR EACH ROW
BEGIN
    IF :NEW.contratacion IS NULL THEN
        :NEW.contratacion := SYSDATE;
    END IF;
END;
/