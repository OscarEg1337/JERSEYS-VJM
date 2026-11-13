-- Rediseño de la tienda (nov 2026)
-- Ejecutar en Supabase > SQL Editor. Es seguro correrlo más de una vez.

-- 1) Campos nuevos en jerseys (todos opcionales: la página funciona sin ellos)
alter table jerseys add column if not exists estado      smallint check (estado between 1 and 10);
alter table jerseys add column if not exists estado_nota text;
alter table jerseys add column if not exists axila_cm    numeric(4,1);
alter table jerseys add column if not exists largo_cm    numeric(4,1);
alter table jerseys add column if not exists manga_cm    numeric(4,1);
alter table jerseys add column if not exists destacado   boolean not null default false;
-- Foto de jugador/modelo usando el jersey para el carrusel principal (ruta como 'Jerseys/hero/ronaldo.jpg').
-- Usa solo fotos propias o con licencia. Si está vacía, el carrusel arma la diapositiva con la foto del jersey.
alter table jerseys add column if not exists imagen_hero text;
-- Crédito obligatorio para fotos con licencia Creative Commons (se muestra en la esquina de la foto)
alter table jerseys add column if not exists imagen_hero_credito text;
alter table jerseys add column if not exists imagen_hero_fuente  text;

-- Fotos del carrusel (Wikimedia Commons, licencias CC BY-SA: uso comercial permitido dando crédito)
update jerseys set imagen_hero = 'Jerseys/hero/ibrahimovic-man-utd-2016.jpg',
  imagen_hero_credito = 'Foto: Ardfern · CC BY-SA 4.0',
  imagen_hero_fuente  = 'https://commons.wikimedia.org/wiki/File:Manchester_United_v_Manchester_City,_October_2016_(11).JPG'
  where id = 19;
update jerseys set imagen_hero = 'Jerseys/hero/lukaku-everton-2014.jpg',
  imagen_hero_credito = 'Foto: Илья Хохлов · CC BY-SA 3.0',
  imagen_hero_fuente  = 'https://commons.wikimedia.org/wiki/File:Lukaku_Romelu_126231.jpg'
  where id = 46;
update jerseys set imagen_hero = 'Jerseys/hero/kane-inglaterra-2018.jpg',
  imagen_hero_credito = 'Foto: Антон Зайцев · CC BY-SA 3.0',
  imagen_hero_fuente  = 'https://commons.wikimedia.org/wiki/File:England_vs_Panama_2018.jpg'
  where id = 59;
update jerseys set imagen_hero = 'Jerseys/hero/ronaldo-real-madrid.jpg',
  imagen_hero_credito = 'Foto: Oleg Dubyna · CC BY-SA 2.0',
  imagen_hero_fuente  = 'https://commons.wikimedia.org/wiki/File:Cristiano_Ronaldo_(35609138466).jpg'
  where id = 69;
update jerseys set imagen_hero = 'Jerseys/hero/haaland-salzburg-2019.jpg',
  imagen_hero_credito = 'Foto: Werner100359 · CC BY-SA 4.0',
  imagen_hero_fuente  = 'https://commons.wikimedia.org/wiki/File:FC_RB_Salzburg_versus_SV_Mattersburg_(4._Juli_2019)_29.jpg'
  where id = 72;

-- Ejemplo: llenar estado y medidas de una pieza
-- update jerseys set estado = 9, estado_nota = 'Sin manchas ni hoyos. Leve desgaste en el número.',
--   axila_cm = 49, largo_cm = 70, manga_cm = 21 where id = 123;

-- Ejemplo: elegir la "Pieza de la semana" (si ninguna está marcada, sale la más reciente con dorsal)
-- update jerseys set destacado = false;
-- update jerseys set destacado = true where id = 123;

-- 2) Encargos ("¿No está el que buscas? Te lo conseguimos")
create table if not exists encargos (
  id         bigint generated always as identity primary key,
  busqueda   text not null check (char_length(busqueda) between 2 and 120),
  talla      text check (char_length(talla) <= 12),
  nombre     text check (char_length(nombre) <= 80),
  whatsapp   text not null check (whatsapp ~ '^[0-9]{10,15}$'),
  atendido   boolean not null default false,
  created_at timestamptz not null default now()
);

alter table encargos enable row level security;

-- Cualquier visitante puede CREAR un encargo, pero nadie puede leerlos desde la página.
-- Los revisas en Supabase > Table Editor > encargos.
drop policy if exists "encargos_insert_publico" on encargos;
create policy "encargos_insert_publico" on encargos
  for insert to anon, authenticated
  with check (atendido = false);
