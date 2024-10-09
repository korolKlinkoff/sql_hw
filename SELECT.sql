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

-- Название треков, которые содержат слово «мой» или «my». (пересечение массивов)

select name from songs
where string_to_array(lower(name), ' ') && ARRAY['my', 'мой'];

-- Название треков, которые содержат слово «мой» или «my». (regex)

select name from songs
where name ~* '(?:^|\W)(my|мой)(?:$|\W)';

-- Количество исполнителей в каждом жанре.

select genre_id, count(*) from genreartists
group by genre_id;

-- Количество треков, вошедших в альбомы 2019–2020 годов.

select count(*) from songs
where album in (select id from albums where year between 2019 and 2020);

-- Средняя продолжительность треков по каждому альбому.

select avg(length) from songs
group by album;

-- Все исполнители, которые не выпустили альбомы в 2020 году. (доработанное изначальное решение)

select distinct name from artists
where id not in (
    select artist_id from albumartists
    where album_id in (
        select distinct id from albums
        where year = 2020
    )
);

-- Все исполнители, которые не выпустили альбомы в 2020 году. (решение в соответствии с примером)

SELECT name
FROM artists
WHERE name NOT IN (
    SELECT artists.name
    FROM artists
    JOIN albumartists aa ON id = aa.artist_id
    JOIN albums a ON a.id = aa.album_id
    WHERE a.year = 2020
);

-- Названия сборников, в которых присутствует конкретный исполнитель (Powerwolf) (доработанное изначальное решение).

select name from collections
where id in (
    select distinct collection_id from collectionsongs
    where song_id in (
        select id from songs where album in (
            select album_id from albumartists where artist_id = 1
        )
    )
);

-- Названия сборников, в которых присутствует конкретный исполнитель (Powerwolf) (решение в соответствии с примером).

SELECT DISTINCT coll.name
FROM collections coll
JOIN collectionsongs colls ON coll.id = colls.collection_id
JOIN songs ON colls.song_id = songs.id
JOIN albumartists aa ON songs.album = aa.album_id
JOIN artists art ON aa.artist_id = art.id
WHERE art.name = 'powerwolf';

-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра. (доработанное изначальное решение)

select name from albums
where id in (
    select album_id from albumartists
    where artist_id in (
        select artist_id from (
            select distinct artist_id, count(*) genrecount from genreartists
            group by artist_id
        ) aa
        where genrecount > 1
    )
);

-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра. (решение в соответствии с примером)

SELECT DISTINCT name
FROM albums alb
JOIN albumartists aa ON alb.id = aa.album_id
JOIN genreartists ga ON aa.artist_id = ga.artist_id
GROUP BY alb.id, ga.artist_id
HAVING COUNT(*) > 1;

-- Наименования треков, которые не входят в сборники.

select name from songs
where id not in (
    select song_id from collectionsongs
);

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности
-- трек, — теоретически таких треков может быть несколько. (доработанное изначальное решение)

select distinct name from artists
where id in (
    select artist_id from albumartists
    where album_id in (
        select id
        from albums
        where id in (
            select album
            from songs
            where length = (
                select min(length)
                from songs
            )
        )
    )
);

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности
-- трек, — теоретически таких треков может быть несколько. (решение в соответствии с примером)

SELECT art.name /* Имена исполнителей */
FROM artists art /* Из таблицы исполнителей */
JOIN albumartists aa ON art.id = aa.artist_id /* Объединяем с таблицей между исполнителями и альбомами */
JOIN songs ON songs.album = aa.album_id /* Объединяем с таблицей треков */
WHERE length = ( /* Где длительность трека равна вложенному запросу */
    SELECT MIN(length) FROM songs /* Получаем минимальную длительность из таблицы треков */
    JOIN albumartists aa ON songs.album = aa.album_id /* Объединяем с промежуточной таблицей между альбомами и исполнителями на основе айди альбомов */
);

-- Названия альбомов, содержащих наименьшее количество треков. (изначальное решение)

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

-- Названия альбомов, содержащих наименьшее количество треков. (решение в соответствии с примером)

SELECT alb.name
FROM albums alb JOIN songs ON alb.id = songs.album
GROUP BY alb.id
HAVING COUNT(*) = (
    SELECT COUNT(id) FROM songs
    GROUP BY album
    ORDER BY 1
    LIMIT 1
);
