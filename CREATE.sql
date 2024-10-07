create table if not exists Genres (
    id serial primary key,
    name varchar(60) unique not null
);

create table if not exists Artists (
    id serial primary key,
    name varchar(60) not null
);

create table if not exists GenreArtists (
    genre_id integer references Genres(id) not null,
    artist_id integer references Artists(id) not null,
    constraint pk_genre_artists primary key (genre_id, artist_id)
);

create table if not exists Albums (
    id serial primary key,
    artist integer references Artists(id),
    name varchar(60) not null,
    year integer not null
);

-- create table if not exists AlbumArtists (
--     album_id integer references Albums(id) not null,
--     artist_id integer references Artists(id) not null,
--     constraint pk_album_artists primary key (album_id, artist_id)
-- );

create table if not exists Songs (
    id serial primary key,
    album integer references Albums(id) not null,
    name varchar(60) not null,
    length integer not null
);

create table if not exists Collections (
    id serial primary key,
    name varchar(60) not null,
    year integer not null
);

create table if not exists CollectionSongs (
    collection_id integer references Collections(id),
    song_id integer references Songs(id),
    constraint pk_collection_songs primary key (collection_id, song_id)
);
