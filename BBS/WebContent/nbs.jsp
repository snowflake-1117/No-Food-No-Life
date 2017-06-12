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
		<li><a class="active" href="nbs.jsp">Notice</a></li>
		<li><a class="before" href="qna.jsp">Q&A</a></li>
	</ul>
	</nav>
	<div class="container" align="center"
		style="padding-top: 350px; padding-bottom: 100px;">
		<%
			if (userID!=null && userID.equals("admin")) {
		%>
		<div align="right" style="padding-top: 20px; padding-bottom: 50px;">
			<a href="nbsWrite.jsp" class="btn btn-success pull-right"
				style="background-color: #ff7846; border: 1px solid #ff7846; margin-right: -13px;">글쓰기</a>
		</div>
		<%
			}
		%>
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th
							style="background-color: #695d46; width: 10%; text-align: center;">번호</th>
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
						NbsDAO nbsDAO = new NbsDAO();
						RcmtDAO rcmtDAO = new RcmtDAO();
						ArrayList<Nbs> list = nbsDAO.getList(pageNumber);
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%=list.get(i).getNbsID()%></td>
						<td><a href="nbsView.jsp?nbsID=<%=list.get(i).getNbsID()%>"><%=list.get(i).getNbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br/>")%></a></td>
						<td><%=list.get(i).getUserID()%></td>
						<td><%=list.get(i).getNbsDate().substring(0, 11)%></td>
						<td><%=list.get(i).getNbsHit()%></td>
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
				<a href="nbs.jsp?pageNumber=<%=pageNumber - 1%>"
					class="btn btn-success pull-left"
					style="background-color: #ff7846; border: 1px solid #ff7846;">이전</a>
				<%
					}

					for (int i = pageNumber - 5; i < pageNumber + 5; i++) {
						if (i > 0 && nbsDAO.nextPage(i)) {
							if (i == pageNumber) {
				%>
				<a href="nbs.jsp?pageNumber=<%=i%>"><b>&nbsp;&nbsp;<%=i%>&nbsp;&nbsp;
				</b></a>
				<%
					} else {
				%>
				<a href="nbs.jsp?pageNumber=<%=i%>">&nbsp;&nbsp;<%=i%>&nbsp;&nbsp;
				</a>
				<%
					}
						}
					}
					if (nbsDAO.nextPage(pageNumber + 1)) {
				%>
				<a href="nbs.jsp?pageNumber=<%=pageNumber + 1%>"
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