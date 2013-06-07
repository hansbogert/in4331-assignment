<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="bootstrap.min.css"/>
    <title>Movie browser!</title>
    <script src="http://code.jquery.com/jquery-2.0.0.min.js" type="text/javascript"></script>
    <script src="xml.js" type="text/javascript"> </script>
  </head>
  <body>
    <form id="form">
      <input type="text" name="title" placeholder="title" id="title"/><br/>
      <select name="genre" id="genre">
	<option value="">Genre!</option>
	<option value="Action">Action</option>
	<option value="Crime">Crime</option>
	<option value="Drama">Drama</option>
	<option value="Western">Western</option>
      </select><br/>
      <input type="text" name="year" value="" placeholder="year" id="year" /><br/>
      <input type="text" name="keyword" value="" placeholder="summary keyword" id="keyword" /><br/>
      <select id="actorList" >
	<option value="" >
	  Choose actor
	</option>
      </select>
      <select id="directorList" >
	<option value="" >
	  Choose director
	</option>
      </select>
      <input type="button" value="search" onclick="updateList()">
    </form>
    <div id="results">
      
    </div>
  </body>
</html>
