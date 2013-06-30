directors = load 'director-and-title.txt'
as (director: chararray, title:chararray, year: chararray);

actors = load 'title-and-actor.txt'
as (title: chararray, actor:chararray, year: chararray, role: chararray);

result = foreach (cogroup directors by title, actors by $0)
	generate group, flatten(directors.director), actors.actor;

dump result;
