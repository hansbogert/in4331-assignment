<?php/*
$restEndpoint = "http://localhost:8081/exist/rest/db/movies?_query=//title";
function getXml($urlQuery)
{
  $curl = curl_init();
  curl_setopt($curl, CURL_OPT_URL, $urlQuery);
  curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
  
  return curl_exec($curl);
}

function needsFilter(){
  $filters = array();
  $filters[] = 'title';
  
  foreach ($filters as $filter )
    {
      if(!empty($_GET[$filter]))
	{
	  return true;
	}
    }
  }

  if(needsFilter())
    {
      
    }*/
?>
<!DOCTYPE html>
<html>
  <head>
    <title>Movie browser!</title>
    <script src="http://code.jquery.com/jquery-2.0.0.min.js" type="text/javascript"></script>
    <script src="xml.js" type="text/javascript"> </script>
  </head>
  <body>
    <form method="GET" id="theForm" action="">
      <input type="text" name="title" value="title" id="title"/><br/>
      <select>
	<option value="">Genre!</option>
      </select>
      <input type="submit" name="send" value="search" />
    </form>
    <div id="results">
    </div>
  </body>
</html>
