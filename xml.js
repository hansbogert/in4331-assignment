function getXml(query)
{
    proxyUrl="http://localhost/ba-simple-proxy.php?mode=native&url="
    urlQuery = 'http://localhost:8081/exist/rest/db/movies-query?_query='+query;
    getUrl = proxyUrl+urlQuery;
    console.log("request: "+urlQuery )
    $.get(getUrl, function(data){$('#results').html($(data).find('title'))});
}

$(getXml("//title"))

function formQuery()
{
    query = "//movie/title/[contains(node(), " + $('#title').value()+" + ) ] +";
    getXml(query);
}
