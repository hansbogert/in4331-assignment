<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Welcome extends CI_Controller {

	/**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/welcome
	 *	- or -  
	 * 		http://example.com/index.php/welcome/index
	 *	- or -
	 * Since this controller is set as the default controller in 
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/welcome/<method_name>
	 * @see http://codeigniter.com/user_guide/general/urls.html
	 */

	public function index()
	{
		$this->load->view('search_page');
	}

	public function results()
	{
		$keyword = $this->input->post('metadata');
		if ($keyword) 
		{
			$xmlobj = simplexml_load_file("http://localhost:8080/exist/rest/db/music/query.xq?term=".$keyword);
			foreach ($xmlobj as $entry) 
			{
				$split = explode('/', $entry);
				echo "Result: ".anchor('getsheet/'.$split[3])."<br />";
			}
		}
	}

	public function getsheet($file='')
	{
		if (!file_exists('music/'.$file) || filesize('music/'.$file) == 0)
		{
			$xmlFile = file_get_contents("http://localhost:8080/exist/rest/db/music/".$file);
			var_dump($xmlFile);
			if (write_file('music/'.$file, $xmlFile)) {
				echo 'successfully saved xml';
			}
		}

		$split = explode('.', $file);
		$fileName = $split[0];

		if (!file_exists('music/'.$fileName.'.ly'))
		{
			exec('musicxml2ly -m -o music/'.$fileName.' -v music/'.$file);
			echo 'ly file generated';
		}

		if (!file_exists('music/'.$fileName.'.pdf'))
		{
			exec('lilypond -o music -V music/'.$fileName.'.ly');
			echo 'pdf generated';
		}
	}
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */