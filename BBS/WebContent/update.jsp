<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
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
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}

		Bbs bbs = new BbsDAO().getBbs(bbsID);

		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
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
			<li><a href="notice.html">Notice&amp;QnA</a></li>
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
	<div style="padding-top: 350px; padding-bottom: 200px;"
		class="container" align="center">
		<div class="row">
			<form method="post" action="updateAction.jsp?bbsID=<%=bbsID%>"
				enctype="multipart/form-data">
				<table class="table" style="text-align: center;">
					<thead>
						<tr>
							<th height="50px" colspan="2"
								style="background-color: #695d46; color: #ffffff; text-align: center; vertical-align: middle;">
								게시판글쓰기 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 30%;">
								<p>Category</p>
							</td>
							<td><select class="form-control" name="bbsCategory">
									<option value="<%=bbs.getBbsCategory()%>"><%=bbs.getBbsCategory()%></option>
									<option value="요리팁">요리팁</option>
									<option value="요리질문">요리질문</option>
									<option value="일상/잡답">일상/잡담</option>
							</select></td>
						</tr>
						<tr>
							<td style="width: 30%;">
								<p>제목</p>
							</td>
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="bbsTitle" maxlength="50"
								value="<%=bbs.getBbsTitle()%>" /></td>
						</tr>
						<tr>
							<td style="width: 30%;">
								<p>첨부할 동영상 링크</p>
							</td>
							<%
								if (bbs.getBbsVideoSrc() == null) {
							%>
							<td><input type="url" class="form-control"
								placeholder="https://www.youtube.com/watch?v=... 또는 https://youtu.be/..."
								name="bbsVideoSrc" maxlength="200" /></td>
							<%
								} else {
							%>
							<td><input type="url" class="form-control"
								placeholder="https://www.youtube.com/watch?v=... 또는 https://youtu.be/..."
								name="bbsVideoSrc" maxlength="200"
								value="https://youtu.be/<%=bbs.getBbsVideoSrc()%>" /></td>
							<%
								}
							%>
						</tr>
						<tr>
							<td style="width: 30%;">
								<p>첨부할 이미지 파일</p>
							</td>
							<td><input type="file" class="form-control" name="bbsImage" /></td>
						</tr>
						<tr>
							<td style="width: 30%;">
								<p>내용</p>
							</td>
							<td><textarea class="form-control" placeholder="글 내용"
									name="bbsContent" maxlength="20000" style="height: 500px;"><%=bbs.getBbsContent()%></textarea></td>
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
