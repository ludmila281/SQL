-- Crear tabla de Documentos
CREATE TABLE DOCUMENTOS (
cod_documento INT PRIMARY KEY ,
descripcion VARCHAR (100));

INSERT INTO DOCUMENTOS (cod_documento , descripcion) VALUES (1, 'Dni');
INSERT INTO DOCUMENTOS (cod_documento , descripcion) VALUES (2, 'Pasaporte');
INSERT INTO DOCUMENTOS (cod_documento , descripcion) VALUES (3, 'Licencia de conducir');
INSERT INTO DOCUMENTOS (cod_documento, descripcion) VALUES (4, 'Cuil');
INSERT INTO DOCUMENTOS(cod_documento , descripcion) VALUES (5, 'Libreta');
INSERT INTO DOCUMENTOS (cod_documento , descripcion) VALUES (6, 'Cedula de identidad');





-- Crear tabla de Oficinas 
CREATE TABLE OFICINAS (
cod_oficina INT PRIMARY KEY ,
codigo_director INT ,
descripcion VARCHAR (100));

INSERT INTO oficinas (cod_oficina , codigo_director , descripcion) VALUES (1 , 101, 'Oficina Central');
INSERT INTO oficinas (cod_oficina , codigo_director , descripcion) VALUES (2 ,102 , 'Oficina De Ventas');
INSERT INTO oficinas (cod_oficina , codigo_director , descripcion) VALUES (3, 103, 'Oficina De Recursos Humanos');
INSERT INTO oficinas (cod_oficina , codigo_director , descripcion) VALUES (4 , 104 ,  'Oficina Técnica');
INSERT INTO oficinas (cod_oficina , codigo_director , descripcion) VALUES (5 , 105 , 'Oficina De Finanzas');
INSERT  INTO oficinas (cod_oficina , codigo_director , descripcion) VALUES (6 , 106 , 'Oficina de Logística');

-- consultas simples (una sola tabla)
SELECT DISTINCT descripcion 
FROM oficinas;

SELECT *
FROM oficinas;
WHERE codigo_director IS NULL;


-- Crear tabla de Empleados
CREATE TABLE EMPLEADOS (
cod_empleado INT PRIMARY KEY,
apellido VARCHAR (50),
nombre VARCHAR (50),
fecha_nacimiento DATE ,
num_doc VARCHAR (20),
cod_jefe INT,
cod_oficina INT,
cod_documento INT,
FOREIGN KEY (cod_jefe) REFERENCES EMPLEADOS (cod_empleado),
FOREIGN KEY (cod_oficina)REFERENCES OFICINAS (cod_oficina),
FOREIGN KEY (cod_documento)REFERENCES DOCUMENTOS (cod_documento));
ALTER TABLE EMPLEADOS ADD fecha_contratacion DATE;




INSERT INTO EMPLEADOS (cod_empleado , apellido , nombre , fecha_nacimiento , num_doc , cod_jefe , cod_oficina , cod_documento) VALUES (10 , 'GOMEZ' , 'MILU' , '1980-05-10' , '12345678' , NULL, 1, 1);
INSERT INTO EMPLEADOS (cod_empleado , apellido , nombre , fecha_nacimiento , num_doc , cod_jefe , cod_oficina , cod_documento) VALUES (11 , 'PEREZ' , 'FERNANDO' , '1985-03-22' , '23456789' , NULL , 1 , 2);
INSERT INTO EMPLEADOS (cod_empleado , apellido , nombre , fecha_nacimiento , num_doc , cod_jefe , cod_oficina , cod_documento) VALUES (12 , 'FERNANDEZ' , 'PAMELA' , '1990-11-15', '34567890' , NULL, 1 , 3);
INSERT INTO EMPLEADOS (cod_empleado , apellido , nombre , fecha_nacimiento , num_doc , cod_jefe , cod_oficina , cod_documento) VALUES (13 , 'RODRIGUEZ' , 'MARCELO' , '1978-07-05' , '45678901' , NULL , 1 , 4);
INSERT INTO EMPLEADOS (cod_empleado , apellido , nombre , fecha_nacimiento , num_doc , cod_jefe , cod_oficina , cod_documento) VALUES (14 , 'LOPÉZ' , 'AGUSTIN' , '1992-01-30' , '56789012' , NULL , 1 , 5);
UPDATE EMPLEADOS SET fecha_contratacion = '2005-06-01' WHERE cod_empleado = 10;
UPDATE EMPLEADOS SET fecha_contratacion = '2012-08-15' WHERE cod_empleado = 11;
UPDATE EMPLEADOS SET fecha_contratacion = '2018-09-01' WHERE cod_empleado = 12;
UPDATE EMPLEADOS SET fecha_contratacion = '2000-03-10' WHERE cod_empleado = 13;
UPDATE EMPLEADOS SET fecha_contratacion = '2020-02-20' WHERE cod_empleado = 14;

