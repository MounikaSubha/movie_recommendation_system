<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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

		<!-- scripts -->
		<script src="themes/js/jquery-1.7.2.min.js"></script>
		<script src="bootstrap/js/bootstrap.min.js"></script>				
		<script src="themes/js/superfish.js"></script>	
		<script src="themes/js/jquery.scrolltotop.js"></script>
		<!--[if lt IE 9]>			
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
			<script src="js/respond.min.js"></script>
		<![endif]-->
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
			<hr>
		</div>
		<div id="wrapper" class="container">
			<%-- <section class="navbar main-menu">
				<div class="navbar-inner main-menu">				
					
					<nav id="menu" class="pull-right">
						<ul>
						<c:if test="${empty User.id }">
							
						</c:if>
						<c:if test="${not empty User.id }">
							<li><a href="${pageContext.request.contextPath}/movie?query=Home">Home</a></li>						
							<li><a href="${pageContext.request.contextPath}/movie?query=Movies">Movies</a></li>			
						</c:if>
						</ul>
					</nav>
				</div>
			</section> --%>
			<section  class="homepage-slider" id="home-slider">
				<div class="flexslider">
					<ul class="slides">
						<li>
							<img src="themes/images/carousel/7.jpg" alt="" style="height:400px;"/>
							<!-- <div class="intro">
								<h1>Recommend Movies</h1>
								<p><span>Based</span></p>
								<p><span>On your History and Interests</span></p>
							</div> -->
						</li>
						<li>
							<img src="themes/images/carousel/2.png" alt="" style="height:400px;"/>
							
						</li>
					</ul>
				</div>			
			</section>
			<c:if test="${not empty User.id }">
			<section class="main-content">
				<div class="row">
					<div class="span12">													
						<div class="row">
							<div class="span12">
								<h4 class="title">
									<span class="pull-left"><span class="text"><span class="line">Recommended <strong>Movies</strong></span></span></span>
									<span class="pull-right">
										<a class="left button" href="#myCarousel" data-slide="prev"></a><a class="right button" href="#myCarousel" data-slide="next"></a>
									</span>
								</h4>
								<div id="myCarousel" class="myCarousel carousel slide">
									<div class="carousel-inner">
										<div class="active item">
											<ul class="thumbnails">	
											
											<c:forEach items="${staticList }" var="movies" varStatus="loop">
											<c:if test="${loop.count lt 13}">										
												<li class="span3">
													<div class="product-box" style="min-height: 150px;">
														<span class="sale_tag"></span>												
														<br/>
														<a href="${pageContext.request.contextPath}/movie?query=ViewMovie&id=<c:out value="${movies.movieId}"/>" class="title" style="font-size: 18px;">${movies.name }</a><br/>
														<a href="${pageContext.request.contextPath}/movie?query=ViewMovie&id=<c:out value="${movies.movieId}"/>" class="category">${movies.genre }</a>
														<p class="price" style="font-size: 12px;padding: 0px;">${movies.year }</p>
													</div>
												</li>
												</c:if>
												</c:forEach>
												
											</ul>
											
										</div>
										<div class="item">
											<ul class="thumbnails">
												<c:forEach items="${displayList }" var="movie" varStatus="count">
											<%-- <c:if test="${count.count lt 13}"> --%>										
												<li class="span3">
													<div class="product-box" style="min-height: 150px;">
														<span class="sale_tag"></span>												
														<br/>
														<a href="${pageContext.request.contextPath}/movie?query=ViewMovie&id=<c:out value="${movie.movieId}"/>" class="title" style="font-size: 18px;">${movie.name }</a><br/>
														<a href="${pageContext.request.contextPath}/movie?query=ViewMovie&id=<c:out value="${movie.movieId}"/>" class="category">${movie.genre }</a>
														<p class="price" style="font-size: 12px;padding: 0px;">${movie.year }</p>
													</div>
												</li>
												<%-- </c:if> --%>
												</c:forEach>
											</ul>
										</div>
										<div class="item">
										<h4>Trending Movies</h4>
											<ul class="thumbnails">
												<c:forEach items="${trendMovieList }" var="movie" varStatus="count">
											<%-- <c:if test="${count.count lt 13}"> --%>										
												<li class="span3">
													<div class="product-box" style="min-height: 150px;">
														<span class="sale_tag"></span>												
														<br/>
														<a href="${pageContext.request.contextPath}/movie?query=ViewMovie&id=<c:out value="${movie.movieId}"/>" class="title" style="font-size: 18px;">${movie.name }</a><br/>
														<a href="${pageContext.request.contextPath}/movie?query=ViewMovie&id=<c:out value="${movie.movieId}"/>" class="category">${movie.genre }</a>
														<p class="price" style="font-size: 12px;padding: 0px;">${movie.year }</p>
													</div>
												</li>
												<%-- </c:if> --%>
												</c:forEach>
											</ul>
										</div>
									</div>							
								</div>
							</div>						
						</div>
						<br/>
					
						
					</div>				
				</div>
			</section>
			</c:if>
			<c:if test="${not empty User.id }">
			<section class="our_client">
				<h4 class="title"><span class="text">Genres</span></h4>
				<div class="row">
				<c:forEach items="${recGenreList }" var="genre">		
					<div class="span2">
						<a href="${pageContext.request.contextPath}/movie?query=getMovies&genre=${genre}"><h2>${genre }</h2></a>
					</div>
				</c:forEach>
				</div>
			</section>
			</c:if>
			<section id="footer-bar" >
			
			</section>
			<section id="copyright">
				<span>Copyright 2017 | Movie Recommendations | All right reserved.</span>
			</section>
		</div>
		<script src="themes/js/common.js"></script>
		<script src="themes/js/jquery.flexslider-min.js"></script>
		<script type="text/javascript">
			$(function() {
				$(document).ready(function() {
					$('.flexslider').flexslider({
						animation: "fade",
						slideshowSpeed: 4000,
						animationSpeed: 600,
						controlNav: false,
						directionNav: true,
						controlsContainer: ".flex-container" // the container that holds the flexslider
					});
				});
			});
		</script>
    </body>
</html>