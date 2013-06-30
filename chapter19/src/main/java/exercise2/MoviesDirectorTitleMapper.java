package exercise2;

import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

public class MoviesDirectorTitleMapper extends
		Mapper<LongWritable, Text, NullWritable, Text> {

	@Override
	public void map(LongWritable key, Text value1, Context context)
			throws IOException, InterruptedException {

		String xmlString = value1.toString();
		SAXBuilder builder = new SAXBuilder();
		Reader in = new StringReader(xmlString);
		String value = "";
		try {

			Document doc = builder.build(in);
			Element root = doc.getRootElement();

			String title = root.getChild("title").getTextTrim();

			Element director = root.getChild("director");
			String directorName = director.getChild("first_name").getTextTrim() 
					+ " " 
					+ director.getChild("last_name").getTextTrim();

			String year = root.getChild("year").getTextTrim();
			
			value = directorName + "\t" + title + "\t" + year;

			
			context.write(NullWritable.get(), new Text(value));
		} catch (JDOMException ex) {
			Logger.getLogger(MoviesTitleActorMapper.class.getName()).log(
					Level.SEVERE, null, ex);
		} catch (IOException ex) {
			Logger.getLogger(MoviesTitleActorMapper.class.getName()).log(
					Level.SEVERE, null, ex);
		}
	}
}
