<?php
   $restEndpoint = "http://localhost:8081/exist/rest/db/movies?_query=";

   function needsFilter(){
   $filters = array();
   $filters[] = 'title';
   
   foreach ($filters as $filter )
   if(!empty($filter))
   return true;
   }
?>
<html>
  <head>
    <title>Movie browser!</title>
  </head>
  <body>
    <form method="get" id="theForm" action="<?= $_SERVER['self'] ?>">
      <input type="text" name="title" value="title" /><br/>
      <select>
	<option value=""></option>
      </select>
      <input type="button" name="send" value="search" />
    </form>
  </body>
</html>
