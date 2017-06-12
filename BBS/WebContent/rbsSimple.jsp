<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="rbs.RbsDAO"%>
<%@ page import="rbs.Rbs"%>
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
		
		RbsDAO rbsDAO = new RbsDAO();
		
		ArrayList<Rbs> list = rbsDAO.getCategoryList("간단요리");
		int totalPage = (int) Math.floor(list.size() / 10) + 1;
		int countList = 10;
		int countPage = 5;
		int totalCount = list.size();

		
		if (totalPage < pageNumber) {
			pageNumber = totalPage;
		}

		int startPage = ((pageNumber - 1) / 5) * 5 + 1;
		int endPage = startPage + countPage - 1;

		if (endPage > totalPage) {
			endPage = totalPage;
		}
	%>

	<header class="header"> <a href="main.jsp"
		style="text-decoration: none; color: #ff7846">No Food, No life!</a> <br>
	</header>
	<nav align="center">
	<ul class="nav">
		<div>
			<li><a class="before" href="introduce.html">Introduction&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			<li><a class="active" href="rbs.jsp">Recipe&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			<li><a class="before" href="mrbs.jsp">Community&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			<li><a class="before" href="notice.html">Notice&amp;QnA</a></li>
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
		<a href="logoutAction.jsp">로그아웃&nbsp;&nbsp;&nbsp;</a>
	</div>
	<%
		}
	%>
	</nav>
	<nav>
	<ul class="menu">
		<li><a class="active" href="rbsSimple.jsp">Simple</a></li>
		<li><a class="before" href="rbsKorean.jsp">Korean</a></li>
		<li><a class="before" href="rbsChinese.jsp">Chinese</a></li>
		<li><a class="before" href="rbsJapanese.jsp">Japanese</a></li>
		<li><a class="before" href="rbsWestern.jsp">Western</a></li>
		<li><a class="before" href="rbsSimple.jsp">Desert</a></li>
	</ul>
	</nav>
	<div class="container" align="center"
		style="padding-top: 350px; padding-bottom: 100px;">
		<div align="right" style="padding-top: 20px; padding-bottom: 50px;">
			<a href="rbsWrite.jsp" class="btn btn-success pull-right"
				style="background-color: #ff7846; border: 1px solid #ff7846; margin-right: -13px;">글쓰기</a>
		</div>
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th
							style="background-color: #695d46; width: 10%; text-align: center;">번호</th>
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
					</tr>
				</thead>
				<tbody>
					<%
						CmtDAO cmtDAO = new CmtDAO();						

						for (int i = (pageNumber - 1) * 10; i < pageNumber * 10 && i < totalCount; i++) {
					%>
					<tr>
						<td><%=list.get(i).getRbsID()%></td>
						<td><%=list.get(i).getRbsCategory()%></td>
						<td><a href="rbsView.jsp?rbsID=<%=list.get(i).getRbsID()%>"><%=list.get(i).getRbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br/>")%> [<%=cmtDAO.countCmt(list.get(i).getRbsID())%>]
						</a></td>
						<td><%=list.get(i).getUserID()%></td>
						<td><%=list.get(i).getRbsDate().substring(0, 11)%></td>
						<td><%=list.get(i).getRbsHit()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<div align="center">
				<%
					if (pageNumber != 1) {
				%>
				<a href="rbsSimple.jsp?pageNumber=<%=pageNumber - 1%>"
					class="btn btn-success pull-left"
					style="background-color: #ff7846; border: 1px solid #ff7846;">이전</a>
				<%
					}

					for (int i = startPage; i <= endPage; i++) {
						if (i == pageNumber) {
				%>
				<a href="rbsSimple.jsp?pageNumber=<%=i%>"><b>&nbsp;&nbsp;<%=i%>&nbsp;&nbsp;</b></a>
				<%
					} else {
				%>
				<a href="rbsSimple.jsp?pageNumber=<%=i%>">&nbsp;&nbsp;<%=i%>&nbsp;&nbsp;</a>
				<%
					}
					}
					if (pageNumber < totalPage) {
				%>
				<a href="rbsSimple.jsp?pageNumber=<%=pageNumber + 1%>"
					class="btn btn-success pull-right"
					style="background-color: #ff7846; border: 1px solid #ff7846;">다음</a>
				<%
					}
				%>
			</div>
		</div>
		<div>
			<form name="searchForm" method="get" style="padding-top: 50px;">
				<select name="searchOption">
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="category">카테고리</option>
					<option value="username">글쓴이</option>
				</select> <input name="searchInput" type="search" value=""
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