package org.project;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import com.sun.xml.internal.ws.policy.privateutil.PolicyUtils.Collections;

public class MovieServlet extends HttpServlet{

	
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest request, HttpServletResponse response){
		String query = request.getParameter("query");
		if("Movies".equals(query)){
			try{
			HttpSession session = request.getSession(false);
			User user = new User();
			user = (User) session.getAttribute("User");
			if(user==null||"".equals(user.getId()) || user.getId()==null){
				RequestDispatcher view = request.getRequestDispatcher("jsp/index.jsp");
				view.forward(request, response);
			}
			else{
			DatasetAccess access = new DatasetAccess();
			List<String> genreList = new ArrayList<>();
			genreList = access.getGenreList();
			request.setAttribute("genreList", genreList);
			RequestDispatcher view = request.getRequestDispatcher("jsp/movies.jsp");
			view.forward(request, response);
			}
			}
			catch(Exception ex){
				ex.printStackTrace();
			}
		}
		else if("getMovies".equals(query)){
			try{
					HttpSession session = request.getSession(false);
					User user = new User();
					user = (User) session.getAttribute("User");
					if(user==null||"".equals(user.getId()) || user.getId()==null){
						RequestDispatcher view = request.getRequestDispatcher("jsp/index.jsp");
						view.forward(request, response);
					}
					else{
				String genre = request.getParameter("genre");
				DatasetAccess access = new DatasetAccess();
				List<String> genreList = new ArrayList<>();
				genreList = access.getGenreList();
				List<Movie> movieList = new ArrayList<>();
				movieList = access.getMoviesList(genre);
				request.setAttribute("genreList", genreList);
				request.setAttribute("movieList", movieList);
				request.setAttribute("genre", genre);
				RequestDispatcher view = request.getRequestDispatcher("jsp/movies.jsp");
				view.forward(request, response);
					}
			}
			catch(Exception ex){
				ex.printStackTrace();
			}
		}
		else if("Home".equals(query)){
			try{
				HttpSession session = request.getSession(false);
				User user = new User();
				user = (User) session.getAttribute("User");
				if(user==null||user==null || "".equals(user.getId())){
					RequestDispatcher view = request.getRequestDispatcher("jsp/index.jsp");
					view.forward(request, response);
				}
				else{
				DatasetAccess access = new DatasetAccess();
				
				int age=Integer.parseInt(user.getAge());
				String ageGroup="";
				if(age>0 && age<11){
					ageGroup = "1-10";
				}
				else if(age>10 && age<16){
					ageGroup="11-15";
				}
				else if(age>15 && age<21){
					ageGroup="16-20";
				}
				else if(age>20){
					ageGroup=">20";
				}
				List<String> genreListBasedOnAgeGender = new ArrayList<>();
				genreListBasedOnAgeGender = access.getGenreListBasedOnAgeGender(ageGroup,user.getGender());
				System.out.println(genreListBasedOnAgeGender.size());
				List<Movie> staticList = access.getStaticRecommendations(genreListBasedOnAgeGender,user.getAge());
				System.out.println(staticList.size());
				List<Movie> staticListForDisplay = new ArrayList<>();
				int j=0;
				int k=0;
				while(j<staticList.size()){
							if(staticListForDisplay.size()>0){
								if(j>0 && !(staticListForDisplay.get(k-1).getGenre().equals(staticList.get(j).getGenre()))){
									if(staticListForDisplay.get(k-1).getYear().equals(staticList.get(j).getYear())){
										j=j+1;
									}
									else{
										staticListForDisplay.add(staticList.get(j));
										k++;
										j=j+1;
									}
								}
								else{
									j=j+1;
								}
								
							}
							else{
							staticListForDisplay.add(staticList.get(j));
							k++;
							j=j+1;
							}
							
				}
				
				if(staticListForDisplay.size()<12){
					j=0;
					k=staticListForDisplay.size();
					while(j<staticList.size()){
						if(staticListForDisplay.get(k-1).getName().equals(staticList.get(j).getName())){
							j=j+1;
						}
						else{
							if(!(staticListForDisplay.contains(staticList.get(j)))){
							staticListForDisplay.add(staticList.get(j));
							k++;
							j=j+(staticList.size()/5);
							}
							else{
								j=j+1;
							}
						}
					}
				}
				if(staticListForDisplay.size()<12){
					j=0;
					k=staticListForDisplay.size();
					while(j<staticList.size()){
						if(staticListForDisplay.get(k-1).getName().equals(staticList.get(j).getName())){
							j=j+1;
						}
						else{
							if(!(staticListForDisplay.contains(staticList.get(j)))){
							staticListForDisplay.add(staticList.get(j));
							k++;
							j=j+1;
							}
							else{
								j=j+1;
							}
						}
					}
				}
				System.out.println(staticListForDisplay.size());
				
				List<String> genreListBasedOnHistory = new ArrayList<>();
				genreListBasedOnHistory = access.getGenreListBasedOnHistory(user.getId());
				Map<String,Integer> map = new HashMap<>();
				for(int i=0;i<genreListBasedOnHistory.size();i++){
					int count = 1;
					count = access.getDisplayCountForGenre(genreListBasedOnHistory.get(i),user.getId());
					map.put(genreListBasedOnHistory.get(i), count);
				}
				System.out.println(map);
				List<Movie> historyRecommendations = new ArrayList<>();
				List<Movie> displayList = new ArrayList<>();
				for(int i=0;i<genreListBasedOnHistory.size();i++){
					List<Movie> list = new ArrayList<>();
					list=access.getMovieListForGenreHistory(genreListBasedOnHistory.get(i),user.getId());
					historyRecommendations.addAll(list);
					int count = map.get(genreListBasedOnHistory.get(i));
					if((list.size()>=((count/2)+(count%2)))){
						for(int n=0;n<((count/2)+(count%2));n++){
							displayList.add(list.get(n));
							if(count>1)
							displayList.add(list.get((list.size()-1)-n));
						}
					}
					else{
						for(int n=0;n <list.size();n++){
							displayList.add(list.get(n));
						}
					}
				}
				Set<Movie> set = new HashSet<>();
				set.addAll(displayList);
				displayList = new ArrayList<>();
				displayList.addAll(set);
				System.out.println(displayList.size());
				System.out.println("********************");
				for(int i=0;i<displayList.size();i++){
					System.out.println(displayList.get(i).getName());
				}
				
				List<Movie> movieList = new ArrayList<>();
				List<String> list4 = new ArrayList<>();
				for(int i=0; i<genreListBasedOnHistory.size();i++){
					List<String> list = new ArrayList<>();
					list=access.getMovieListForGenre(genreListBasedOnHistory.get(i));
					Set<String> set1 = new HashSet<>();
					set1.addAll(list);
					List<String> list1 = new ArrayList<>();
					list1.addAll(set1);
					List<String> list2 = new ArrayList<>();
					int count1=1;
					for(int index=0;index<list1.size();index++){
						int count = java.util.Collections.frequency(list, list1.get(index));
						if(count>count1){
							list2.add(0, list1.get(index));
							count1=count;
						}
						else{
							list2.add(list1.get(index));
						}
					}
					System.out.println(genreListBasedOnHistory.get(i)+":"+list2);
					int count2 = map.get(genreListBasedOnHistory.get(i));
					List<String> list3 = new ArrayList<>();
					int i1=0;
					while(list3.size()<count2){
						if(list2.size()>i1){
							list3.add(list2.get(i1));
							i1++;
						}
						else{
							break;
						}
					}
					System.out.println(list3);
					list4.addAll(list3);
				}
				System.out.println(list4);
				for(int i=0;i<list4.size();i++){
					Movie movie = new Movie();
					movie=access.getMovieDetailsByName(list4.get(i));
					movieList.add(movie);
				}
				request.setAttribute("trendMovieList", movieList);
				request.setAttribute("recGenreList", genreListBasedOnAgeGender);
				request.setAttribute("staticList", staticListForDisplay);
				request.setAttribute("displayList", displayList);
				RequestDispatcher view = request.getRequestDispatcher("jsp/index.jsp");
				view.forward(request, response);
			}
			}
			catch(Exception ex){
				ex.printStackTrace();
			}
		}
		else if("ViewMovie".equals(query)){
			try{
				HttpSession session = request.getSession(false);
				User user = new User();
				user = (User) session.getAttribute("User");
				if(user==null||"".equals(user.getId()) || user.getId()==null){
					RequestDispatcher view = request.getRequestDispatcher("jsp/index.jsp");
					view.forward(request, response);
				}
				else{
				String id=request.getParameter("id");
				DatasetAccess access = new DatasetAccess();
				Movie movie = new Movie();
				movie=access.getMovieDetails(id);
				access.insertUserActivity(movie,user.getId());
				request.setAttribute("movie", movie);
				List<String> genreList = new ArrayList<>();
				genreList = access.getGenreList();
				request.setAttribute("genreList", genreList);
				RequestDispatcher view = request.getRequestDispatcher("jsp/movies.jsp");
				view.forward(request, response);
				}
			}
			catch(Exception ex){
				ex.printStackTrace();
			}
		}
		else if("login".equals(query)){
			try{
				RequestDispatcher view = request.getRequestDispatcher("jsp/login.jsp");
				view.forward(request, response);
			}
			catch(Exception ex){
				ex.printStackTrace();
			}
		}
		else if("logout".equals(query)){
			try{
				HttpSession session = request.getSession(false);
				if(session!=null)
				session.invalidate();
				RequestDispatcher view = request.getRequestDispatcher("jsp/index.jsp");
				view.forward(request, response);
			}
			catch(Exception ex){
				ex.printStackTrace();
			}
		}
	}
	
	public void doPost(HttpServletRequest request,HttpServletResponse response){
		String source = request.getParameter("source");
		if("register".equals(source)){
			try{
			String name = request.getParameter("rname");
			String email = request.getParameter("remail");
			String gender = request.getParameter("rgender");
			String age = request.getParameter("rage");
			String password = request.getParameter("rpass");
			User user = new User();
			user.setName(name);
			user.setEmail(email);
			user.setGender(gender);
			user.setAge(age);
			user.setPassword(password);
			DatasetAccess access = new DatasetAccess();
			access.registerUser(user);
			request.setAttribute("msg", "Registration Successful");
			RequestDispatcher view = request.getRequestDispatcher("jsp/login.jsp");
			view.forward(request, response);
			}
			catch(Exception ex){
				ex.printStackTrace();
			}
		}
		else if("login".equals(source)){
			try{
				String email = request.getParameter("lemail");
				String password = request.getParameter("lpassword");
				DatasetAccess access = new DatasetAccess();
				User user = new User();
				user = access.getUserDetailsLogin(email,password);
				if("".equals(user.getId())||user.getId()==null){
					request.setAttribute("msg1", "Invalid Credentials");
					RequestDispatcher view = request.getRequestDispatcher("jsp/login.jsp");
					view.forward(request, response);
				}
				else{
					HttpSession session = request.getSession(true);
					session.setAttribute("User", user);
					response.sendRedirect(request.getContextPath()+"/movie?query=Home");
				}
			}
			catch(Exception ex){
				ex.printStackTrace();
			}
		}
			
	}
	

}
