# Project 1

This project is about implementing an interactive website/application
which fetches a list of movies as XML from an exist-db albeit with
filters applied (e.g. title name, year) through an xquery.

The data is fetched through jquery with a call to ba-simple-proxy.php
(in order to circumvent the cross-origin limitions of the browser)

## Setup
Copy the collection 'movies-query' into exist db, and correspondingly 
alter the javascript code if you choose to take another name. Make sure 
that in the code the proxy URLs are also correct.
