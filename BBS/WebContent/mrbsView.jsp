<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="mrbs.Mrbs"%>
<%@ page import="mrbs.MrbsDAO"%>
<%@ page import="mrcmt.Mrcmt"%>
<%@ page import="mrcmt.MrcmtDAO"%>
<%@ page import="java.util.ArrayList"%>

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
		int mrbsID = 0;
		if (request.getParameter("mrbsID") != null) {
			mrbsID = Integer.parseInt(request.getParameter("mrbsID"));
		}
		if (mrbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='mrbs.jsp'");
			script.println("</script>");
		}

		int mrcmtPageNumber = 1;
		if (request.getParameter("mrcmtPageNumber") != null) {
			mrcmtPageNumber = Integer.parseInt(request.getParameter("mrcmtPageNumber"));
		}

		MrbsDAO mrbsDAO = new MrbsDAO();
		mrbsDAO.hit(mrbsID);
		Mrbs mrbs = new MrbsDAO().getMrbs(mrbsID);
	%>

	<header class="header"> <a href="main.jsp"
		style="text-decoration: none; color: #ff7846">No Food, No life!</a> <br>
	</header>
	<nav align="center">
	<ul class="nav">
		<div>
			<li><a class="before" href="introduction.jsp">Introduction</a></li>
			<li><a class="before" href="rbs.jsp">Recipe</a></li>
			<li><a class="active" href="mrbs.jsp">Community</a></li>
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

	<div class="container"
		style="padding-top: 350px; padding-bottom: 200px;">
		<div style="padding-bottom: 30px;">
			<div>
				<a href="mrbs.jsp"
					style="background-color: #695d46; border: 2px solid #695d46"
					class="btn btn-success pull-right">목록</a>
			</div>
			<%
				if (userID != null && (userID.equals(mrbs.getUserID())||userID.equals("admin"))) {
			%>
			<a href="mrbsUpdate.jsp?mrbsID=<%=mrbsID%>"
				style="background-color: #ff7846; border: 1px solid #ff7846;"
				class="btn btn-primary">수정</a> <a
				onclick="return confirm('정말로 삭제하시겠습니까?')"
				href="mrbsDeleteAction.jsp?mrbsID=<%=mrbsID%>"
				style="background-color: #ff7846; border: 1px solid #ff7846;"
				class="btn btn-primary">삭제</a>
			<%
				}
			%>
		</div>
		<div class="row">
			<table class="table table-striped"
				style="text-align: center;">
				<thead>
					<tr>
						<th colspan="2"
							style="background-color: #695d46; color: #ffffff; text-align: center;  border-radius: 15px 15px 0 0;">게시판
							글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%">카테고리</td>
						<td><%=mrbs.getMrbsCategory()%></td>
					</tr>
					<tr>
						<td style="width: 20%">글제목</td>
						<td><%=mrbs.getMrbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br/>")%></td>
					</tr>
					<tr>
						<td style="width: 20%">작성일자</td>
						<td><%=mrbs.getMrbsDate().substring(0, 16)%></td>
					</tr>
					<tr>
						<td style="width: 20%">작성자</td>
						<td><%=mrbs.getUserID()%></td>
					</tr>
					<tr>
						<td style="width: 20%">조회수</td>
						<td><%=mrbs.getMrbsHit()%></td>
					</tr>
					<%
						if (mrbs.getMrbsVideoSrc() != null) {
					%>
					<tr>
						<td colspan="2"><iframe width="640" height="360"
								src="https://www.youtube.com/embed/<%=mrbs.getMrbsVideoSrc()%>"
								frameborder="0" allowfullscreen></iframe></td>
					</tr>
					<%
						}
						if (mrbs.getMrbsImage() != null) {
					%>
					<tr>
						<td colspan="2"><img src="<%=mrbs.getMrbsImage()%>"
							style="max-width: 1024px; height: auto;'"></td>
					</tr>
					<%
						}
					%>
					<tr>
						<td style="width: 20%">내용</td>
						<td style="min-height: 200px; text-align: left;"><%=mrbs.getMrbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br/>")%></td>
					</tr>
					<tr>
						<td colspan="2"><a href="mrbsLike.jsp?mrbsID=<%=mrbsID%>"
							style="background-color: #ff7846; border: 1px solid #ff7846;"
							class="btn btn-primary">추천<br /><%=mrbs.getMrbsLike()%></a></td>
					</tr>
				</tbody>
			</table>
			<div class="container">
				<div class="row">
					<form method="post" action="mrcmtWriteAction.jsp">
						<table class="table table-striped"
							style="text-align: center; border: 1px solid #dddddd;">
							<thead>
								<tr>
									<th colspan="3" style="background-color: #eeeeee;">댓글 작성</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td style="width: 20%;">
										<p>댓글 내용</p>
									</td>
									<td style="width: 60%;"><textarea class="form-control"
											placeholder="댓글 내용" name="mrcmtContent" maxlength="200"
											style="height: 80px;"></textarea></td>
									<td style="width: 20%;"><input type="submit"
										style="width: 100%; height: 80px; background-color: #695d46; border: 2px solid #695d46"
										class="btn btn-primary" value="댓글 작성"></td>
								</tr>
							</tbody>
							<input style="display: none;" type="text" name="mrbsID"
								value="<%=mrbsID%>">
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
								MrcmtDAO mrcmtDAO = new MrcmtDAO();
								ArrayList<Mrcmt> list = mrcmtDAO.getList(mrcmtPageNumber);
								for (int i = 0; i < list.size(); i++) {
										if (list.get(i).getMrbsID() == mrbsID) {
							%>
							<tr>
								<td style="width: 30%"><%=list.get(i).getUserID()%><br /><%=list.get(i).getMrcmtDate().substring(0, 16)%></td>
								<td style="width: 60%;"><p style="text-align: left;"><%=list.get(i).getMrcmtContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br/>")%></p></td>
								<%
									if (userID != null && (userID.equals(list.get(i).getUserID())||userID.equals("admin"))) {
								%>
								<td><a
									href="mrcmtUpdate.jsp?mrbsID=<%=mrbsID %>&mrcmtID=<%=list.get(i).getMrcmtID()%>">수정</a> |
									<a onclick="return confirm('정말로 삭제하시겠습니까?')"
									href="mrcmtDeleteAction.jsp?mrcmtID=<%=list.get(i).getMrcmtID()%>">삭제</a></td>
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