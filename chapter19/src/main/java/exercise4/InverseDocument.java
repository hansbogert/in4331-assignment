package exercise5;

import java.io.IOException;
import java.util.*;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.FileSplit;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class InverseDocument {

    public static class Map extends Mapper<LongWritable, Text, Text, Text> 
    {
        @Override
        public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException 
        {
            String fileName = ((FileSplit) context.getInputSplit()).getPath().getName();
            String line = value.toString();
            StringTokenizer tokenizer = new StringTokenizer(line);
            Text word = new Text();
            while (tokenizer.hasMoreTokens()) 
            {
                word.set(normalize(tokenizer.nextToken()));
                context.write(word, new Text(fileName + ":" + 1));
            }
        }
        
        /**
         * Normalizes an input token for use in the index
         * @param input
         * @return 
         */
        private static String normalize(String input)
        {
            String result = input.replaceAll("[.,;'\":]", "");
            return result.toLowerCase();
        }
    }
    
    public static class Combine extends Reducer<Text, Text, Text, Text> 
    {
        /**
         * 
         * @param key a word
         * @param values number of occurrences of the word documents, such as 2:5,3:2 for 5 occurrences in document 2 and 2 in document 3
         * @param output
         * @param reporter
         * @throws IOException 
         */
        @Override
        protected void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException 
        {
            HashMap<String, Integer> counts = new HashMap<String, Integer>();
            for (Text value : values) 
            {
                String stringVal = value.toString();
                System.out.println(key + ": " + stringVal);
                String[] perDoc = stringVal.split(",");
                for (String val : perDoc)
                {
                    String[] parts = val.split(":");
                    String fileName = parts[0];
                    int numOccurrences = Integer.valueOf(parts[1]);
                    if (!counts.containsKey(fileName))
                    {
                        counts.put(fileName, numOccurrences);
                    }
                    else
                    {
                        int newAmount = counts.get(fileName) + numOccurrences;
                        counts.put(fileName, newAmount);
                    }
                }
            }
            writeOutput(key, context, counts);
        }
        
        /**
         * Write the output in the same format as the input so that the Reducer can still parse it
         * @param key
         * @param context
         * @param counts
         * @throws IOException
         * @throws InterruptedException 
         */
        protected void writeOutput(Text key, Context context, HashMap<String,Integer> counts) throws IOException, InterruptedException
        {
            Text finalResult = new Text();
            
            for (String s : counts.keySet())
            {
                int occurrences = counts.get(s);
                finalResult.set(finalResult.toString() + s + ":" + occurrences + ",");
            }
            
            context.write(key, finalResult);
        }
    }

    public static class Reduce extends Combine 
    {
        /**
         * Write the total frequency along with the idf for the final output
         * @param key
         * @param context
         * @param counts
         * @throws IOException
         * @throws InterruptedException 
         */
        @Override
        protected void writeOutput(Text key, Context context, HashMap<String,Integer> counts) throws IOException, InterruptedException 
        {
            int totalOccurrences = 0;
            int totaldocs = context.getConfiguration().getInt("totalNumDocs", counts.keySet().size());
            
            Text finalResult = new Text();
            
            for (String s : counts.keySet())
            {
                int occurrences = counts.get(s);
                totalOccurrences += occurrences;
                finalResult.set(finalResult.toString() + s + ":" + occurrences + "; ");
            }
            
            double div = (double) totaldocs / (double) counts.keySet().size();
            double idf = Math.log(div);
            finalResult.set("total_tf:" + totalOccurrences + "; idf:" + idf + "; " + finalResult.toString());
            
            context.write(key, finalResult);
        }
    }

    public static void main(String[] args) throws Exception 
    {
        if (args.length != 2)
        {
            System.err.println("Usage: InverseDocument <inputdir> <outputdir>"); 
            System.exit(2);
        }
        Path userInputPath = new Path(args[0]);
        Path userOutputPath = new Path(args[1]);
        
        Configuration conf = new Configuration();
        
        FileSystem fs = FileSystem.get(conf);
        // Remove the user's output path
        if (fs.exists(userOutputPath))
        {
            fs.delete(userOutputPath, true);
        }
        
        // Count total number of documents for use in idf
        final int numberOfUserInputFiles = fs.listStatus(userInputPath).length;
        conf.setInt("totalNumDocs", numberOfUserInputFiles);
        
        Job job = new Job(conf, "inversedocument");

        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);
        job.setMapperClass(InverseDocument.Map.class);
        job.setCombinerClass(InverseDocument.Combine.class);
        job.setReducerClass(InverseDocument.Reduce.class);
        
        FileInputFormat.addInputPath(job, userInputPath);
        FileOutputFormat.setOutputPath(job, userOutputPath);
        
        job.waitForCompletion(true);
    }
}