-- consultas simples (una sola tabla)
SELECT apellido,nombre,fecha_nacimiento
FROM EMPLEADOS;


SELECT *
FROM empleados 
WHERE cod_jefe IS NOT NULL;

SELECT *
FROM empleados
-- WHERE nombre = "maria"
ORDER BY apellido;

SELECT 
dc.cod_empleado,
dc.ventas
FROM 
datos_contratos dc
ORDER BY 
dc.ventas DESC 
LIMIT 3;
 

-- consulta multitabla
SELECT 
e.apellido,
dc.cuota,
o.descripcion AS oficina 
FROM empleados e
JOIN Datos_contratos dc ON e.cod_empleado = dc.cod_empleado
JOIN oficinas o ON e.cod_oficina = o.cod_oficina
ORDER BY dc.cuota DESC;

-- consulta multitabla 
SELECT cod_empleado , apellido , nombre , fecha_contratacion,
TIMESTAMPDIFF (YEAR , fecha_contratacion , CURDATE()) AS anios_contratado 
FROM empleados 
WHERE TIMESTAMPDIFF (YEAR , fecha_contratacion , CURDATE()) > 10
ORDER BY anios_contratado DESC;




-- Crear tabla de Datos_contratos
CREATE TABLE Datos_contratos (
cod_empleado INT PRIMARY KEY ,
fecha_nacimiento DATE,
cuota DECIMAL (10,2),
ventas DECIMAL (10,2),
FOREIGN KEY (cod_empleado)
REFERENCES Empleados(cod_empleado));


INSERT INTO datos_contratos (cod_empleado , fecha_nacimiento , cuota , ventas) VALUES (10 , '1980-05-10' , 5000.00, 150000.00);
INSERT INTO datos_contratos (cod_empleado , fecha_nacimiento , cuota , ventas) VALUES (11 , '1985-03-22' , 4500.00, 120000.00);
INSERT INTO datos_contratos (cod_empleado , fecha_nacimiento , cuota , ventas) VALUES (12 , '1990-11-15' , 4800.00, 130000.00);
INSERT INTO datos_contratos (cod_empleado , fecha_nacimiento , cuota , ventas) VALUES (13 , '1978-07-05' , 5200.00, 160000.00);
INSERT INTO datos_contratos (cod_empleado , fecha_nacimiento , cuota , ventas) VALUES (14 , '1992-01-30' , 4000.00, 110000.00);

-- consulta multitabla
SELECT *
FROM  datos_contratos
WHERE cuota < 50000 
OR  cuota > 100000;


-- Crear tabla de Fabricantes
CREATE TABLE Fabricantes(
cod_fabricante INT PRIMARY KEY ,
razon_social VARCHAR (100));

INSERT INTO fabricantes (cod_fabricante , razon_social) VALUES (1, 'SAMGUNG ELECTRONICS');
INSERT INTO fabricantes (cod_fabricante , razon_social) VALUES (2, 'APPLE INC');
INSERT INTO fabricantes (cod_fabricante , razon_social) VALUES (3, 'HUAWEI TECHNOLOGIES');
INSERT INTO fabricantes (cod_fabricante , razon_social) VALUES (4 ,'SONY CORPORATION');
INSERT INTO fabricantes(cod_fabricante , razon_social) VALUES (5,'LENOVO GROUP LTD');


