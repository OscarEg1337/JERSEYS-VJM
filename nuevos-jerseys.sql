-- Nuevos jerseys: Real Madrid Beckham 2003-04 (gira de Asia), Everton Lukaku 2014-15,
-- Liverpool Suárez visitante 2011-12 y Aston Villa Ginola visitante 2001-02

insert into jerseys
  (nombre, club, pais, bandera, liga, marca, talla, anio, precio, color, imagen, imagen_espalda, descripcion, disponible, cantidad)
values
  (
    'Real Madrid Local 2003-04 - Beckham #23',
    'Real Madrid CF',
    'España',
    '🇪🇸',
    'La Liga',
    'Adidas',
    'XL',
    2003,
    1800,
    'Blanco',
    'Jerseys/Europa/La liga/Real madrid/RM9.png',
    'Jerseys/Europa/La liga/Real madrid/RM10.png',
    'Jersey oficial local del Real Madrid temporada 2003-04, blanco con patrocinio Siemens Mobile. Edición especial de la gira de pretemporada por Asia, con el nombre y número de Beckham #23 impresos en caracteres chinos en la espalda.',
    true,
    1
  ),
  (
    'Everton Local 2014-15 - Lukaku #10',
    'Everton FC',
    'Inglaterra',
    '🏴',
    'Premier League',
    'Umbro',
    'S',
    2014,
    800,
    'Azul',
    'Jerseys/Europa/Premier League/Everton/Eve1.png',
    'Jerseys/Europa/Premier League/Everton/Eve2.png',
    'Jersey oficial local del Everton FC temporada 2014-15, en azul con patrocinio Chang, marca Umbro, personalizado con el nombre y número de Lukaku #10.',
    true,
    1
  ),
  (
    'Liverpool Visitante 2011-12 - Suárez #7',
    'Liverpool FC',
    'Inglaterra',
    '🏴',
    'Premier League',
    'Adidas',
    'XL',
    2011,
    1100,
    'Negro',
    'Jerseys/Europa/Premier League/Liverpool/Liverpool2.png',
    'Jerseys/Europa/Premier League/Liverpool/Liverpool3.png',
    'Jersey oficial visitante del Liverpool FC temporada 2011-12, en negro con patrocinio Standard Chartered y tecnología Adidas ClimaCool, personalizado con el nombre y número de Suárez #7.',
    true,
    1
  ),
  (
    'Aston Villa Visitante 2001-02 - Ginola #14',
    'Aston Villa FC',
    'Inglaterra',
    '🏴',
    'Premier League',
    'Diadora',
    'XL',
    2001,
    1800,
    'Gris',
    'Jerseys/Europa/Premier League/Aston Villa/AV1.png',
    'Jerseys/Europa/Premier League/Aston Villa/AV2.png',
    'Jersey oficial visitante del Aston Villa FC temporada 2001-02, en gris plateado con mangas negras, marca Diadora y patrocinio ntl:, personalizado con el nombre y número de Ginola #14.',
    true,
    1
  );
