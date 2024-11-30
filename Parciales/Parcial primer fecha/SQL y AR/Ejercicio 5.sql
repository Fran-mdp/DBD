--Listar nroVenta, total, fecha, hora y DNI del cliente, de aquellas ventas donde se haya vendido al menos un libro con precio mayor a 1000
;
SELECT venta.fecha,venta.hora,venta.nroVenta,cliente.DNI
FROM venta
INNER JOIN cliente ON cliente.idcliente=venta.idcliente
INNER JOIN detalleventa ON detalleventa.nroVenta=venta.nroVenta
INNER JOIN libro ON libro.idlibro=detalleventa.idlibro
WHERE
     libro.precio>1000
