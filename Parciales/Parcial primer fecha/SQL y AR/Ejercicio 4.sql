--Listar para cada libro el título, autor, precio y la cantidad total de veces que fue vendido. Tener en cuenta que puede haber libros que no se vendieron.
SELECT 
    libro.titulo,
    libro.autor,
    libro.precio,
    SUM(detalleventa.cantidad) AS total_vendido
FROM libro
LEFT JOIN detalleventa ON detalleventa.idlibro = libro.idlibro
GROUP BY libro.titulo, libro.autor, libro.precio;
