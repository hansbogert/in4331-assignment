<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
    <style type="text/css">
      #container, #results
      {
        width: 500px;
        margin: auto;
        margin-top: 30px;
      }
    </style>
    <title>Music browser</title>
  </head>
  <body>
    <div id="container">
    <?php echo form_open('results');?>
    <div class="input-append">
      <input type="search" name="metadata" placeholder="Search metadata" id="metadata"/>
      <button type="submit" class="btn btn-inverse">Search</button>
    </div>
    </form>
    </div>
    <div id="results">
    <?php if (isset($results)): ?>
      <table class="table table-condensed">
        <thead>
          <tr>
            <th>Composer</th>
            <th>Title</th>
            <th>PDF</th>
            <th>MIDI</th>
          </tr>
        </thead>
        <tbody>
          <?php echo $results; ?>
        </tbody>
      </table>
    <?php endif; ?>
    </div>
  </body>
</html>