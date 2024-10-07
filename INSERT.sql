-- artists

insert into artists (name)
values ('powerwolf');

insert into artists (name)
values ('sabaton');

insert into artists (name)
values ('bad omens');

insert into artists (name)
values ('keygen church');

-- genres

insert into genres (name)
values ('metal');

insert into genres (name)
values ('power metal');

insert into genres (name)
values ('electronic');

insert into genres (name)
values ('pop');

-- genre - artist

insert into genreartists (genre_id, artist_id)
values (2, 1);

insert into genreartists (genre_id, artist_id)
values (1, 1);

insert into genreartists (genre_id, artist_id)
values (1, 2);

insert into genreartists (genre_id, artist_id)
values (1, 3);

insert into genreartists (genre_id, artist_id)
values (3, 4);

-- albums

insert into albums (artist, name, year)
values (1, 'sacrement of sin', 2020);

insert into albums (artist, name, year)
values (2, 'coat of arms', 2010);

insert into albums (artist, name, year)
values (1, 'wake up the wicked', 2024);

-- songs

insert into songs (album, name, length)
values (1, 'incense & iron', 237);

insert into songs (album, name, length)
values (2, 'the final solution', 296);

insert into songs (album, name, length)
values (3, 'blessem with the blade', 167);

insert into songs (album, name, length)
values (2, 'my fake track', 140);

insert into songs (album, name, length)
values (2, 'second my track', 60);

insert into songs (album, name, length)
values (2, 'track third my', 100);

insert into songs (album, name, length)
values (3, 'salmon', 60);

-- collections

insert into collections (name, year)
values ('collection', 1984);

insert into collections (name, year)
values ('collection2', 2024);

insert into collections (name, year)
values ('collection3', 2020);

insert into collections (name, year)
values ('collection4', 2010);

-- collection - song

insert into collectionsongs (collection_id, song_id)
values (1, 1);

insert into collectionsongs (collection_id, song_id)
values (1, 2);

insert into collectionsongs (collection_id, song_id)
values (1, 3);

insert into collectionsongs (collection_id, song_id)
values (2, 4);

insert into collectionsongs (collection_id, song_id)
values (2, 5);

insert into collectionsongs (collection_id, song_id)
values (2, 6);

insert into collectionsongs (collection_id, song_id)
values (3, 2);

insert into collectionsongs (collection_id, song_id)
values (3, 5);

insert into collectionsongs (collection_id, song_id)
values (4, 6);

insert into collectionsongs (collection_id, song_id)
values (4, 3);