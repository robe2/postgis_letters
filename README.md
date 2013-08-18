postgis_letters
===============

A PostgreSQL extension to allow converting letters to PostGIS geometries

This extension comes packaged with one set of fonts kankin. http://fontfabric.com/kankin-free-font/
 which was converted to SVG using Batik and then converted to postgis geometry. 
 Many thanks to Bruce Rindahl for providing the prebuilt font geometries.

## Build/Install ##
### Requirements ###
- PostgreSQL 9.1+
- PostGIS 2.0+
- Posix shell for building (e.g. Linux/Unix/mingw/cygwin)
  This is only needed to rebuilt the .sql files in sql folder
  
### Build ###  
make

# Install ##
 - copy the contents of sql folder to your PostgreSQL share/extension folder
 -  If you installed PostGIS without extension on 9.1 (because you did not compile with raster) 
    just take out the requires line in postgis_letters.control
 - in database you want to use it in at psql prompt type
 `CREATE EXTENSION postgis_letters;`

### Usage ###
Test by running these queries:
or queries in article: http://www.postgresonline.com/article_pfriendly/302.html

 - Simple just puts circle centered about ST_Point(0,0) and 100 units in height
`SELECT ST_LettersAsGeometry('Circle', 'kankin');`

 - More complex inscribes circle in a circle rotated -
 - requires PostGIS 2.0+
 With cte As (SELECT ST_LettersAsGeometry('Postgres+PostGIS=cewl', 'kankin', 0, 150, ST_Point(10,2)) As geom)
 `SELECT i, ST_rotate(geom,pi()/4*i, ST_Point(10,2))
    FROM cte cross join generate_series(1,8) i
  UNION ALL
  SELECT 9, ST_Boundary(ST_Buffer(ST_Point(10,2), 1000));`
