movies = load 'director-and-title.txt'
as (director: chararray, title:chararray, year: chararray);
result = FOREACH (GROUP movies BY director)  
         GENERATE group, movies.title;
dump result;
