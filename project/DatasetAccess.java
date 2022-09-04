package org.project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DatasetAccess {
	
	Connection con;
	public DatasetAccess() throws ClassNotFoundException, SQLException{
	con = DBConnect.getconn();
	}
	public void insertData(String title, String genre, String year) throws SQLException {
		String query = "Insert into movie_data (Title,Genre,Year) values (?,?,?)";
		PreparedStatement pstmt = con.prepareStatement(query);
		pstmt.setString(1, title);
		pstmt.setString(2, genre);
		pstmt.setString(3, year);
		pstmt.execute();
		
	}
	public List<String> getGenreList() throws SQLException {
		Statement stmt = con.createStatement();
		List<String> genreList = new ArrayList<>();
		ResultSet rs = stmt.executeQuery("select distinct(Genre) from movie_data");
		while(rs.next()){
			genreList.add(rs.getString(1));
		}
		return genreList;
	}
	public List<Movie> getMoviesList(String genre) throws SQLException {
		Statement stmt = con.createStatement();
		List<Movie> movieList = new ArrayList<>();
		ResultSet rs = stmt.executeQuery("select id,Title,Genre,Year from movie_data where genre='"+genre+"'");
		while(rs.next()){
			Movie movie = new Movie();
			movie.setMovieId(Integer.toString(rs.getInt(1)));
			movie.setName(rs.getString(2));
			movie.setGenre(rs.getString(3));
			movie.setYear(rs.getString(4));
			movieList.add(movie);
		}
		return movieList;
	}
	public Movie getMovieDetails(String id) throws SQLException {
		Statement stmt = con.createStatement();
		Movie movie = new Movie();
		ResultSet rs = stmt.executeQuery("select id,Title,Genre,Year from movie_data where id='"+id+"'");
		while(rs.next()){
			movie.setMovieId(id);
			movie.setName(rs.getString(2));
			movie.setGenre(rs.getString(3));
			movie.setYear(rs.getString(4));
		}
		return movie;
	}
	public void insertUserActivity(Movie movie, String string) throws SQLException {
		int activityId = 1;
		Statement stmt = con.createStatement();
		ResultSet rs2 = stmt.executeQuery("select activity_id from user_history where movie_id = '"+movie.getMovieId()+"' and user_id='"+string+"'");
		if(!(rs2.next())){
		ResultSet rs = stmt.executeQuery("select max(activity_id) from user_history where user_id='"+string+"'");
		if(rs.next()){
			System.out.println("in if");

				int num=rs.getInt(1);
				System.out.println(num);
				if(num>0 && num<30){
					activityId = num+1;
				}
				else if(num==30){
					stmt.execute("delete from user_history where user_id = '"+string+"' and activity_id = '1'");
					activityId=1;
				}

		}
		else{
			System.out.println("in else");
			activityId=1;
		}
		stmt.execute("insert into user_history (user_id,activity_id,movie_id,movie_title,movie_genre,movie_year) values('"+string+"','"+activityId+"','"+movie.getMovieId()+"','"+movie.getName()+"','"+movie.getGenre()+"','"+movie.getYear()+"')");
		}
	}
	public User getUserDetails(String string) throws SQLException {
		Statement stmt = con.createStatement();
		User user = new User();
		ResultSet rs = stmt.executeQuery("select user_id,name,email,gender,age from user_details where user_id='"+string+"'");
		while(rs.next()){
			user.setId(string);
			user.setName(rs.getString(2));
			user.setEmail(rs.getString(3));
			user.setGender(rs.getString(4));
			user.setAge(rs.getString(5));
		}
		return user;
	}
	public List<String> getGenreListBasedOnAgeGender(String ageGroup, String gender) throws SQLException {
		Statement stmt = con.createStatement();
		List<String> genreList = new ArrayList<>();
		ResultSet rs = stmt.executeQuery("select genre from genre_filter where age_group='"+ageGroup+"' and gender = '"+gender+"'");
		while(rs.next()){
			genreList.add(rs.getString(1));
		}
		return genreList;
	}
	public List<Movie> getStaticRecommendations(List<String> genreListBasedOnAgeGender, String age) throws SQLException {
		Statement stmt = con.createStatement();
		List<Movie> list = new ArrayList<>();
		int age1 = Integer.parseInt(age);
		int period=1;
		int currYear = Calendar.getInstance().get(Calendar.YEAR);
		int year1=currYear;
		System.out.println(year1);
		if(age1>20){
			period=age1-20;
			System.out.println(period);
			year1=currYear-period;
			System.out.println(year1);
		}
		for(int i=0;i<genreListBasedOnAgeGender.size();i++){
			ResultSet rs = stmt.executeQuery("select id,Title,Genre,Year from movie_data where Genre = '"+genreListBasedOnAgeGender.get(i)+"' and year in ('"+(year1-2)+"','"+(year1-1)+"','"+year1+"','"+(year1+1)+"','"+(year1+2)+"')");
			while(rs.next()){
				Movie movie = new Movie();
				movie.setMovieId(Integer.toString(rs.getInt(1)));
				movie.setName(rs.getString(2));
				movie.setGenre(rs.getString(3));
				movie.setYear(rs.getString(4));
				list.add(movie);
			}
		}
		return list;
	}
	public List<String> getGenreListBasedOnHistory(String string) throws SQLException {
		Statement stmt = con.createStatement();
		List<String> list = new ArrayList<>();
		ResultSet rs = stmt.executeQuery("select distinct(movie_genre) from user_history where user_id = '"+string+"'");
		while(rs.next()){
			list.add(rs.getString(1));
		}
		return list;
	}
	public int getDisplayCountForGenre(String string, String id) throws SQLException {
		Statement stmt = con.createStatement();
		int totalCount = 0;
		int reqCount = 0;
		ResultSet rs = stmt.executeQuery("select count(movie_id) from user_history where user_id = '"+id+"'");
		while(rs.next()){
			totalCount=rs.getInt(1);
		}
		ResultSet rs2 = stmt.executeQuery("select count(movie_id) from user_history where user_id = '"+id+"' and movie_genre='"+string+"'");
		while(rs2.next()){
			reqCount = rs2.getInt(1);
		}
		System.out.println(totalCount);
		System.out.println(reqCount);
		float percent = (float) (((float)reqCount/(float)totalCount)*100.0);
		//int percent = (int) ((int)(reqCount/totalCount)*100);
		System.out.println(percent);
		int finalCount = (int) ((percent/100)*13);
		System.out.println(finalCount);
		return finalCount;
	}
	public List<Movie> getMovieListForGenreHistory(String string,String id) throws SQLException {
		Statement stmt = con.createStatement();
		List<Movie> list = new ArrayList<>();
		List<String> yearList = new ArrayList<>();
		ResultSet rs = stmt.executeQuery("select distinct(movie_year) from user_history where user_id = '"+id+"' and movie_genre='"+string+"'");
		while(rs.next()){
			yearList.add(rs.getString(1));
		}
		for(int i=0;i<yearList.size();i++){
			int count=0;
			ResultSet rs2 = stmt.executeQuery("select id,title,genre,year from movie_data where genre='"+string+"'  and year in ('"+(Integer.parseInt(yearList.get(i))-1)+"','"+(Integer.parseInt(yearList.get(i))+1)+"','"+yearList.get(i)+"')");
			while(rs2.next()){
				Movie movie = new Movie();
				movie.setMovieId(rs2.getString(1));
				movie.setName(rs2.getString(2));
				movie.setGenre(rs2.getString(3));
				movie.setYear(rs2.getString(4));
				list.add(movie);
				count++;
			}
			if(count<2){
				ResultSet rs3 = stmt.executeQuery("select id,title,genre,year from movie_data where genre='"+string+"'  and year in ('"+(Integer.parseInt(yearList.get(i))-2)+"','"+(Integer.parseInt(yearList.get(i))+2)+"','"+yearList.get(i)+"')");
				while(rs3.next()){
					Movie movie = new Movie();
					movie.setMovieId(rs3.getString(1));
					movie.setName(rs3.getString(2));
					movie.setGenre(rs3.getString(3));
					movie.setYear(rs3.getString(4));
					list.add(movie);
				}
			}
		}
		return list;
	}
	public void registerUser(User user) throws SQLException {
		Statement stmt = con.createStatement();
		stmt.execute("Insert into user_details (name,email,password,gender,age) values ('"+user.getName()+"','"+user.getEmail()+"','"+user.getPassword()+"','"+user.getGender()+"','"+user.getAge()+"')");
	}
	public User getUserDetailsLogin(String email, String password) throws SQLException {
		Statement stmt = con.createStatement();
		User user = new User();
		ResultSet rs = stmt.executeQuery("select user_id,name,email,gender,age from user_details where email = '"+email+"' and password = '"+password+"'");
		while(rs.next()){
			user.setId(Integer.toString(rs.getInt(1)));
			user.setName(rs.getString(2));
			user.setEmail(rs.getString(3));
			user.setGender(rs.getString(4));
			user.setAge(rs.getString(5));
		}
		return user;
	}
	public List<String> getMovieListForGenre(String string) throws SQLException {
		Statement stmt = con.createStatement();
		List<String> list = new ArrayList<>();
		ResultSet rs = stmt.executeQuery("select movie_title from user_history where movie_genre = '"+string+"'");
		while(rs.next()){
			list.add(rs.getString(1));
		}
		return list;
	}
	public Movie getMovieDetailsByName(String string) throws SQLException {
		Statement stmt = con.createStatement();
		Movie movie = new Movie();
		ResultSet rs = stmt.executeQuery("select movie_id,movie_title,movie_genre,movie_year from user_history where movie_title like '"+string+"'");
		while(rs.next()){
			movie.setMovieId(rs.getString(1));
			movie.setName(rs.getString(2));
			movie.setGenre(rs.getString(3));
			movie.setYear(rs.getString(4));
		}
		return movie;
	}
	
	
	
}
