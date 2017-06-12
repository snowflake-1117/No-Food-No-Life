<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="rbs.Rbs"%>
<%@ page import="rbs.RbsDAO"%>
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

		Rbs rbs = new RbsDAO().getRbs(rbsID);

		if (!userID.equals(rbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='rbs.jsp'");
			script.println("</script>");
		}
	%>
	<header class="header"> <a href="main.jsp"
		style="text-decoration: none; color: #ff7846">No Food, No life!</a> <br>
	</header>
	<nav align="center">
	<ul class="nav">
		<div>
			<li><a class="before" href="introduction.jsp">Introduction&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			<li><a class="active" href="rbs.jsp">Recipe&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			<li><a class="before" href="mrbs.jsp">Community&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
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
	<div style="padding-top: 350px; padding-bottom: 200px;"
		class="container" align="center">
		<div class="row">
			<form method="post" action="rbsUpdateAction.jsp?rbsID=<%=rbsID%>"
				enctype="multipart/form-data">
				<table class="table" style="text-align: center;">
					<thead>
						<tr>
							<th height="50px" colspan="2"
								style="background-color: #695d46; color: #ffffff; text-align: center; vertical-align: middle; border-radius: 15px 15px 0 0;">
								게시판글쓰기 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 30%;">
								<p>Category</p>
							</td>
							<td><select class="form-control" name="rbsCategory">
									<option value="<%=rbs.getRbsCategory()%>"><%=rbs.getRbsCategory()%></option>
									<option value="간단요리">간단요리</option>
									<option value="한식">한식</option>
									<option value="중식">중식</option>
									<option value="일식">일식</option>
									<option value="양식">양식</option>
									<option value="디저트">디저트</option>
							</select></td>
						</tr>
						<tr>
							<td style="width: 30%;">
								<p>제목</p>
							</td>
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="rbsTitle" maxlength="50"
								value="<%=rbs.getRbsTitle()%>" /></td>
						</tr>
						<tr>
							<td style="width: 30%;">
								<p>첨부할 동영상 링크</p>
							</td>
							<%
								if (rbs.getRbsVideoSrc() == null) {
							%>
							<td><input type="url" class="form-control"
								placeholder="https://www.youtube.com/watch?v=... 또는 https://youtu.be/..."
								name="rbsVideoSrc" maxlength="200" /></td>
							<%
								} else {
							%>
							<td><input type="url" class="form-control"
								placeholder="https://www.youtube.com/watch?v=... 또는 https://youtu.be/..."
								name="rbsVideoSrc" maxlength="200"
								value="https://youtu.be/<%=rbs.getRbsVideoSrc()%>" /></td>
							<%
								}
							%>
						</tr>
						<tr>
							<td style="width: 30%;">
								<p>첨부할 이미지 파일</p>
							</td>
							<td><input type="file" name="rbsImage" /></td>
						</tr>
						<tr>
							<td style="width: 30%;">
								<p>내용</p>
							</td>
							<td><textarea class="form-control" placeholder="글 내용"
									name="rbsContent" maxlength="20000" style="height: 500px;"><%=rbs.getRbsContent()%></textarea></td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
					</tbody>
				</table>
				<input type="submit"
					style="background-color: #695d46; border: 2px solid #695d46"
					class="btn btn-primary" value="글수정">
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
