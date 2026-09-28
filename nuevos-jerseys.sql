-- Nuevos jerseys: Monterrey (2004/2012), Dorados (C. Blanco), Paraguay, Brescia,
-- Santos Laguna (Hermoso), Real Madrid (2012/2017), Barcelona, Sivas, Salzburg (Haaland)
-- y Manchester United (Ronaldo)

insert into jerseys
  (nombre, club, pais, bandera, liga, marca, talla, anio, precio, color, imagen, imagen_espalda, descripcion, disponible, cantidad)
values
  (
    'Monterrey Visitante 2004',
    'CF Monterrey', 'México', '🇲🇽', 'Liga MX', 'Atletica', 'M', 2004, 500, 'Naranja',
    'Jerseys/Norte america/Liga MX/Monterrey/Monterrey4.png', null,
    'Jersey oficial visitante de Rayados de Monterrey temporada 2004, en naranja con detalles azul marino, marca Atletica, patrocinios Bimbo y Javer.',
    true, 1
  ),
  (
    'Monterrey Visitante 2012',
    'CF Monterrey', 'México', '🇲🇽', 'Liga MX', 'Nike', 'M', 2012, 700, 'Blanco y Morado',
    'Jerseys/Norte america/Liga MX/Monterrey/Monterrey5.png', null,
    'Jersey oficial visitante de Rayados de Monterrey temporada 2012, en blanco con franjas y mangas moradas, marca Nike, patrocinios BBVA Bancomer y Bimbo.',
    true, 1
  ),
  (
    'Dorados Visitante 2013 - Cuauhtémoc Blanco #10',
    'Dorados de Sinaloa', 'México', '🇲🇽', 'Liga MX', 'Kappa', 'S', 2013, 700, 'Negro',
    'Jerseys/Norte america/Liga MX/Dorados/Dorados.png',
    'Jerseys/Norte america/Liga MX/Dorados/Dorados2.png',
    'Jersey oficial visitante de Dorados de Sinaloa temporada 2013, en negro con patrocinios Coppel y Tecate, marca Kappa, personalizado con el nombre y número de Cuauhtémoc Blanco #10.',
    true, 1
  ),
  (
    'Paraguay Local 2006',
    'Selección de Paraguay', 'Paraguay', '🇵🇾', 'Selección Nacional', 'Puma', 'L', 2006, 700, 'Rojo y Blanco',
    'Jerseys/Internacional/Paraguay/Paraguay.png', null,
    'Jersey oficial local de la selección de Paraguay temporada 2006, en las clásicas franjas rojo y blanco, marca Puma.',
    true, 1
  ),
  (
    'Brescia Local 2024',
    'Brescia Calcio', 'Italia', '🇮🇹', 'Serie B', 'Kappa', 'XL', 2024, 1100, 'Azul y Blanco',
    'Jerseys/Europa/Serie A/Brescia/Brescia.png', null,
    'Jersey oficial local del Brescia Calcio temporada 2024, en azul con la clásica "V" blanca al frente, marca Kappa.',
    true, 1
  ),
  (
    'Santos Laguna Visitante 2014 - Hermoso #24',
    'Club Santos Laguna', 'México', '🇲🇽', 'Liga MX', 'Puma', 'S', 2014, 1000, 'Negro',
    'Jerseys/Norte america/Liga MX/Santos/Santos6.png',
    'Jerseys/Norte america/Liga MX/Santos/Santos7.png',
    'Jersey oficial visitante del Santos Laguna temporada 2014, en negro con patrocinios Peñoles y Soriana, marca Puma, personalizado con el nombre y número de Hermoso #24.',
    true, 1
  ),
  (
    'Real Madrid Local 2012',
    'Real Madrid CF', 'España', '🇪🇸', 'La Liga', 'Adidas', 'S', 2012, 900, 'Blanco',
    'Jerseys/Europa/La liga/Real madrid/RM15.png', null,
    'Jersey oficial local del Real Madrid temporada 2012-13, blanco con finas líneas verticales y patrocinio bwin, marca Adidas.',
    true, 1
  ),
  (
    'Real Madrid Local 2017 - Ronaldo #7',
    'Real Madrid CF', 'España', '🇪🇸', 'La Liga', 'Adidas', 'S', 2017, 1300, 'Blanco',
    'Jerseys/Europa/La liga/Real madrid/RM13.png',
    'Jerseys/Europa/La liga/Real madrid/RM14.png',
    'Jersey oficial local del Real Madrid temporada 2016-17, blanco con patrocinio Fly Emirates, marca Adidas, personalizado con el nombre y número de Ronaldo #7.',
    true, 1
  ),
  (
    'Barcelona Local 2011',
    'FC Barcelona', 'España', '🇪🇸', 'La Liga', 'Nike', 'S', 2011, 1500, 'Rojo y Azul',
    'Jerseys/Europa/La liga/Barcelona/Barcelona.png', null,
    'Jersey oficial local del FC Barcelona temporada 2011-12, en las clásicas franjas blaugrana, patrocinio Qatar Foundation, marca Nike.',
    true, 1
  ),
  (
    'Sivas Local - Candemir #66',
    'Sivas Belediyespor', 'Turquía', '🇹🇷', 'Süper Lig', 'Puma', 'XL', null, 400, 'Blanco y Verde',
    'Jerseys/Europa/Superliga Turca/Sivas/Sivas.png',
    'Jerseys/Europa/Superliga Turca/Sivas/Sivas2.png',
    'Jersey oficial local del Sivas Belediyespor, en blanco con mangas verdes, marca Puma, personalizado con el nombre y número de Candemir #66.',
    true, 1
  ),
  (
    'Salzburg Local 2019 - Haaland #30',
    'FC Red Bull Salzburg', 'Austria', '🇦🇹', 'Bundesliga Austriaca', 'Nike', 'S', 2019, 2500, 'Rojo y Blanco',
    'Jerseys/Europa/Bundesliga Austriaca/Salzburg/Salzburg2.png',
    'Jerseys/Europa/Bundesliga Austriaca/Salzburg/Salzburg3.png',
    'Jersey oficial local del FC Red Bull Salzburg temporada 2019, en rojo y blanco con el logo de los toros, marca Nike, personalizado con el nombre y número de Haaland #30.',
    true, 1
  ),
  (
    'Manchester United Visitante 2007 - Ronaldo #7',
    'Manchester United FC', 'Inglaterra', '🏴', 'Premier League', 'Nike', 'XL', 2007, 3500, 'Blanco',
    'Jerseys/Europa/Premier League/Manchester united/Manu5.png',
    'Jerseys/Europa/Premier League/Manchester united/Manu6.png',
    'Jersey oficial visitante del Manchester United temporada 2007-08, en blanco con detalles dorados y negros, patrocinio AIG, marca Nike, personalizado con el nombre y número de Ronaldo #7.',
    true, 1
  );
