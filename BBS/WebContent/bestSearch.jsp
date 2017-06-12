<%@ page language="java" contentType="text/html; charset=euc-kr"
	pageEncoding="euc-kr"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="mrbs.MrbsDAO"%>
<%@ page import="mrbs.Mrbs"%>
<%@ page import="cmt.CmtDAO"%>
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
			<li><a class="before" href="introduction.jsp">Introduction&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			<li><a class="before" href="rbs.jsp">Recipe&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			<li><a class="active" href="mrbs.jsp">Community&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			<li><a class="before" href="nbs.jsp">Notice&amp;QnA</a></li>
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
		<li><a class="before" href="mrbs.jsp">My recipes</a></li>
		<li><a class="active" href="best.jsp">Best recipes</a></li>
		<li><a class="before" href="bbs.jsp">Free board</a></li>
	</ul>
	</nav>
	<div class="container" align="center"
		style="padding-top: 350px; padding-bottom: 100px;">
		<div align="right" style="padding-top: 20px; padding-bottom: 50px;">
			<a href="write.jsp" class="btn btn-success pull-right"
				style="background-color: orange; border: 1px solid orange; margin-right: -13px;">글쓰기</a>
		</div>
		<div class="row">
			<table class="table table-striped" style="text-align: center;">
				<thead>
					<tr>
						<th
							style="background-color: #695d46; width: 10%; text-align: center; border-radius: 15px 0 0 0;">번호</th>
						<th
							style="background-color: #695d46; width: 10%; text-align: center;">카테고리</th>
						<th
							style="background-color: #695d46; width: 30%; text-align: center;">제목</th>
						<th
							style="background-color: #695d46; width: 10%; text-align: center;">작성자</th>
						<th
							style="background-color: #695d46; width: 20%; text-align: center;">작성일</th>
						<th
							style="background-color: #695d46; width: 10%; text-align: center;">조회수</th>
						<th
							style="background-color: #695d46; width: 10%; text-align: center; border-radius: 0 15px 0 0;">추천수</th>
					</tr>
				</thead>
				<tbody>
					<%
						request.setCharacterEncoding("euc-kr");
						MrbsDAO mrbsDAO = new MrbsDAO();
						CmtDAO cmtDAO = new CmtDAO();
						String searchOption = new String(request.getParameter("searchOption").getBytes("8859_1"), "euc-kr");
						String searchInput = new String(request.getParameter("searchInput").getBytes("8859_1"), "euc-kr");
						ArrayList<Mrbs> list = mrbsDAO.bestSearchList(pageNumber, searchOption, searchInput);
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%=list.get(i).getMrbsID()%></td>
						<td><%=list.get(i).getMrbsCategory()%></td>
						<td><a href="view.jsp?mrbsID=<%=list.get(i).getMrbsID()%>"><%=list.get(i).getMrbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br/>")%> [<%=cmtDAO.countCmt(list.get(i).getMrbsID())%>]
						</a></td>
						<td><%=list.get(i).getUserID()%></td>
						<td><%=list.get(i).getMrbsDate().substring(0, 11)%></td>
						<td><%=list.get(i).getMrbsHit()%></td>
						<td><%=list.get(i).getMrbsLike()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
		<div>
			<form name="searchForm" method="post" action="bestSearch.jsp"
				style="padding-top: 50px;">
				<select name="searchOption">
					<option value="mrbsTitle">제목</option>
					<option value="mrbsContent">내용</option>
					<option value="userId">글쓴이</option>
					<option value="mrbsCategory">카테고리</option>
				</select> <input name="searchInput" type="text" value="<%=searchInput%>"
					placeholder="검색할 내용을 입력" /> <input type="submit"
					name="searchSubmit" value="검색" />
			</form>
		</div>
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="js/bootstrap.js"></script>
</body>
</html>
</body>
</html>