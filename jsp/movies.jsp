<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
		<meta charset="utf-8">
		<title>Movie Recommendations</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<!--[if ie]><meta content='IE=8' http-equiv='X-UA-Compatible'/><![endif]-->
		<!-- bootstrap -->
		<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">      
		<link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">		
		<link href="themes/css/bootstrappage.css" rel="stylesheet"/>
		
		<!-- global styles -->
		<link href="themes/css/flexslider.css" rel="stylesheet"/>
		<link href="themes/css/main.css" rel="stylesheet"/>
		
		<link rel="stylesheet" href="themes/js/css/jPages.css">
		<link rel="stylesheet" href="themes/js/css/animate.css">

		<!-- scripts -->
		<script src="themes/js/jquery-1.7.2.min.js"></script>
		<script src="bootstrap/js/bootstrap.min.js"></script>				
		<script src="themes/js/superfish.js"></script>	
		<script src="themes/js/jquery.scrolltotop.js"></script>
		<!--[if lt IE 9]>			
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
			<script src="js/respond.min.js"></script>
		<![endif]-->
		<script src="themes/js/jPages.js"></script>
		<script type="text/javascript">
		$(function(){

			  $("div.holder").jPages({
			    containerID : "itemContainer",
			    perPage: 12,
			    keyBrowse: true,
			    scrollBrowse: true
			  });

			});
		
 
		
		
		</script>
	</head>
    <body>		
		<div id="top-bar" class="container">
			<div class="row">
				<div class="span4">
					<!-- <form method="POST" class="search_form">
						<input type="text" class="input-block-level search-query" Placeholder="search movies">
					</form> -->
					<a href="${pageContext.request.contextPath}/movie?query=Home" class="logo pull-left"><h2 style="margin-top: 0px;">MovieRecommendations</h2></a>
				</div>
				<div class="span8">
					<div class="account pull-right">
						<ul class="user-menu">
						<c:if test="${empty User.id }">	
							<li><a href="${pageContext.request.contextPath}/movie?query=Home">Home</a></li>	
							<li><a href="${pageContext.request.contextPath}/movie?query=login">Login/Register</a></li>
						</c:if>
						<c:if test="${not empty User.id }">
							<li><a href="${pageContext.request.contextPath}/movie?query=Home">Home</a></li>						
							<li><a href="${pageContext.request.contextPath}/movie?query=Movies">Movies</a></li>	
							<li><a href="${pageContext.request.contextPath}/movie?query=logout">Logout</a></li>
						</c:if>		
						</ul>
					</div>
				</div>
			</div>
			
		</div>
		<div id="wrapper" class="container">
			<%-- <section class="navbar main-menu">
				<div class="navbar-inner main-menu">				
					<a href="index.html" class="logo pull-left"><h2 style="margin-top: 0px;">MovieRecommendations</h2></a>
					<nav id="menu" class="pull-right">
						<ul>
							<li><a href="${pageContext.request.contextPath}/movie?query=Home">Home</a>					
								
							</li>															
							<li><a href="${pageContext.request.contextPath}/movie?query=Movies">Movies</a></li>			
							
						</ul>
					</nav>
				</div>
			</section> --%>
			<section class="header_text sub">
			<img class="pageBanner" src="themes/images/pageBanner.jpg" alt="Movies" style="height: 250px">
				<h4><span>Movies</span></h4>
				<c:if test="${not empty genre }"> <h4><span>Genre: ${genre }</span></h4></c:if>
				<c:if test="${not empty movie }"> <h4><span>Movie: ${movie.name }</span></h4></c:if>
			</section>
			<section class="main-content">
				
				<div class="row">
				<c:if test="${not empty movieList and empty movie}">					
					<div class="span9">	
					<div class="holder"></div>							
						<ul class="thumbnails listing-products" id="itemContainer">
							<c:forEach items="${movieList}" var="movies">
							<li class="span3">
							<div class="product-box" id="product-box" style="min-height: 150px;">
									<span class="sale_tag"></span>												
									<br/>
									<a href="${pageContext.request.contextPath}/movie?query=ViewMovie&id=<c:out value="${movies.movieId}"/>" class="title" style="font-size: 18px;">${movies.name }</a><br/>
									<a href="${pageContext.request.contextPath}/movie?query=ViewMovie&id=<c:out value="${movies.movieId}"/>" class="category">${movies.genre }</a>
									<p class="price" style="font-size: 12px;padding: 0px;">${movies.year }</p>
								</div>
							</li>
							</c:forEach>
						</ul>	
					<hr>
					</div>
					</c:if>
					<c:if test="${not empty movie }">
					<div class="span9">	
						<address>
									<strong>ID:</strong> <span>${movie.movieId }</span><br>
									<strong>Title:</strong> <span>${movie.name }</span><br>
									<strong>Genre:</strong> <span>${movie.genre }</span><br>
									<strong>Year:</strong> <span>${movie.year }</span><br>								
								</address>
					<hr>
					</div>
					</c:if>
					<c:if test="${empty movieList && empty movie}">
					<div class="span9">	
						<h4><span>Please Select A Genre</span></h4>					
						
					<hr>
					</div>
					
					</c:if>
					<div class="span3 col">
						<div class="block">	
							<ul class="nav nav-list">
								<li class="nav-header">Genres</li>
								<c:forEach items="${genreList }" var="genre">
								<li><a href="${pageContext.request.contextPath}/movie?query=getMovies&genre=${genre}">${genre }</a></li>
								</c:forEach>
							</ul>
							<br/>
							
						</div>
						
						
					</div>
					
				</div>
				
			</section>
			<section id="footer-bar">
				
			</section>
			<section id="copyright">
				<span>Copyright 2017 | Movie Recommendations | All right reserved.</span>
			</section>
		</div>
		<script src="themes/js/common.js"></script>	
    </body>
</html>