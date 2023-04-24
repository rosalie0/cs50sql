--In 6.sql, write a SQL query that lists the names of songs that are by Post Malone.
--Your query should output a table with a single column for the name of each song.
--You should not make any assumptions about what Post Malone's artist_id is.
SELECT "name" from "songs"
  WHERE "artist_id"
  IN (
    -- this returns the id of Post Malone
    SELECT "id" from "artists" WHERE "name" = 'Post Malone'
    );