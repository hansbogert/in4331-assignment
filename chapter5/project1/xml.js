$(init)
function init(){
    $('#form').change(updateList)
    $("input[type='text']").change(updateList());
    retrieveActors(presentActors)
    retrieveDirectors(presentDirectors)
    console.log("starting")
    updateList();
}

function getFullName(actorNode){
	return $.trim($(actorNode).find('first_name').text()) +" "+ $.trim($(actorNode).find('last_name').text())
}

function presentActors(data){
    presentArtist(data,"actor", "#actorList");
}

function presentDirectors(data){
    presentArtist(data, "director", "#directorList");
}

function presentArtist(data, type, where){
    artist = $(data).find(type);
    artist.each(function(index,elem){
	
	$(where).append("<option \
data-first-name='"+$(elem).find('first_name').text()+"' \
data-last-name='"+$(elem).find('last_name').text()+"' \
 value=\""+getFullName(elem)+"\">"+ getFullName(elem) +"</option>");
    });
}

function getXml(query, presenter){
    proxyUrl="ba-simple-proxy.php?mode=native&url="
    urlQuery = 'http://217.23.11.60:8180/exist/rest/db/movies?_howmany=99%26_query='+query;
    getUrl = proxyUrl+urlQuery;
    //console.log("request: "+ getUrl )
    $.get(getUrl, presenter);
}

function presentList(data)
{
    htmlList = $('<ul></ul>')
    movies = $(data).find('movie');
    movies.each(function(index,elem){
	htmlList.append('<li class="movie">'+ $(elem).children('title').text()+' - '+$(elem).children('year').text()+'<div class="summary">'+ $(elem).children('summary').text() +'</div></li>' )
    })
    $('#results').html(htmlList)
    $('.movie').click(showSummary)
}
function showSummary(){
    $('.summary').hide();
    $(this).children('div').show();
}

function updateList(){
    getXml(formListQuery(), presentList )
}



function formListQuery(){

    query = "doc('movies.xml')//movie[contains(title, '" + $('#title').val()+"') \
and contains(genre,'"+$('#genre').val()+"')";

    if($('#keyword').val().length > 0)
	query += "and contains(lower-case(summary),'"+$('#keyword').val()+"') ";
    if($('#actorList').val().length > 0){

	option =  $('#actorList option:selected');
	firstName = option.data('first-name');
	lastName = option.data('last-name');
	query += "and (actor/first_name = '"+firstName+"' and actor/last_name = '"+lastName+"')";
    }

    if($('#directorList').val().length > 0){
        option =  $('#directorList option:selected');
        firstName = option.data('first-name');
        lastName = option.data('last-name');
	query += "and (director/first_name = '"+firstName+"' and director/last_name = '"+lastName+"')";
    }

    query += "and contains(year,'"+$('#year').val()+"')]";
    return query;
}

function retrieveActors(presenter){
    query = "doc('movies.xml')//actor";
    getXml(query, presenter)
}

function retrieveDirectors(presenter){
    query = "doc('movies.xml')//director";
    getXml(query,presenter);
}
