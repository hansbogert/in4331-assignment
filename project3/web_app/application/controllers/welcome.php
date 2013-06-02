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
		$results = '';
		$keyword = $this->input->post('metadata');
		if ($keyword) 
		{
			// Load search results from Exist
			$xmlobj = simplexml_load_file("http://localhost:8080/exist/rest/db/music/query.xq?term=".$keyword);
			// Generate result list
			foreach ($xmlobj as $entry) 
			{
				$split = explode('/', $entry->uri);
				$reference = '<tr><td>';
				if ($entry->composer != '')
					$reference .= $entry->composer;
				else
				{
					$filename = explode('.', $split[3]);
					$reference .= $filename[0];
				}
				$reference .= '</td>';
				if ($entry->title != '')
					$reference .= '<td>'.$entry->title.'</td>';
				$results .= $reference.'<td>'.anchor('getsheet/'.$split[3].'/pdf', 'pdf').'</td>';
				$results .= '<td>'.anchor('getsheet/'.$split[3].'/midi', 'midi').'</td></tr>';
			}
		}
		$this->load->view('search_page', array('results' => $results));
	}

	/**
	 * Retrieve a piece of music from the given XML resource
	 * @param  string $file name of the XML file
	 * @param  string $type filetype to return
	 */
	public function getsheet($file='', $type='pdf')
	{
		// Download XML file if it wasn't already
		if (!file_exists('music/'.$file) || filesize('music/'.$file) == 0)
		{
			$xmlFile = file_get_contents("http://localhost:8080/exist/rest/db/music/".$file);
			if (write_file('music/'.$file, $xmlFile)) {
				echo 'successfully saved xml';
			}
		}

		$split = explode('.', $file);
		$fileName = $split[0];

		// Generate .ly, .pdf and .mid files if this wasn't done already
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

		// Present the requested file type
		if ($type == 'pdf') 
		{
			redirect('music/'.$fileName.'.pdf');
		}
		elseif ($type == 'midi')
		{
			redirect('music/'.$fileName.'.mid');
		}
	}
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */