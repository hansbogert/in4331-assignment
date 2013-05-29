<!DOCTYPE html>
<html>
  <head>
    <title>Movie browser!</title>
    <script src="http://code.jquery.com/jquery-2.0.0.min.js" type="text/javascript"></script>
    <script src="xml.js" type="text/javascript"> </script>
  </head>
  <body>
    <form id="form">
      <input type="text" name="title" value="title" id="title"/><br/>
      <select name="genre" id="genre">
	<option value="">Genre!</option>
	<option value="Action">Action</option>
	<option value="Crime">Crime</option>
	<option value="Drama">Drama</option>
	<option value="Western">Western</option>
      </select><br/>
      <input type="text" name="year" value="" placeholder="year" id="year" />
      <input type="button" value="search" onclick="updateList()">
    </form>
    <div id="results">
      
    </div>
  </body>
</html>
