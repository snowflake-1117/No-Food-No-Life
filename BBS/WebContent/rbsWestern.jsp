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

		ArrayList<Rbs> list = rbsDAO.getCategoryList("양식");
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
			<li><a class="before" href="introduction.jsp">Introduction</a></li>
			<li><a class="active" href="rbs.jsp">Recipe</a></li>
			<li><a class="before" href="mrbs.jsp">Community</a></li>
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
	<nav>
	<ul class="menu">
		<li><a class="before" href="rbsSimple.jsp">Simple</a></li>
		<li><a class="before" href="rbsKorean.jsp">Korean</a></li>
		<li><a class="before" href="rbsChinese.jsp">Chinese</a></li>
		<li><a class="before" href="rbsJapanese.jsp">Japanese</a></li>
		<li><a class="active" href="rbsWestern.jsp">Western</a></li>
		<li><a class="before" href="rbsWestern.jsp">Desert</a></li>
	</ul>
	</nav>
	<div class="container" align="center"
		style="padding-top: 350px; padding-bottom: 100px;">
		<%
			if (userID != null && userID.equals("admin")) {
		%>
		<div align="right" style="padding-top: 20px; padding-bottom: 50px;">
			<a href="nbsWrite.jsp" class="btn btn-success pull-right"
				style="background-color: orange; border: 1px solid orange; margin-right: -13px;">글쓰기</a>
		</div>
		<%
			}
		%>
		<div class="row">
			<table class="table table-striped"
				style="text-align: center;">
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
							style="background-color: #695d46; width: 10%; text-align: center; border-radius: 0 15px 0 0;">조회수</th>
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
				<a href="rbsWestern.jsp?pageNumber=<%=pageNumber - 1%>"
					class="btn btn-success pull-left"
					style="background-color: #ff7846; border: 1px solid #ff7846;">이전</a>
				<%
					}

					for (int i = startPage; i <= endPage; i++) {
						if (i == pageNumber) {
				%>
				<a href="rbsWestern.jsp?pageNumber=<%=i%>"><b>&nbsp;&nbsp;<%=i%>&nbsp;&nbsp;
				</b></a>
				<%
					} else {
				%>
				<a href="rbsWestern.jsp?pageNumber=<%=i%>">&nbsp;&nbsp;<%=i%>&nbsp;&nbsp;
				</a>
				<%
					}
					}
					if (pageNumber < totalPage) {
				%>
				<a href="rbsWestern.jsp?pageNumber=<%=pageNumber + 1%>"
					class="btn btn-success pull-right"
					style="background-color: #ff7846; border: 1px solid #ff7846;">다음</a>
				<%
					}
				%>
			</div>
		</div>
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="js/bootstrap.js"></script>
</body>
</html>
</body>
</html>