DROP TABLE IF EXISTS Precios;
DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS Listas;

-- Crear tabla de Listas
CREATE TABLE Listas(
cod_lista INT PRIMARY KEY ,
descripcion VARCHAR (100) ,
ganancia DECIMAL (5,2));

INSERT INTO listas (cod_lista , descripcion, ganancia) VALUES (1, 'Lista Minorista', 15.00);
INSERT INTO listas (cod_lista , descripcion, ganancia) VALUES (2, 'Lista Mayorista', 10.00);
INSERT INTO listas (cod_lista , descripcion, ganancia) VALUES (3, 'Lista Promoción Especial', 5.50);
INSERT INTO listas (cod_lista , descripcion, ganancia) VALUES (4, 'Lista Distribuidor', 8.75);
INSERT INTO listas (cod_lista , descripcion, ganancia) VALUES (5, 'Lista Online', 12.25);


-- Crear tabla de Productos 
CREATE TABLE Productos(
cod_producto INT PRIMARY KEY ,
descripcion VARCHAR (100),
precio DECIMAL (10,2),
cantidad_stock INT ,
cod_fabricante INT,
FOREIGN KEY (cod_fabricante)REFERENCES Fabricantes (cod_fabricante));

ALTER TABLE productos ADD punto_reposicion INT; 

INSERT INTO Productos(cod_producto , descripcion, precio, cantidad_stock, cod_fabricante) VALUES (1, 'Mouse inalámbrico', 3500.00, 100, 1);
INSERT INTO Productos(cod_producto , descripcion, precio, cantidad_stock, cod_fabricante) VALUES (2, 'Teclado mecánico', 8200.50, 50, 1);
INSERT INTO Productos(cod_producto , descripcion, precio, cantidad_stock, cod_fabricante) VALUES (3, 'Monitor 24 pulgadas', 45000.00, 30, 2);
INSERT INTO Productos(cod_producto , descripcion, precio, cantidad_stock, cod_fabricante) VALUES (4, 'Notebook 15"', 250000.00, 20, 2);
INSERT INTO Productos(cod_producto , descripcion, precio, cantidad_stock, cod_fabricante) VALUES (5, 'Disco SSD 512GB', 18000.00, 75, 3);

UPDATE productos SET punto_reposicion = 120 WHERE cod_producto = 1; -- mouse inalambrico 
UPDATE productos SET punto_reposicion = 60 WHERE cod_producto = 2; -- teclado mecanico 
UPDATE productos SET punto_reposicion = 50 WHERE cod_producto = 3; -- monitor
UPDATE productos SET punto_reposicion = 30 WHERE cod_producto = 4; -- netbook 
UPDATE productos SET punto_reposicion = 100 WHERE cod_producto = 5; -- disco SSD 

-- consultas simples (una sola tabla)
SELECT
 descripcion,
cod_producto ,
ROUND (cod_producto * 1.21 , 2) AS precio_con_iva
FROM productos;

SELECT * 
FROM productos
ORDER BY precio ASC 
LIMIT 4;
 
-- consulta multitablas 
SELECT p.descripcion , f.razon_social , p.cantidad_stock AS stock
FROM productos p
INNER JOIN fabricantes f ON p.cod_fabricante = f.cod_fabricante -- condicion de union(INNER JOIN)
ORDER BY f.razon_social, p.descripcion;


-- consulta multitabla
SELECT 
p.cod_pedido,
p.fecha_pedido,
e.apellido AS apellido_empleado,
c.razon_social
FROM pedidos p
JOIN empleados e ON p.cod_empleado = e.cod_empleado
JOIN clientes c ON p.cod_cliente = c.cod_cliente;


-- consulta multitabla
SELECT DISTINCT pr.descripcion 
FROM pedidos p 
JOIN detalle_pedidos dp ON p.cod_pedido = dp.cod_pedido
JOIN productos pr ON dp.cod_producto = pr.cod_producto
WHERE MONTH (p.fecha_pedido) = 5;






