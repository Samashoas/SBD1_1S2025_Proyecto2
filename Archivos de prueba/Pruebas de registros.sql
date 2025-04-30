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
