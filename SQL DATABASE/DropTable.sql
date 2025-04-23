/*
Utilizar SOLO EN CASO DE EMERGENCIA
SE ELIMINAN TODAS LAS TABLAS DEL ESQUEMA ACTUAL
*/

BEGIN
   FOR cur_rec IN (SELECT table_name FROM user_tables) LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE ' || cur_rec.table_name || ' CASCADE CONSTRAINTS';
      EXCEPTION
         WHEN OTHERS THEN NULL;
      END;
   END LOOP;
END;
/

BEGIN 
   FOR seq_rec IN (SELECT sequence_name FROM user_sequences) LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seq_rec.sequence_name;
         DBMS_OUTPUT.PUT_LINE('Secuencia eliminada ' || seq_rec.sequence_name );
      EXCEPTION
         WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error al eliminar secuencia ' || seq_rec.sequence_name || ': ' || SQLERRM);
         END;
   END LOOP;
END;
/