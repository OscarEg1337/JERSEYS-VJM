-- Corrección: el "Real Madrid 2023-24 - Rodrygo #11" ya existía en el catálogo
-- (se insertó por error como duplicado). Se borra ese duplicado y se agrega
-- el jersey correcto que faltaba: Real Madrid Local 2022-23, Alaba #4.

delete from jerseys
where nombre = 'Real Madrid 2023-24 - Rodrygo #11';

insert into jerseys
  (nombre, club, pais, bandera, liga, marca, talla, anio, precio, color, imagen, imagen_espalda, descripcion, disponible, cantidad)
values
  (
    'Real Madrid 2022-23 - Alaba #4',
    'Real Madrid CF',
    'España',
    '🇪🇸',
    'La Liga',
    'Adidas',
    'M',
    2022,
    1600,
    'Blanco',
    'Jerseys/Europa/La liga/Real madrid/RM3.png',
    'Jerseys/Europa/La liga/Real madrid/RM4.png',
    'Jersey oficial local del Real Madrid temporada 2022-23, en blanco con detalles morados y parches de Champions League, personalizada con el nombre y número de Alaba #4.',
    true,
    1
  );
