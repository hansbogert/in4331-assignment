$(init)
function init()
{
    $('#form').change(updateList)
    $("input[type='text']").change(updateList());
    console.log("starting")
    updateList();
}

function getXml(query, presenter)
{
    proxyUrl="ba-simple-proxy.php?mode=native&url="
    urlQuery = 'http://localhost:8081/exist/rest/db/movies-query?_query='+query;
    getUrl = proxyUrl+urlQuery;
    console.log("request: "+ getUrl )
    $.get(getUrl, presenter);
}

function presentList(data)
{
    htmlList = $('<ul></ul>')
    movies = $(data).find('movie');
    console.log(movies);
    movies.each(function(index,elem){
	htmlList.append('<li>'+ $(elem).children('title').text()+' - '+$(elem).children('year').text()+'</li>' )
    })
    $('#results').html(htmlList)
}

function updateList()
{
    getXml(formListQuery(), presentList )
}



function formListQuery()
{
    console.log('still alive')
    query = "//movie[contains(title, '" + $('#title').val()+"') \
and contains(genre,'"+$('#genre').val()+"') \
and contains(year,'"+$('#year').val()+"')]";
    console.log(query);
    return query;
}

function retrieveMovie(title, presenter)
{
    query = "//movie[title = '+title+']";
    getXml(query, presenter);
}
