--Listar nombre, apellido, DNI, teléfono y dirección de clientes que realizaron compras solamente durante el año 2022.
SELECT cliente.nombre, 
       cliente.apellido, 
       cliente.dni, 
       cliente.telefono, 
       cliente.direccion
FROM Cliente
INNER JOIN Venta ON Venta.idCliente = Cliente.idCliente
WHERE YEAR(Venta.fecha) = 2022;