-- Crear tabla de precios
CREATE TABLE Precios (
    cod_producto INT,
    cod_lista INT,
    precio DECIMAL(10,2),
    PRIMARY KEY(cod_producto, cod_lista),
    FOREIGN KEY(cod_producto) REFERENCES Productos(cod_producto),
    FOREIGN KEY(cod_lista) REFERENCES Listas(cod_lista)
);

INSERT INTO precios (cod_producto , cod_lista , precio) VALUES (1, 1, 4025.00);   -- 3500 + 15%
INSERT INTO precios (cod_producto , cod_lista , precio) VALUES (1, 2, 3850.00);   -- 3500 + 10%
INSERT INTO precios (cod_producto , cod_lista , precio) VALUES (2, 1, 9430.58);   -- 8200.50 + 15%
INSERT INTO precios (cod_producto , cod_lista , precio) VALUES (2, 3, 8651.53);   -- 8200.50 + 5.5%
INSERT INTO precios (cod_producto , cod_lista , precio) VALUES (3, 1, 51750.00);  -- 45000 + 15%
INSERT INTO precios (cod_producto , cod_lista , precio) VALUES (3, 5, 50456.25);  -- 45000 + 12.25%
INSERT INTO precios (cod_producto , cod_lista , precio) VALUES (4, 2, 275000.00); -- 250000 + 10%
INSERT INTO precios (cod_producto , cod_lista , precio) VALUES (4, 4, 271875.00); -- 250000 + 8.75%
INSERT INTO precios (cod_producto , cod_lista , precio) VALUES (5, 1, 20700.00);  -- 18000 + 15%
INSERT INTO precios (cod_producto , cod_lista , precio) VALUES (5, 3, 18990.00);  -- 18000 + 5.5%


-- Crear tabla de Clientes
CREATE TABLE Clientes(
cod_cliente INT PRIMARY KEY,
cod_lista INT,
razon_social VARCHAR (100),
FOREIGN KEY (cod_lista) REFERENCES Listas(cod_lista));
ALTER TABLE Clientes ADD tipo_cliente VARCHAR(20);

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Clientes;
SET FOREIGN_KEY_CHECKS = 1;



INSERT INTO clientes (cod_cliente , cod_lista , razon_social, tipo_cliente) VALUES (10,1, 'Empresa Alpha' ,'minorista');-- lista minorista
INSERT INTO clientes (cod_cliente , cod_lista , razon_social, tipo_cliente) VALUES (20,2, 'Distribuciones Beta' ,'mayorista'); -- Lista Mayorista
INSERT INTO clientes (cod_cliente , cod_lista , razon_social, tipo_cliente) VALUES (30,3, 'PromosTech S.A.' ,'mayorista');    -- Lista Promoción Especial
INSERT INTO clientes (cod_cliente , cod_lista , razon_social, tipo_cliente) VALUES (40,4, 'Distribuidores Gamma' ,'mayorista'); -- Lista Distribuidor
INSERT INTO clientes (cod_cliente , cod_lista , razon_social, tipo_cliente) VALUES (50,5, 'Online Solutions' ,'mayorista');   -- Lista Online

-- consultas simples(una sola tabla)
SELECT *
FROM clientes
ORDER BY cod_cliente;

-- consulta multitabla
SELECT DISTINCT c.razon_social
FROM pedidos p
JOIN clientes c ON p.cod_cliente = c.cod_cliente
WHERE MONTH (p.fecha_pedido) = 4;

-- consulta multitabla 
SELECT *
FROM clientes 
WHERE LOWER(tipo_cliente) = 'mayorista'
ORDER BY razon_social ASC;

-- consulta multitabla
SELECT 
  c.razon_social,
  dc.ventas
FROM clientes c
JOIN datos_contratos dc ON c.cod_cliente = dc.cod_empleado
ORDER BY c.razon_social;

-- consulta mutitabla 
SELECT f.razon_social , p.descripcion , (p.punto_reposicion - p.cantidad_stock) AS cantiada_a_comprar 
FROM productos p 
JOIN fabricantes f ON p.cod_fabricante = f.cod_fabricante 
WHERE 
p.cantidad_stock < p.punto_reposicion
ORDER BY
 f.razon_social ASC ,
  p.descripcion;

