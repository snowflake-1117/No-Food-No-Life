<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="nbs.NbsDAO"%>
<%@ page import="nbs.Nbs"%>
<%@ page import="rcmt.RcmtDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width" name="viewport" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/community.css">
<title>No Food, No Life!</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>

	<header class="header"> <a href="main.jsp"
		style="text-decoration: none; color: #ff7846">No Food, No life!</a> <br>
	</header>
	<nav align="center">
	<ul class="nav">
		<div>
			<li><a class="before" href="introduce.html">Introduction&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			<li><a class="before" href="rbs.jsp">Recipe&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			<li><a class="before" href="mrbs.jsp">Community&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			<li><a class="active" href="nbs.jsp">Notice&amp;QnA</a></li>
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
		<a href="check.jsp">마이페이지</a> | <a href="logoutAction.jsp">로그아웃&nbsp;&nbsp;&nbsp;</a>
	</div>
	<%
		}
	%>
	</nav>
	<nav>
	<ul class="menu">
		<li><a class="before" href="nbs.jsp">Notice</a></li>
		<li><a class="active" href="qna.jsp">Q&A</a></li>
	</ul>
	</nav>
	<div class="container" align="center"
		style="padding-top: 200px; padding-bottom: 100px;">

	 <div class=center>
    <section name="QnAList">
      <details>
        <summary>Q. 베스트 레시피에는 어떻게 올라갈 수 있나요?</summary>
        <p><br>A. 일정 갯수의 추천을 받으면 내가 작성한 레시피가 베스트 레시피 게시판에 올라가게 됩니다!</p>
      </details>

      <details>
        <summary>Q. 자유게시판의 질문 카테고리와 QnA 게시판의 차이는 무엇인가요?</summary>
        <p><br>A. 자유게시판의 질문 카테고리는 회원들이 자유롭게 질문하고 답변할 수 있는 공간입니다.
        <br>반면 QnA 게시판은 회원들이 자주 묻는 질문을 관리자가 올려놓은 페이지입니다.</p>
      </details>

      <details>
        <summary>Q. 일대일로 질문을 하고 싶어요!</summary>
        <p><br>A. No_food_No_life@gmail.com 으로 연락주시기 바랍니다.</p>
      </details>
    </section>

		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="js/bootstrap.js"></script>
</body>
</html>
</body>
</html>