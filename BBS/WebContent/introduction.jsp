<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width" name="viewport" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/main.css">
<title>No Food, No Life!</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}

span {
	font-family: 'Nanum Brush Script';
	font-weight: bold;
	color: #ff7846;
	font-size: 60px;
}

article {
	font-family: 'Jeju Myeongjo';
	background: #FFFDF9;
	padding: 30px;
	margin-top: 10px;
	width: 700px;
	left: 50%;
	margin-left: -350px;
	position: absolute;
	text-align: justify;
}

h1 {
	margin-top: -10px;
	font-size: 50px;
	color: #111111;
	font-family: 'Jeju Myeongjo';
}
</style>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>

	<header class="header"> <a href="main.jsp"
		style="text-decoration: none; color: #ff7846">No Food, No life!</a>
	<br>
	</header>
	<nav align="center">
	<ul class="nav">
		<div>
			<li><a href="introduction.jsp" class="active">Introduction</a></li>
			<li><a href="rbs.jsp">Recipe</a></li>
			<li><a href="mrbs.jsp">Community</a></li>
			<li><a href="nbs.jsp">Notice&amp;QnA</a></li>
	</ul>
	</nav>
	<%
		if (userID == null) {
	%>
	<div align="right" class="login">
		<a href="login.jsp">로그인</a> | <a href="join.jsp">회원가입&nbsp;&nbsp;&nbsp;</a>
	</div>
	<%
		} else {
	%>
	<div align="right" class="login">
	<a><%=userID%>님 환영합니다!&nbsp;&nbsp;&nbsp;
		<a href="check.jsp">마이페이지</a> | <a href="logoutAction.jsp">로그아웃 <%
			if (userID != null && userID.equals("admin")) {
		%>
		</a> | <a href="memberInfo.jsp">회원관리&nbsp;&nbsp;&nbsp;</a>
		<%
			} else {
		%>
		&nbsp;&nbsp;&nbsp;</a>
		<%
			}
		%>
	</div>
	<%
		}
	%>
	</nav>
	<section class="section" style="padding-top:100px;font-size:20px;">
	<article>
	<p style="text-align: center;">
		<span>No Food, No Life!</span> 는 레시피 공유 사이트입니다.
	</p>
	<p>&nbsp;&nbsp;&nbsp;기존에 여러 곳에 존재하던 레시피들을 한 곳에 모아 보고자 만들었습니다. 관리자가
		올려둔 레시피와 더불어 회원들이 올리는 자신만의 레시피로 구성되어 있고 커뮤니티에서는 회원들끼리 팁, 질문과 답변을 올려
		공유할 수 있습니다.</p>
	<p>
		<br> <b style="font-size: 20px; color: #111111">Recipe</b>는 관리자가
		올린 레시피가 있는 곳입니다. <br>&nbsp;&nbsp;&nbsp;카테고리는 Simple(간단)/Korean(한식)/Chinese(중식)/Japanese(일식)/Western(양식)/Desert(후식)로
		구성되어있습니다. <br>
		<br>
		<b style="font-size: 20px; color: #111111">Community</b>는 회원들이 활동할 수
		있는 공간입니다. <br>&nbsp;&nbsp;&nbsp;카테고리는 My recipes/Best
		recipes/Free board로 구성되어 있습니다. 회원들은 My recipes에 레시피를 올려 공유할 수 있습니다.
		Best recipes는 My recipes 중 추천을 많이 받은 게시물이 올라갑니다. Free board는 자유게시판으로
		요리 팁, 질문, 잡담을 올릴 수 있는 공간입니다. <br>
		<br>
		<b style="font-size: 20px; color: #111111">Notce&QnA</b>는 사이트와 관련된 공지와
		질문을 올리는 곳입니다. <br>&nbsp;&nbsp;&nbsp;카테고리는 Notice(공지)와 QnA(자주묻는
		질문)로 구성되어있습니다.
	</p>
	</article> </section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<footer class="footer" align="right">
	<hr>
	Copyright "No Food, No Life!" All Rights Reserved. </footer>
</body>
</html>