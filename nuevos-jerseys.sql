-- Nuevos jerseys: España Mundial 2002 (Raúl #7) y FC København Aniversario 2025-26

insert into jerseys
  (nombre, club, pais, bandera, liga, marca, talla, anio, precio, color, imagen, imagen_espalda, descripcion, disponible, cantidad)
values
  (
    'España Local Mundial 2002 - Raúl #7',
    'Selección de España',
    'España',
    '🇪🇸',
    'Selección Nacional',
    'Adidas',
    'XL',
    2002,
    800,
    'Rojo',
    'Jerseys/Internacional/Espana/Esp3.png',
    'Jerseys/Internacional/Espana/Esp4.png',
    'Jersey oficial local de la selección de España para el Mundial Corea-Japón 2002, en rojo con detalles amarillos y azul marino, marca Adidas ClimaLite, personalizada con el nombre y número de Raúl #7.',
    true,
    1
  ),
  (
    'FC København Aniversario 2025-26',
    'FC København',
    'Dinamarca',
    '🇩🇰',
    'Superliga',
    'Adidas',
    'XL',
    2025,
    2700,
    'Azul y Blanco',
    'Jerseys/Europa/Superliga/Cope/Cope.png',
    null,
    'Jersey especial de aniversario del FC København temporada 2025-26, de manga larga con el clásico diseño a franjas verticales azul y blanco, escudo dorado del león y tecnología Adidas Aeroready.',
    true,
    1
  );
