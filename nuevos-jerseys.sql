-- Nuevos jerseys: Real Madrid (Bellingham 2024-25 y Zidane 2005-06), Newcastle United 2000-01 y Juventus 2025-26

insert into jerseys
  (nombre, club, pais, bandera, liga, marca, talla, anio, precio, color, imagen, imagen_espalda, descripcion, disponible, cantidad)
values
  (
    'Real Madrid Local 2024-25 - Bellingham #5',
    'Real Madrid CF',
    'España',
    '🇪🇸',
    'La Liga',
    'Adidas',
    'XL',
    2024,
    1500,
    'Blanco',
    'Jerseys/Europa/La liga/Real madrid/RM5.png',
    'Jerseys/Europa/La liga/Real madrid/RM6.png',
    'Jersey oficial local del Real Madrid temporada 2024-25, blanco con detalles negros y patrocinio Emirates Fly Better, personalizado con el nombre y número de Bellingham #5.',
    true,
    1
  ),
  (
    'Real Madrid Local 2005-06 - Zidane #5',
    'Real Madrid CF',
    'España',
    '🇪🇸',
    'La Liga',
    'Adidas',
    'L',
    2005,
    750,
    'Blanco',
    'Jerseys/Europa/La liga/Real madrid/RM7.png',
    'Jerseys/Europa/La liga/Real madrid/RM8.png',
    'Jersey oficial local del Real Madrid temporada 2005-06, blanco clásico con patrocinio Siemens, personalizado con el nombre y número de Zidane #5. Pieza histórica de la era de los Galácticos.',
    true,
    1
  ),
  (
    'Newcastle United Local 2000-01',
    'Newcastle United FC',
    'Inglaterra',
    '🏴',
    'Premier League',
    'Adidas',
    'XL',
    2000,
    2700,
    'Blanco y Negro',
    'Jerseys/Europa/Premier League/NCU/NC3.png',
    null,
    'Jersey oficial local del Newcastle United temporada 2000-01, en las clásicas franjas blancas y negras, marca Adidas y patrocinio ntl:. Pieza vintage de colección.',
    true,
    1
  ),
  (
    'Juventus Local 2025-26',
    'Juventus FC',
    'Italia',
    '🇮🇹',
    'Serie A',
    'Adidas',
    'M',
    2025,
    1500,
    'Blanco y Negro',
    'Jerseys/Europa/Serie A/Juventus/JV3.png',
    null,
    'Jersey oficial local de la Juventus temporada 2025-26, en las clásicas franjas blanco y negro con detalles rosas, marca Adidas y tecnología Aeroready.',
    true,
    1
  );
