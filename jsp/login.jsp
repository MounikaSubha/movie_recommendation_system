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
		<script type="text/javascript">
		function rvalidate(){
			var ageRegex = /^\d{1,2}$/;
			var emailRegex = /^[A-Za-z0-9._]*\@[A-Za-z]*\.[A-Za-z]{2,5}$/;
			var name=document.getElementById("rname").value;
			var email=document.getElementById("remail").value;
			var gender=document.getElementsByName("rgender");
			var age=document.getElementById("rage").value;
			var pass=document.getElementById("rpass").value;
			var confPass = document.getElementById("rconfpass").value;
			if(name==""){
				document.getElementById("rname").focus();
				document.getElementById("ermsg").innerHTML="Please enter name";
				return false;
			}
			if(email==""){
				document.getElementById("remail").focus();
				document.getElementById("ermsg").innerHTML="Please enter email";
				return false;
			}
			else if(!emailRegex.test(email)){
				document.getElementById("remail").focus();
				document.getElementById("ermsg").innerHTML="Please enter valid email";
				return false;
			}
			var checked = false;
			for (var i = 0, radio; radio = gender[i]; i++) {
			    if (radio.checked) {
			        checked = true;
			        break;
			    }
			}
			if (!checked) {
				document.getElementById("ermsg").innerHTML="Please select gender";
				return false;
			}
			if(age==""){
				document.getElementById("rage").focus();
				document.getElementById("ermsg").innerHTML="Please enter age";
				return false;
			}
			else if(!ageRegex.test(age)){
				document.getElementById("rage").focus();
				document.getElementById("ermsg").innerHTML="Please enter valid age";
				return false;
			}
			if(pass == ""){
				document.getElementById("rpass").focus();
				document.getElementById("ermsg").innerHTML="Please enter password";
				return false;
			}
			if(confPass == ""){
				document.getElementById("rconfpass").focus();
				document.getElementById("ermsg").innerHTML="Please enter confirm password";
				return false;
			}
			if(pass!=confPass){
				document.getElementById("rpass").focus();
				document.getElementById("ermsg").innerHTML="Passwords did not match";
				return false;
			}
			document.getElementById("regform").submit();
		}
		
		function lvalidate(){
			var emailRegex = /^[A-Za-z0-9._]*\@[A-Za-z]*\.[A-Za-z]{2,5}$/;
			var email=document.getElementById("lemail").value;
			var pass=document.getElementById("lpassword").value;
			if(email==""){
				document.getElementById("lemail").focus();
				document.getElementById("elmsg").innerHTML="Please enter email";
				return false;
			}
			else if(!emailRegex.test(email)){
				document.getElementById("lemail").focus();
				document.getElementById("elmsg").innerHTML="Please enter valid email";
				return false;
			}
			if(pass == ""){
				document.getElementById("lpassword").focus();
				document.getElementById("elmsg").innerHTML="Please enter password";
				return false;
			}
			document.getElementById("lform").submit();
		}
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
				
			</section>
			<section class="main-content">				
				<div class="row">
					<div class="span5">					
						<h4 class="title"><span class="text"><strong>Login</strong> Form</span></h4>
						<h5 id="elmsg">${msg1 }</h5>
						<form  id="lform" action="${pageContext.request.contextPath}/movie" method="post">
							<input type="hidden" name="next" value="/">
							<fieldset>
								<div class="control-group">
									<label class="control-label">Email</label>
									<div class="controls">
										<input type="text" name="lemail" id="lemail" placeholder="Enter your email ID" id="username" class="input-xlarge">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Password</label>
									<div class="controls">
										<input type="password" name="lpassword" id="lpassword" placeholder="Enter your password" id="password" class="input-xlarge"><input type="hidden" name="source" value="login">
									</div>
								</div>
								<div class="control-group">
									<input tabindex="3" class="btn btn-inverse large" type="button" value="Sign into your account" onclick="javascript:lvalidate();">
									<hr>

								</div>
							</fieldset>
						</form>				
					</div>
					<div class="span7">					
						<h4 class="title"><span class="text"><strong>Register</strong> Form</span></h4>
						<h5 id="ermsg">${msg }</h5>
						<form id="regform" action="${pageContext.request.contextPath}/movie" method="post" class="form-stacked">
							<fieldset>
								<div class="control-group">
									<label class="control-label">Name</label>
									<div class="controls">
										<input type="text" name="rname" id="rname" placeholder="Enter your name" class="input-xlarge">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Email address:</label>
									<div class="controls">
										<input type="text" name="remail" id="remail" placeholder="Enter your email" class="input-xlarge">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Gender</label>
									<div class="controls">
										<input type="radio" name="rgender" id="rgender" name="gender" value="M">&nbsp;Male &nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rgender" id="rgender" value="F">&nbsp;Female
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Age</label>
									<div class="controls">
										<input type="text" name="rage" id="rage" placeholder="Enter your age" class="input-xlarge">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Password:</label>
									<div class="controls">
										<input type="password" name="rpass" id="rpass" placeholder="Enter your password" class="input-xlarge">
									</div>
								</div>							                            
								<div class="control-group">
									<label class="control-label">Confirm Password:</label>
									<div class="controls">
										<input type="password" name="rconfpass" id="rconfpass" placeholder="Enter your password" class="input-xlarge"><input type="hidden" name="source" value="register">
									</div>
								</div>
								<hr>
								<div class="actions"><input tabindex="9" class="btn btn-inverse large" type="button" value="Create your account" onclick="javascript:rvalidate();"></div>
							</fieldset>
						</form>					
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