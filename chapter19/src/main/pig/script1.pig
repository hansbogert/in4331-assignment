movies = load 'title-and-actor.txt'
as (title: chararray, actor:chararray, year: chararray, role: chararray);
result = FOREACH (GROUP movies BY title)  
         GENERATE group, movies.(actor, role);
dump result;
