package org.test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Arrays;

import org.project.DatasetAccess;



public class TestDataSet {

	public static void main(String[] args) throws IOException {
		String csvPath = "C:/Users/user/Desktop/ml-latest-small";
		String readCSV = csvPath+"/dataset.csv";
		 BufferedReader br = null;
	        String line = "";
	        String cvsSplitBy = ",";
	       int id=0;
	        try {
	        	DatasetAccess access = new DatasetAccess();
	        	br = new BufferedReader(new FileReader(readCSV));
	            while ((line = br.readLine()) != null) {
	            	// use comma as separator
	                String[] data = line.split(cvsSplitBy);
	                String title=data[1];
	                String genre = data[2];
	                String year = data[3];
	                access.insertData(title,genre,year);
	                System.out.println(id);
	                id++;
	              }

	        } catch (FileNotFoundException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        } catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
	            if (br != null) {
	                try {
	                    br.close();
	                    
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	            }
	        }
	       

		

	}

}
