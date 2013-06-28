#!/bin/bash
function download
{
	wget $1
}

if [ ! -f dblp.dtd ]
then
	download http://dblp.uni-trier.de/xml/dblp.dtd
fi

if [ ! -f dblp.xml ] && [ ! -f dblp.xml.gz ]
then
	download http://dblp.uni-trier.de/xml/dblp.xml.gz && gunzip dblp.xml.gz
fi

if [ ! -f author-small.txt ]
then
	download http://webdam.inria.fr/Jorge/files/author-small.txt
fi

if [ ! -f author-medium.txt ]
then
	download http://webdam.inria.fr/Jorge/files/author-medium.txt
fi

if [ ! -f proceedings-small.txt ]
then
	download http://webdam.inria.fr/Jorge/files/proceedings-small.txt
fi

if [ ! -f proceedings-medium.txt ]
then
	download http://webdam.inria.fr/Jorge/files/proceedings-medium.txt
fi

if [ ! -f movies.xml ]
then
	download http://webdam.inria.fr/Jorge/files/movies.xml
fi

