-- Nuevos jerseys: Grecia 2006 (Charisteas), Dinamarca 2012, Chelsea 2023-24 y Valencia 2003-04

insert into jerseys
  (nombre, club, pais, bandera, liga, marca, talla, anio, precio, color, imagen, imagen_espalda, descripcion, disponible, cantidad)
values
  (
    'Grecia Local 2006 - Charisteas #9',
    'Selección de Grecia',
    'Grecia',
    '🇬🇷',
    'Selección Nacional',
    'Adidas',
    'XL',
    2006,
    1500,
    'Azul',
    'Jerseys/Internacional/Grecia/Grecia1.png',
    'Jerseys/Internacional/Grecia/Grecia2.png',
    'Jersey oficial local de la selección de Grecia temporada 2006, en azul con detalles blancos, marca Adidas ClimaCool, personalizado con el nombre y número de Charisteas #9.',
    true,
    1
  ),
  (
    'Dinamarca Local 2012',
    'Selección de Dinamarca',
    'Dinamarca',
    '🇩🇰',
    'Selección Nacional',
    'Adidas',
    'XL',
    2012,
    1500,
    'Rojo',
    'Jerseys/Internacional/Dinamarca/Dinamarca.png',
    null,
    'Jersey oficial local de la selección de Dinamarca temporada 2012, en rojo con hombros blancos, escudo de la DBU y tecnología Adidas ClimaCool.',
    true,
    1
  ),
  (
    'Chelsea Local 2023-24',
    'Chelsea FC',
    'Inglaterra',
    '🏴',
    'Premier League',
    'Nike',
    'XL',
    2023,
    1100,
    'Azul',
    'Jerseys/Europa/Premier League/Chelsea/CH1.png',
    null,
    'Jersey oficial local del Chelsea FC temporada 2023-24, en azul con mangas blancas y detalles dorados, marca Nike Dri-FIT.',
    true,
    1
  ),
  (
    'Valencia Local 2003-04',
    'Valencia CF',
    'España',
    '🇪🇸',
    'La Liga',
    'Nike',
    'XL',
    2003,
    1500,
    'Blanco y Negro',
    'Jerseys/Europa/La liga/Valencia/Valencia.png',
    null,
    'Jersey oficial local del Valencia CF temporada 2003-04, blanco con mangas negras y patrocinio Toyota, marca Nike.',
    true,
    1
  );
