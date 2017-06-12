<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="nbs.Nbs"%>
<%@ page import="nbs.NbsDAO"%>
<%@ page import="rcmt.Rcmt"%>
<%@ page import="rcmt.RcmtDAO"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width" name="viewport" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/main.css">
<title>No food, no life</title>
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
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		int nbsID = 0;
		if (request.getParameter("nbsID") != null) {
			nbsID = Integer.parseInt(request.getParameter("nbsID"));
		}
		if (nbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='nbs.jsp'");
			script.println("</script>");
		}

		int rcmtPageNumber = 1;
		if (request.getParameter("rcmtPageNumber") != null) {
			rcmtPageNumber = Integer.parseInt(request.getParameter("rcmtPageNumber"));
		}

		NbsDAO nbsDAO = new NbsDAO();
		nbsDAO.hit(nbsID);
		Nbs nbs = new NbsDAO().getNbs(nbsID);
	%>

	<header class="header"> <a href="main.jsp"
		style="text-decoration: none; color: #ff7846">No Food, No life!</a> <br>
	</header>
	<nav align="center">
	<ul class="nav">
		<div>
			<li><a href="introduce.html">Introduction&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			<li><a href="rbs.jsp">Recipe&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			<li><a href="mrbs.jsp">Community&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
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
		<a href="logoutAction.jsp">로그아웃&nbsp;&nbsp;&nbsp;</a>
	</div>
	<%
		}
	%>
	</nav>

	<div class="container"
		style="padding-top: 350px; padding-bottom: 200px;">
		<div style="padding-bottom: 30px;">
			<div>
				<a href="nbs.jsp"
					style="background-color: #695d46; border: 2px solid #695d46"
					class="btn btn-success pull-right">목록</a>
			</div>
			<%
				if (userID != null && userID.equals(nbs.getUserID())) {
			%>
			<a href="nbsUpdate.jsp?nbsID=<%=nbsID%>"
				style="background-color: #ff7846; border: 1px solid #ff7846;"
				class="btn btn-primary">수정</a> <a
				onclick="return confirm('정말로 삭제하시겠습니까?')"
				href="nbsDeleteAction.jsp?nbsID=<%=nbsID%>"
				style="background-color: #ff7846; border: 1px solid #ff7846;"
				class="btn btn-primary">삭제</a>
			<%
				}
			%>
		</div>
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2"
							style="background-color: #695d46; color: #ffffff; text-align: center;">게시판
							글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%">글제목</td>
						<td><%=nbs.getNbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br/>")%></td>
					</tr>
					<tr>
						<td style="width: 20%">작성일자</td>
						<td><%=nbs.getNbsDate().substring(0, 16)%></td>
					</tr>
					<tr>
						<td style="width: 20%">작성자</td>
						<td><%=nbs.getUserID()%></td>
					</tr>
					<tr>
						<td style="width: 20%">조회수</td>
						<td><%=nbs.getNbsHit()%></td>
						<%
							if (nbs.getNbsImage() != null) {
						%>
					
					<tr>
						<td colspan="2"><img src="<%=nbs.getNbsImage()%>"
							style="max-width: 1024px; height: auto;'"></td>
					</tr>
					<%
						}
					%>
					<tr>
						<td style="width: 20%">내용</td>
						<td style="min-height: 200px; text-align: left;"><%=nbs.getNbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br/>")%></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>