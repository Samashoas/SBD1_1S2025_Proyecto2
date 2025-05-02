BEGIN
    --REGISTRAR NUEVO TIPO DE CLIENTE
sp_register_new_type_client('Individual Nacional', 'Este tipo de cliente es una persona individual de nacionalidad guatemalteca.'); -- id debe ser 1
sp_register_new_type_client('Individual Extranjero', 'Este tipo de cliente es una persona individual de nacionalidad extranjera.'); -- id debe ser 2
sp_register_new_type_client('Empresa Pyme', 'Este tipo de cliente es una empresa de tipo pequeña o mediana.'); -- -- id debe ser 3
sp_register_new_type_client('Empresa S.C', 'Este tipo de cliente corresponde a las empresa grandes que tienen una sociedad colectiva.'); -- -- id debe ser 4
sp_register_new_type_client('Cuenta del banco', 'Este tipo de cliente corresponde a una cuenta del banco.'); -- -- id debe ser 5
END;
/

BEGIN 
sp_register_new_type_account('Cuenta Ahorro', 'Esta cuenta genera un interés anual de dos porciento'); -- id debe ser 1
sp_register_new_type_account('Cuenta Ahorro Plus', 'Esta cuenta genera un interés anual del tres punto cinco porciento'); -- id debe ser 2
sp_register_new_type_account('Cuenta Monetaria', 'Diseñada para recibir depósitos de sueldo y realizar pagos.'); -- id debe ser 3
sp_register_new_type_account('Cuenta Ahorro Empresarial', 'Esta cuenta genera un interés anual de tres porciento'); -- id debe ser 4
sp_register_new_type_account('Cuenta Ahorro Empresarial Plus', 'Esta cuenta genera un interés anual de cinco porciento'); -- id debe ser 5
END;
/

BEGIN
sp_register_new_client('Juan', 'Pérez', '+50212345678','perezjuan@google.com', '24-04-1997', 'juanito', ' segura1234', 1); -- id debe ser 1
sp_register_new_client('María', 'García', '+50287654321', 'margarcia@google.com', '15-08-1995', 'mariagarcia', ' segura1234', 2); -- id debe ser 2
sp_register_new_client('Carlos', 'López', '+50223456789', 'calopes@microsoft.com', '10-12-1988', 'carlitos', ' segura1234', 1); -- id debe ser 3
sp_register_new_client('Ana', 'Martínez', '+50234567890', 'amartine@apple.com', '05-03-1990', 'anita', ' segura1234', 2); -- id debe ser 4
sp_register_new_client('Pedro', 'Ramírez', '+50245678901', 'perami@google.com', '20-07-1985', 'pedrito', ' segura1234', 3); -- id debe ser 5
sp_register_new_client('Laura', 'Hernández', '+50256789012', 'laudez@microsoft.com', '30-11-1992', 'laurita', ' segura1234', 3); -- id debe ser 6
sp_register_new_client('Empresa ', 'Banco', '+50267890123', 'banco@banco.com', '01-01-1980', 'banco', ' segura1234', 5); -- id debe ser 7
sp_register_new_client('Empresa ', 'EEGSA', '+50278901234', 'eggsa@eggsa.com', '24-04-1990', 'eggsa', ' segura1234', 4); -- id debe ser 8
sp_register_new_client('Empresa ', 'Empagua', '+50278901234', 'empagua@empagua.com', '24-04-1990', 'empagua', ' segura1234', 4); -- id debe ser 9
sp_register_new_client('Universidad ', 'USAC', '+50278901234', 'usac@usac.com', '24-04-1990', 'usac', ' segura1234', 4); -- id debe ser 10
END;
/