-- Crear tabla de Pedidos
CREATE TABLE Pedidos(
cod_pedido INT PRIMARY KEY ,
fecha_pedido DATE,
cod_empleado INT,
cod_cliente INT ,
FOREIGN KEY (cod_empleado) 
REFERENCES Empleados (cod_empleado),
FOREIGN KEY (cod_cliente)
REFERENCES Clientes(cod_cliente));


INSERT INTO pedidos (cod_pedido , fecha_pedido , cod_empleado , cod_cliente) VALUES (1, '2025-05-08', 10, 1);  -- Pedido de Cliente 1 (Empresa Alpha) realizado por Empleado 1
INSERT INTO pedidos (cod_pedido , fecha_pedido , cod_empleado , cod_cliente) VALUES (2, '2025-05-08', 11, 2);  -- Pedido de Cliente 2 (Distribuciones Beta) realizado por Empleado 2
INSERT INTO pedidos (cod_pedido , fecha_pedido , cod_empleado , cod_cliente) VALUES (3, '2025-05-07', 12, 3);  -- Pedido de Cliente 3 (PromosTech S.A.) realizado por Empleado 3
INSERT INTO pedidos (cod_pedido , fecha_pedido , cod_empleado , cod_cliente) VALUES (4, '2025-05-06', 13, 4);  -- Pedido de Cliente 4 (Distribuidores Gamma) realizado por Empleado 1
INSERT INTO pedidos (cod_pedido , fecha_pedido , cod_empleado , cod_cliente) VALUES (5, '2025-05-05', 14, 5);  -- Pedido de Cliente 5 (Online Solutions) realizado por Empleado 2


-- consultas simples (una sola tabla)
-- son pedidos de mayo 
SELECT *
FROM pedidos
ORDER BY fecha_pedido;



-- Crear tabla de Detalle_pedidos
CREATE TABLE Detalle_pedidos(
cod_pedido INT ,
cod_producto INT ,
numero_linea INT,
cantidad INT,
PRIMARY KEY (cod_pedido , numero_linea),
FOREIGN KEY (cod_pedido) REFERENCES Pedidos(cod_pedido),
FOREIGN KEY (cod_producto) REFERENCES Productos(cod_producto));



INSERT INTO detalle_pedidos (cod_pedido , cod_producto , numero_linea , cantidad) VALUES (1, 1, 1, 2);  -- Pedido 1: 2 Mouse inalámbrico (Producto 1)
INSERT INTO detalle_pedidos (cod_pedido , cod_producto , numero_linea , cantidad) VALUES (1, 2, 2, 1);  -- Pedido 1: 1 Teclado mecánico (Producto 2)
INSERT INTO detalle_pedidos (cod_pedido , cod_producto , numero_linea , cantidad) VALUES (2, 3, 1, 3);  -- Pedido 2: 3 Monitores 24" (Producto 3)
INSERT INTO detalle_pedidos (cod_pedido , cod_producto , numero_linea , cantidad) VALUES (2, 5, 2, 2);  -- Pedido 2: 2 Discos SSD 512GB (Producto 5)
INSERT INTO detalle_pedidos (cod_pedido , cod_producto , numero_linea , cantidad) VALUES (3, 4, 1, 1);  -- Pedido 3: 1 Notebook 15" (Producto 4)
INSERT INTO detalle_pedidos (cod_pedido , cod_producto , numero_linea , cantidad) VALUES (3, 1, 2, 2);  -- Pedido 3: 2 Mouse inalámbrico (Producto 1)
INSERT INTO detalle_pedidos (cod_pedido , cod_producto , numero_linea , cantidad) VALUES (4, 2, 1, 4);  -- Pedido 4: 4 Teclados mecánicos (Producto 2)
INSERT INTO detalle_pedidos (cod_pedido , cod_producto , numero_linea , cantidad) VALUES (5, 3, 1, 1);  -- Pedido 5: 1 Monitor 24" (Producto 3)
INSERT INTO detalle_pedidos (cod_pedido , cod_producto , numero_linea , cantidad) VALUES (5, 5, 2, 1);  -- Pedido 5: 1 Disco SSD 512GB (Producto 5)