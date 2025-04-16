# Normalización Proyecto 2

## Tipo de cliente:
|ID|NOMBRE|DESCRIPCCION|
|:---:|:---:|:----:|
|number|varchar(25)|Text|

## Tipo de cuenta:
|ID|NOMBRE|DESCRIPCCION|
|:---:|:---:|:----:|
|number|varchar(35)|Text|

## Tipo de tarjeta
|ID|NOMBRE|
|:---:|:---:|
|number|varchar(20)|

## Tipo de servicio:
|ID|TIPO|NOMBRE|MONTO|
|:---:|:---:|:---:|:---:|
|number|FK|varchar(40)|varchar(10)|

 * ### Tipo de pago:
    |ID|NOMBRE|
    |:---:|:---:|
    |number|varchar(10)|

## Tipo de seguro:
|ID|NOMBRE|
|:---:|:---:|
|number|varchar(20)|

## Tipo de transacción:
|ID|NOMBRE|
|:---:|:---:|
|number|varchar(30)|

## Tipo de remesa:
|ID|NOMBRE|
|:---:|:---:|
|NUMBER|VARCHAR(10)|

## Tipo de premio:
|ID|ID_CLIENTE|NOMBRE|DESCRIPCCION|
|:---:|:---:|:----:|:----:|
|number|FK|varchar(25)|Text|

## Tipo de notificación:
|ID|NOMBRE|
|:---:|:---:|
|NUMBER|VARCHAR(10)|

## Notificaciones:
|ID|ID_CLIENTE|ID_TIPO_NOTIFICACION|NOMBRE|
|:---:|:---:|:----:|:----:|
|NUMBER|FK|FK|varchar(30)|

## Cliente:
|ID|ID_INFO_CLIENTE|ID_TIPO_CLIENTE|NOMBRE|APELLIDO|FECHA_NACIMIENTO|
|:---:|:---:|:----:|:----:|:----:|:----:|
|number|FK|FK|varchar(50)|varchar(50)|DATE

* ### Info cliente:
    |ID|TELEFONO|CORREO|USUSARIO|CONTRASEÑA|
    |:---:|:---:|:----:|:----:|:----:|
    |number|varchar(12)|varchar(50)|varchar(50)|varchar(100)|

## Cuenta:
|ID|ID_TIPO_CUENTA|ID_CLIENTE|NUMERO DE CUENTA|MONTO_APERTURA|SALDO_CUENTA|FECHA_APERTURA|DETALLES
|:---:|:---:|:-----:|:-----:|:----:|:----:|:----:|:----:|
|number|FK|FK|number|Number(16,0)|Decimal|Decimal|DATETIME|varchar(100)|

## Tarjeta:
|ID|ID_CLIENTE|ID_TIPO_TARJETA|TIPO|NUMERO_TARJETA|MONEDA|MONTO_LIMITE|DIA_CORTE|DIA_PAGO|TASA_INTERES|FECHA_EXP|
|:---:|:---:|:-----:|:-----:|:----:|:----:|:----:|:----:|:----:|:----:|:----:|
|number|FK|FK|CHAR|number(16,0)|CHAR|Decimal|number|number|number|SysDate + 5 años|

## Producto/servicio:
|ID|ID_CLIENTE|ID_TIPO_SERVICIO|
|:---:|:---:|:-----:|
|number|FK(JOIN)|FK|

## Seguro:
|ID|ID_TIPO_SEGURO|ID_CLIENTE|MONTO_ASEGURADO|VALOR_SEGURO|CANTIDAD PAGOS|MESES_ASEGURADOS|CONTRATACION|VENCIMIENTO|
|:---:|:---:|:-----:|:-----:|:----:|:----:|:----:|:----:|:----:|
|number|FK|FK|Decimal|Decimal|Number|Integer|DATE|DATE+MESES|

## Transaccion:
|ID|ID_TIPO_TRANSACCION|ID_CLIENTE|ID_CUENTA(ORIGEN)|ID_CUENTA(DESTINO)|
|:---:|:---:|:-----:|:-----:|:----:|
|number|FK|FK|FK|FK|

## Prestamo:
|ID|ID_CLIENTE|MONTO_PRESTAMO|TASA_INTERES|MESES|CONTRATACION|VENCIMIENTO|
|:---:|:---:|:-----:|:-----:|:----:|:----:|:----:|
|number|FK|Decimal|Decimal|Integer|DATE|DATE+MESES|

## Remesas:
|ID|ID_CLIENTE|ID_TIPO_REMESAS|ID_CUENTA|PAIS|FECHA|
|:---:|:---:|:-----:|:-----:|:----:|:----:|
|number|FK|FK|FK|varchar(10)|DATE

## Accesos:
Esta tabla es ajena a la base de datos, es únicamente para manejar los accesos de cada integrante del grupo

|ID|USUSARIO|CONTRASEÑA|
|:---:|:---:|:-----:|
|number|varchar(15)|varchar(100)|