-- Название и продолжительность самого длительного трека.

select name, length from songs
order by length desc
limit 1;

-- Название треков, продолжительность которых не менее 3,5 минут.

select name from songs
where length >= 210
order by length desc;

-- Названия сборников, вышедших в период с 2018 по 2020 год включительно.

select name from collections
where year between 2018 and 2020;

-- Исполнители, чьё имя состоит из одного слова.

select name from artists
where name not like '% %';

-- Название треков, которые содержат слово «мой» или «my».

select name from songs
where name like '%my%' or name like '%мой%';

-- Количество исполнителей в каждом жанре.

select genre_id, count(*) from genreartists
group by genre_id;

-- Количество треков, вошедших в альбомы 2019–2020 годов.

select count(*) from songs
where album in (select id from albums where year between 2019 and 2020)
group by album;

-- Средняя продолжительность треков по каждому альбому.

select avg(length) from songs
group by album;

-- Все исполнители, которые не выпустили альбомы в 2020 году.

select distinct name from artists
where id not in (select distinct artist from albums
where year = 2020);

-- Названия сборников, в которых присутствует конкретный исполнитель (Powerwolf).

select name from collections
where id in (
    select distinct collection_id from collectionsongs
    where song_id in (
        select id from songs where album in (
            select id from albums where artist = 1
        )
    )
);

-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра.

select name from albums
where artist in (
    select artist_id from (
        select distinct artist_id, count(*) genrecount from genreartists
        group by artist_id
    ) aa
    where genrecount > 1
);

-- Наименования треков, которые не входят в сборники.

select name from songs
where id not in (
    select song_id from collectionsongs
);

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности
-- трек, — теоретически таких треков может быть несколько.

select distinct name from artists
where id in (
    select artist from albums
    where id in (
        select album from songs
        where length = (
            select min(length) from songs
        )
    )
);

-- Названия альбомов, содержащих наименьшее количество треков.

select name from albums
where id in (
    select album from (
        select album, count(*) cnt from songs
        group by album
    ) aa
    where cnt = (
        select count(*) cc from songs
        group by album
        order by cc
        limit 1
    )
);