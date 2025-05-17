-- crear tabla de clientes 
CREATE TABLE CLIENTES(
codigo_cliente INT PRIMARY KEY,
nombre VARCHAR (100),
domicilio VARCHAR (150),
provincia VARCHAR (50));

INSERT INTO clientes (codigo_cliente , nombre , domicilio , provincia) VALUES (1 , 'DONATO' , 'nueve de julio' , 'Buenos Aires');
INSERT INTO clientes (codigo_cliente , nombre, domicilio , provincia) VALUES ( 2 , 'GUADALUPE' , 'oncativo' , 'Buenos aires');
INSERT INTO clientes (codigo_cliente , nombre , domicilio , provincia) VALUES (3 , 'MARTIN' , 'peatonal san martin' , 'cordoba');
INSERT INTO clientes (codigo_cliente , nombre , domicilio , provincia) VALUES (4 , 'FERNANDO' , 'calle alem' , 'misiones');
INSERT INTO clientes (codigo_cliente , nombre , domicilio , provincia) VALUES (5 , 'ANGEL' , 'elizalde' , 'Buenos Aires');

DELETE FROM clientes;

-- crear tabla productos
CREATE TABLE PRODUCTOS(
codigo_producto INT PRIMARY KEY,
nombre_producto VARCHAR (100));

INSERT INTO productos(codigo_producto , nombre_producto) VALUES (6 , 'Auriculares bluetooth');
INSERT INTO productos(codigo_producto , nombre_producto) VALUES (7 , 'Tablet 10');
INSERT INTO productos(codigo_producto , nombre_producto) VALUES (8 , 'Impresora multifuncion');
INSERT INTO productos(codigo_producto , nombre_producto) VALUES (9 , 'Memoria RAM 16GB');
INSERT INTO productos(codigo_producto , nombre_producto) VALUES (10 , 'Webcam HD');

-- crear tabla de item_ventas
DROP TABLE IF EXISTS ITEM_VENTAS;
CREATE TABLE ITEM_VENTAS(
numero_factura INT,
codigo_producto INT,
cantidad INT, 
precio DECIMAL(10 , 2),
PRIMARY KEY (numero_factura , codigo_producto),
FOREIGN KEY (numero_factura) REFERENCES VENTAS(numero_factura),
FOREIGN KEY (codigo_producto) REFERENCES PRODUCTOS(codigo_producto));

INSERT INTO item_ventas(numero_factura, codigo_producto , cantidad , precio) VALUES (1001, 6 , 20 , 3500.00); -- auriculares bluetooth
INSERT INTO item_ventas(numero_factura, codigo_producto , cantidad , precio) VALUES (1001, 7 , 10 , 18000.00); -- tablet 10
INSERT INTO item_ventas(numero_factura, codigo_producto , cantidad , precio) VALUES (1002, 8 , 15 , 8200.50); -- impresora multifuncion
INSERT INTO item_ventas(numero_factura, codigo_producto , cantidad , precio) VALUES (1003, 9 , 41 , 45000.00); -- memoria ram 16gb
INSERT INTO item_ventas(numero_factura, codigo_producto , cantidad , precio) VALUES (1004, 10 , 38 , 7200.00); -- webcam hd

-- consulta 
SELECT MAX(cantidad) AS cantidad_maxima
FROM item_ventas;

-- consulta 
SELECT p.nombre_producto , SUM(iv.cantidad) AS cantidad_total
FROM item_ventas iv
JOIN productos p ON iv.codigo_producto = p.codigo_producto
GROUP BY p.nombre_producto;


-- consulta
SELECT p.nombre_producto AS descripcion, SUM(iv.cantidad) AS unidades_vendidas
 FROM item_ventas iv
 JOIN productos p ON iv.codigo_producto = p.codigo_producto
 GROUP BY p.nombre_producto
 ORDER BY unidades_vendidas DESC;
 
-- consulta
SELECT p.nombre_producto AS descripcion, SUM(iv.cantidad) AS unidades_vendidas
FROM item_ventas iv 
JOIN productos p ON iv.codigo_producto = p.codigo_producto
GROUP BY p.nombre_producto
HAVING SUM(iv.cantidad) > 30
ORDER BY p.nombre_producto ASC;

-- concuslta 
SELECT c.codigo_cliente, c.nombre,
COUNT(v.numero_factura) AS cantidad_compras
FROM ventas v
JOIN clientes c on v.codigo_cliente = c.codigo_cliente
GROUP BY c.codigo_cliente , c.nombre
ORDER BY cantidad_compras DESC;

-- consulta
SELECT iv.codigo_producto,
AVG(iv.cantidad) AS promedio_unidades
FROM ventas v
JOIN item_ventas iv ON v.numero_factura = iv.numero_factura
WHERE v.codigo_cliente = 1
GROUP BY iv.codigo_producto;



-- crear tabla de ventas 
CREATE TABLE VENTAS(
numero_factura INT PRIMARY KEY,
codigo_cliente INT,
fecha DATE,
FOREIGN KEY (codigo_cliente) REFERENCES CLIENTES (codigo_cliente));


INSERT INTO ventas(numero_factura , codigo_cliente, fecha) VALUES (1001, 1, '2025-05-01');
INSERT INTO ventas(numero_factura , codigo_cliente, fecha) VALUES (1002, 2, '2025-04-03');
INSERT INTO ventas(numero_factura , codigo_cliente, fecha) VALUES (1003, 3, '2025-01-04');
INSERT INTO ventas(numero_factura , codigo_cliente, fecha) VALUES (1004, 4, '2025-02-17');
INSERT INTO ventas(numero_factura , codigo_cliente, fecha) VALUES (1005, 5, '2025-03-28');

