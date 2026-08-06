-- Insertar Monterrey (Visitante 2008) y Real Madrid (2023-24, Rodrygo #11)
insert into jerseys
  (nombre, club, pais, bandera, liga, marca, talla, anio, precio, color, imagen, imagen_espalda, descripcion, disponible, cantidad)
values
  (
    'Monterrey Visitante 2008',
    'CF Monterrey',
    'México',
    '🇲🇽',
    'Liga MX',
    'Nike',
    'M',
    2008,
    1000,
    'Naranja',
    'Jerseys/Norte america/Liga MX/Monterrey/Monterrey1.png',
    null,
    'Jersey visitante de Rayados de Monterrey temporada 2008, edición histórica en color naranja con patrocinio Bimbo. Club emblemático del norte de México y uno de los más ganadores de la Liga MX.',
    true,
    1
  ),
  (
    'Real Madrid 2023-24 - Rodrygo #11',
    'Real Madrid CF',
    'España',
    '🇪🇸',
    'La Liga',
    'Adidas',
    'L',
    2023,
    1600,
    'Blanco',
    'Jerseys/Europa/La liga/Real madrid/RM1.png',
    'Jerseys/Europa/La liga/Real madrid/RM2.png',
    'Jersey oficial local del Real Madrid temporada 2023-24, en el clásico blanco merengue con detalles dorados, personalizada con el nombre y número de Rodrygo #11. Club más ganador de la historia de la Champions League.',
    true,
    1
  );
