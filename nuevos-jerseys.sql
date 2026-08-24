-- Nuevos jerseys: Monterrey (Local 2013), Caen (Local 2024) y Arsenal (Visitante 2016)

insert into jerseys
  (nombre, club, pais, bandera, liga, marca, talla, anio, precio, color, imagen, imagen_espalda, descripcion, disponible, cantidad)
values
  (
    'Monterrey Local 2013',
    'CF Monterrey',
    'México',
    '🇲🇽',
    'Liga MX',
    'Nike',
    'M',
    2013,
    1100,
    'Negro',
    'Jerseys/Norte america/Liga MX/Monterrey/Monterrey2.png',
    'Jerseys/Norte america/Liga MX/Monterrey/Monterrey3.png',
    'Jersey oficial local de Rayados de Monterrey de la era 2013-14, en negro con franjas blancas y grises, tecnología Nike Dri-Fit y patrocinios BBVA Bancomer y Bimbo. Pieza auténtica personalizada con el nombre y número de Basanta #15, con Tecate y Telcel en la espalda.',
    true,
    1
  ),
  (
    'SM Caen Local 2024',
    'SM Caen',
    'Francia',
    '🇫🇷',
    'Ligue 2',
    'Kappa',
    'XL',
    2024,
    1450,
    'Azul y Rojo',
    'Jerseys/Europa/League One/Caen/Caen.png',
    null,
    'Jersey oficial local del Stade Malherbe de Caen temporada 2024, con el característico diseño a franjas diagonales azul y rojo de Kappa, escudo del club y patrocinios Künkel y Thalazur.',
    true,
    1
  ),
  (
    'Arsenal Visitante 2016',
    'Arsenal FC',
    'Inglaterra',
    '🏴',
    'Premier League',
    'Puma',
    'M',
    2016,
    1000,
    'Amarillo',
    'Jerseys/Europa/Premier League/Arsenal/Arsenal.png',
    null,
    'Jersey oficial visitante del Arsenal FC temporada 2016-17, en amarillo con detalles negros, marca Puma y patrocinio Fly Emirates. Diseño clásico usado por el equipo en la era de Arsène Wenger.',
    true,
    1
  );
