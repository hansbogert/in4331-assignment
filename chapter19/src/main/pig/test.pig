-- Load records from the journal-small.txt file (tab separated) 
articles = load 'dblp/proceedings-small.txt'
as (year: chararray, journal:chararray, title: chararray) ; sr_articles = filter articles BY journal=='3DIM';
year_groups = group sr_articles by year;
avg_nb = foreach year_groups generate group, COUNT(sr_articles.title);
dump avg_nb;
