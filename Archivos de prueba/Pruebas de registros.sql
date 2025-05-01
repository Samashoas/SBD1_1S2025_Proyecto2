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