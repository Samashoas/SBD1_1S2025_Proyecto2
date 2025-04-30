CREATE OR REPLACE TRIGGER trg_generate_numero_cuenta
BEFORE INSERT ON CUENTA
FOR EACH ROW
DECLARE
    v_count NUMBER;
    v_exists BOOLEAN := TRUE;
BEGIN
    WHILE v_exists LOOP
        :NEW.numero_cuenta := TRUNC(DBMS_RANDOM.VALUE(1000000000000000, 9999999999999999));
        
        -- Verificar si el número de cuenta ya existe
        SELECT COUNT(*) 
        INTO v_count 
        FROM CUENTA 
        WHERE numero_cuenta = :NEW.numero_cuenta;
        
        -- Si el contador es 0, no existe y podemos salir del bucle
        IF v_count = 0 THEN
            v_exists := FALSE;
        END IF;
    END LOOP;
END;
/

/*
DROP TRIGGER trg_generate_numero_cuenta;
*/