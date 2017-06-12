<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="rbs.Rbs"%>
<%@ page import="rbs.RbsDAO"%>
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
		int rbsID = 0;
		if (request.getParameter("rbsID") != null) {
			rbsID = Integer.parseInt(request.getParameter("rbsID"));
		}
		if (rbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='rbs.jsp'");
			script.println("</script>");
		}

		int rcmtPageNumber = 1;
		if (request.getParameter("rcmtPageNumber") != null) {
			rcmtPageNumber = Integer.parseInt(request.getParameter("rcmtPageNumber"));
		}

		int rcmtID = 0;
		if (request.getParameter("rcmtID") != null) {
			rcmtID = Integer.parseInt(request.getParameter("rcmtID"));
		}
		if (rcmtID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글입니다.')");
			script.println("location.href='rbs.jsp'");
			script.println("</script>");
		}

		RcmtDAO rcmtDAO = new RcmtDAO();
		Rcmt rcmt = new RcmtDAO().getRcmt(rcmtID);

		RbsDAO rbsDAO = new RbsDAO();
		rbsDAO.hit(rbsID);
		Rbs rbs = new RbsDAO().getRbs(rbsID);
	%>

	<header class="header"> <a href="main.jsp"
		style="text-decoration: none; color: #ff7846">No Food, No life!</a> <br>
	</header>
	<nav align="center">
	<ul class="nav">
		<div>
			<li><a class="before" href="introduce.html">Introduction&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			<li><a class="before" href="rbs.jsp">Recipe&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			<li><a class="active" href="mrbs.jsp">Community&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
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

	<div class="container"
		style="padding-top: 350px; padding-bottom: 200px;">
		<div style="padding-bottom: 30px;">
			<div>
				<a href="rbs.jsp"
					style="background-color: #695d46; border: 2px solid #695d46"
					class="btn btn-success pull-right">목록</a>
			</div>
			<%
				if (userID != null && userID.equals(rbs.getUserID())) {
			%>
			<a href="update.jsp?rbsID=<%=rbsID%>"
				style="background-color: #ff7846; border: 1px solid #ff7846;"
				class="btn btn-primary">수정</a> <a
				onclick="return confirm('정말로 삭제하시겠습니까?')"
				href="deleteAction.jsp?rbsID=<%=rbsID%>"
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
						<td style="width: 20%">카테고리</td>
						<td><%=rbs.getRbsCategory()%></td>
					</tr>
					<tr>
						<td style="width: 20%">글제목</td>
						<td><%=rbs.getRbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br/>")%></td>
					</tr>
					<tr>
						<td style="width: 20%">작성일자</td>
						<td><%=rbs.getRbsDate().substring(0, 16)%></td>
					</tr>
					<tr>
						<td style="width: 20%">작성자</td>
						<td><%=rbs.getUserID()%></td>
					</tr>
					<tr>
						<td style="width: 20%">조회수</td>
						<td><%=rbs.getRbsHit()%></td>
					</tr>
					<%
						if (rbs.getRbsVideoSrc() != null) {
					%>
					<tr>
						<td colspan="2"><iframe width="640" height="360"
								src="https://www.youtube.com/embed/<%=rbs.getRbsVideoSrc()%>"
								frameborder="0" allowfullscreen></iframe></td>
					</tr>
					<%
						}
						if (rbs.getRbsImage() != null) {
					%>
					<tr>
						<td colspan="2"><img src="<%=rbs.getRbsImage()%>" style="max-width:1024px; height:auto;'"></td>
					</tr>
					<%
						}
					%>
					<tr>
						<td style="width: 20%">내용</td>
						<td style="min-height: 200px; text-align: left;"><%=rbs.getRbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br/>")%></td>
					</tr>
				</tbody>
			</table>
				<div class="container">
				<div class="row">
					<form method="post" action="rcmtUpdateAction.jsp?rcmtID=<%=rcmtID%>">
						<table class="table table-striped"
							style="text-align: center; border: 1px solid #dddddd;">
							<thead>
								<tr>
									<th colspan="3" style="background-color: #eeeeee;">댓글 수정</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td style="width: 20%;">
										<p>댓글 내용</p>
									</td>
									<td style="width: 60%;"><textarea class="form-control"
											placeholder="댓글 내용" name="rcmtContent" maxlength="200"
											style="height: 80px;"><%=rcmt.getRcmtContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
													.replaceAll("\n", "<br/>") %></textarea></td>
									<td style="width: 20%;"><input
										style="width: 100%; height: 80px; background-color: #695d46; border: 2px solid #695d46;" type="submit"
										class="btn btn-primary" value="댓글 수정"></td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
			</div>

			<div class="container">
				<div class="row">
					<table class="table table-striped"
						style="text-align: center; border: 1px solid #dddddd">
						<tbody>
							<%
								ArrayList<Rcmt> list = rcmtDAO.getList(rcmtPageNumber);
								for (int i = 0; i < list.size(); i++) {
									if (list.get(i).getRbsID() == rbsID && list.get(i).getRcmtID() !=rcmtID) {
							%>
							<tr>
								<td style="width: 30%"><%=list.get(i).getUserID()%><br /><%=list.get(i).getRcmtDate().substring(0, 16)%></td>
								<td style="width: 60%;"><p style="text-align: left;"><%=list.get(i).getRcmtContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
							.replaceAll(">", "&gt;").replaceAll("\n", "<br/>")%></p></td>
								<%
									if (userID != null && userID.equals(list.get(i).getUserID())) {
								%>
								<td><a
									href="rcmtUpdate.jsp?rcmtID=<%=list.get(i).getRcmtID()%>">수정</a> |
									<a onclick="return confirm('정말로 삭제하시겠습니까?')"
									href="rcmtDeleteAction.jsp?rcmtID=<%=list.get(i).getRcmtID()%>">삭제</a></td>
								<%
									} else {
								%>
								<td colspan="2"></td>
								<%
									}
								%>
							</tr>
							<%
								}
								}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>