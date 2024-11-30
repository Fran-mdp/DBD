--Listar todas las ventas realizadas en agosto de 2023
SELECT venta.total, venta.fecha,venta.hora, venta.telefono,venta.direccion
FROM venta
WHERE
MONTH(venta.fecha)=8 and YEAR(venta.fecha)=2023