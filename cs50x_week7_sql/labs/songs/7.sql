--In 7.sql, write a SQL query that returns the average energy of songs that are by Drake.
--Your query should output a table with a single column and a single row containing the average energy.
--You should not make any assumptions about what Drake's artist_id is.

-- need a SELECT to get drake's id (this is the 2nd query)
-- psuedo: select avg energy in (2nd query)

SELECT AVG("energy") FROM "songs"
  WHERE "artist_id" 
    IN (
      -- get drake's id from artist table
      SELECT "id" FROM "artists" WHERE "name" = 'Drake'
    );