BEGIN
sp_register_new_account(1000, 1000, 'Cuenta', SYSTIMESTAMP, 1, 1, 'Cuenta de ahorro personal de Juan Pérez'); -- id debe ser 1
sp_register_new_account(2000, 2000, 'Cuenta', SYSTIMESTAMP, 2, 2, 'Cuenta de ahorro personal de María García'); -- id debe ser 2
sp_register_new_account(3000, 3000, 'Cuenta', SYSTIMESTAMP, 3, 3, 'Cuenta de ahorro personal de Carlos López'); -- id debe ser 3
sp_register_new_account(4000, 4000, 'Cuenta', SYSTIMESTAMP, 4, 4, 'Cuenta de ahorro personal de Ana Martínez'); -- id debe ser 4
sp_register_new_account(5000, 5000, 'Cuenta', SYSTIMESTAMP, 5, 7, 'Cuenta de ahorro personal de Banco'); -- id debe ser 5
sp_register_new_account(6000, 6000, 'Cuenta', SYSTIMESTAMP, 1, 5, 'Cuenta de ahorro personal de Laura Hernández'); -- id debe ser 6
sp_register_new_account(8000, 8000, 'Cuenta', SYSTIMESTAMP, 3, 1, 'Cuenta de ahorro personal de Juan Pérez'); -- id debe ser 7
sp_register_new_account(9000, 9000, 'Cuenta', SYSTIMESTAMP, 4, 2, 'Cuenta de ahorro personal de María García'); -- id debe ser 8
sp_register_new_account(10000, 10000, 'Cuenta', SYSTIMESTAMP, 4, 3, 'Cuenta de ahorro personal de Carlos López'); -- id debe ser 9
sp_register_new_account(11000, 11000, 'Cuenta', SYSTIMESTAMP, 1, 4, 'Cuenta de ahorro personal de Ana Martínez'); -- id debe ser 10
sp_register_new_account(12000, 12000, 'Cuenta', SYSTIMESTAMP, 2, 5, 'Cuenta de ahorro personal de Pedro Ramírez'); -- id debe ser 11
sp_register_new_account(13000, 13000, 'Cuenta', SYSTIMESTAMP, 5, 8, 'Cuenta de ahorro personal de EEGSA'); -- id debe ser 12
sp_register_new_account(14000, 14000, 'Cuenta', SYSTIMESTAMP, 5, 9, 'Cuenta de ahorro personal de Empagua'); -- id debe ser 13
sp_register_new_account(15000, 15000, 'Cuenta', SYSTIMESTAMP, 5, 10, 'Cuenta de ahorro personal de USAC'); -- id debe ser 14
END;
/

BEGIN
sp_register_new_card(2, 1, 'C', 1234567823458766, 'Q', 20000, 19, 14, 4, '15-08-2028'); -- id debe ser 2
sp_register_new_card(3, 1, 'C', 1234567823458767, 'Q', 30000, 21, 16, 3, '10-12-2027'); -- id debe ser 3
sp_register_new_card(4, 2, 'C', 1234567823458768, 'Q', 40000, 23, 18, 2, '05-03-2026'); -- id debe ser 4
sp_register_new_card(8, 2, 'C', 1234567823458769, 'Q', 50000, 25, 20, 1, '20-07-2025'); -- id debe ser 5
sp_register_new_card(6, 3, 'C', 1234567823458770, 'Q', 60000, 27, 22, 5, '30-11-2024'); -- id debe ser 6
sp_register_new_card(1, 3, 'D', 1234567823458771, 'Q', 70000, 29, 24, 0, '01-01-2023'); -- id debe ser 7 y relacionar con una cuenta
sp_register_new_card(2, 1, 'D', 1234567823458772, 'Q', 80000, 31, 26, 0, '24-04-2022'); -- id debe ser 8 y relacionar con una cuenta
sp_register_new_card(3, 1, 'D', 1234567823458773, 'Q', 90000, 2, 28, 0, '15-08-2021'); -- id debe ser 9 y relacionar con una cuenta
sp_register_new_card(4, 2, 'D', 1234567823458774, 'Q', 100000, 4, 30, 0, '10-12-2020'); -- id debe ser 10 y relacionar con una cuenta
sp_register_new_card(8, 2, 'D', 1234567823458775, 'Q', 110000, 6, 1, 0, '05-03-2019'); -- id debe ser 11 y relacionar con una cuenta
sp_register_new_card(6, 3, 'D', 1234567823458776, 'Q', 120000, 8, 3, 0, '20-07-2018'); -- id debe ser 12 y relacionar con una cuenta
END;
/

/*
sp_register_new_card(1, 1, 'C', 1234567823458765, 'Q', 10000, 17, 12, 5, '24-04-2029'); -- id debe ser 1
*/