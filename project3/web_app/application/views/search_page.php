<!DOCTYPE html>
<html>
  <head>
    <script src="http://code.jquery.com/jquery-2.0.0.min.js" type="text/javascript"> </script>
    <title>Music browser</title>
  </head>
  <body>
    <?php echo form_open('results');?>
      <input type="text" name="metadata" placeholder="metadata" id="metadata"/><br/>
      <input type="text" name="lyrics" placeholder="lyrics" id="lyrics" /><br/>
      <input type="submit" value="Search" />
    </form>
  </body>
</html>
