/*Cliente (idCliente, nombre, apellido, DNI, telefono, direccion)
Factura (nroTicket, total, fecha, hora, idCliente (fk))
Detalle (nroTicket (fk), idProducto (fk), cantidad, preciounitario)
Producto (idProducto, nombreP, descripcion, precio, stock)*/

--1. Listar datos personales de clientes cuyo apellido comience con el string ‘Pe’. Ordenar por DNI

SELECT c.nombre, c.apellido, c.telefono c.direccion --En caso de que quiera representar todos los datos pongo SELECT *
FROM Cliente c
where c.apellido like "%pe"
ORDER BY c.DNI;
/*2. Listar nombre, apellido, DNI, teléfono y dirección de clientes que realizaron compras solamente
durante 2017.*/
SELECT c.nombre , c.apellido c.DNI, c.telefono, c.direccion
FROM cliente c 
join Factura f on c.idCliente=f.idCliente
where YEAR(f.fecha) =2017
GROUP BY c.nombre, c.apellido. c.dni, c.telefono, c.direccion
HAVING count(DISTINCT YEAR(F.fecha))=1;

/*3. Listar nombre, descripción, precio y stock de productos vendidos al cliente con DNI 45789456,
pero que no fueron vendidos a clientes de apellido ‘Garcia’.*/
SELECT p.nombreP, p.descripcion, p.precio, p.stock
FROM Producto p
join Detalle d on d.idProducto=p.idProducto
join Factura f on f.nroTicket=d,nroTicket
join cliente c on F.idCliente=C.idCliente
WHERE C.DNI= 45789456
 AND P.idProducto NOT IN (
      SELECT D2.idProducto
      FROM Detalle D2
      JOIN Factura F2 ON D2.nroTicket = F2.nroTicket
      JOIN Cliente C2 ON F2.idCliente = C2.idCliente
      WHERE C2.apellido = 'Garcia'
  );

/*4. Listar nombre, descripción, precio y stock de productos no vendidos a clientes que tengan
teléfono con característica 221 (la característica está al comienzo del teléfono). Ordenar por
nombre.*/
SELECT p.descripcion , p.precio p.stock
FROM Producto P
WHERE p.idProducto NOT IN(
    SELECT d.idProducto
    FROM Detalle d
    join Factura f on (f.nroTicket=d.nroTicket)
    join cliente c on (c:idCliente=f.idCliente)
    where c.telefono="%221"
)
ORDER BY p.nombre;

/*5. Listar para cada producto nombre, descripción, precio y cuantas veces fue vendido. Tenga en
cuenta que puede no haberse vendido nunca el producto.*/

SELECT p.nombreP, 
       p.descripcion, 
       p.precio, 
       COALESCE(COUNT(d.idProducto), 0) AS VecesVendido --En caso de que la tabla tenga null lo transforma por un 0
FROM Producto p
LEFT JOIN Detalle d ON d.idProducto = p.idProducto
GROUP BY p.nombreP, p.descripcion, p.precio
ORDER BY p.nombreP;

/*6. Listar nombre, apellido, DNI, teléfono y dirección de clientes que compraron los productos con
nombre ‘prod1’ y ‘prod2’ pero nunca compraron el producto con nombre ‘prod3’.*/
SELECT C.nombre, C.apellido, C.DNI, C.telefono, C.direccion
FROM Cliente C
JOIN Factura F ON C.idCliente = F.idCliente
JOIN Detalle D ON F.nroTicket = D.nroTicket
JOIN Producto P ON D.idProducto = P.idProducto
WHERE P.nombreP IN ('prod1', 'prod2')
GROUP BY C.nombre, C.apellido, C.DNI, C.telefono, C.direccion
HAVING COUNT(DISTINCT P.nombreP) = 2
   AND C.idCliente NOT IN (
       SELECT C2.idCliente
       FROM Cliente C2
       JOIN Factura F2 ON C2.idCliente = F2.idCliente
       JOIN Detalle D2 ON F2.nroTicket = D2.nroTicket
       JOIN Producto P2 ON D2.idProducto = P2.idProducto
       WHERE P2.nombreP = 'prod3'
   );


/*7. Listar nroTicket, total, fecha, hora y DNI del cliente, de aquellas facturas donde se haya
comprado el producto ‘prod38’ o la factura tenga fecha de 2019.*/
SELECT F.nroTicket,  F.total, F.fecha, F.hora,  C.DNI
FROM Factura F
JOIN Cliente C ON F.idCliente = C.idCliente
JOIN Detalle D ON F.nroTicket = D.nroTicket
JOIN Producto P ON D.idProducto = P.idProducto
WHERE P.nombreP = 'prod38'
   OR YEAR(F.fecha) = 2019;


/*8. Agregar un cliente con los siguientes datos: nombre:’Jorge Luis’, apellido:’Castor’, DNI:
40578999, teléfono: ‘221-4400789’, dirección:’11 entre 500 y 501 nro:2587’ y el id de cliente:
500002. Se supone que el idCliente 500002 no existe.*/
INSERT INTO Cliente (DNI, nombre, apellido, telefono, direccion,idCliente)
VALUES (40578999, 'Jorge Luis', 'Castor', '221-4400789', '11 entre 500 y 501 nro:2587',50002);

/*9. Listar nroTicket, total, fecha, hora para las facturas del cliente ´Jorge Pérez´ donde no haya
comprado el producto ´Z´.*/
SELECT F.nroTicket, F.total, F.fecha, F.hora
FROM Factura F
JOIN Cliente C ON F.idCliente = C.idCliente
JOIN Detalle D ON F.nroTicket = D.nroTicket
JOIN Producto P ON D.idProducto = P.idProducto
WHERE C.nombre = 'Jorge' 
  AND C.apellido = 'Pérez'
  AND F.nroTicket NOT IN (
      SELECT D2.nroTicket
      FROM Detalle D2
      JOIN Producto P2 ON D2.idProducto = P2.idProducto
      WHERE P2.nombreP = 'Z'
  );

/*10. Listar DNI, apellido y nombre de clientes donde el monto total comprado, teniendo en cuenta
todas sus facturas, supere $10.000.000*/
SELECT C.DNI, C.apellido, C.nombre
FROM Cliente C
JOIN Factura F ON C.idCliente = F.idCliente
GROUP BY C.DNI, C.apellido, C.nombre
HAVING SUM(F.total) > 10000000;

