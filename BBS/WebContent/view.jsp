<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="cmt.Cmt"%>
<%@ page import="cmt.CmtDAO"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width" name="viewport" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>게시판</title>
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
		
		int cmtPageNumber = 1;
		if (request.getParameter("cmtPageNumber") != null) {
			cmtPageNumber = Integer.parseInt(request.getParameter("cmtPageNumber"));
		}

		BbsDAO bbsDAO = new BbsDAO();
		bbsDAO.hit(bbsID);
		Bbs bbs = new BbsDAO().getBbs(bbsID);
	%>
	<nav class="navbar navbar-default">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
			<span class="icon-bar"></span> <span class="icon-bar"></span> <span
				class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
	</div>
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="main.jsp">메인</a></li>
			<li class="active"><a href="bbs.jsp">게시판</a></li>
		</ul>
		<%
			if (userID == null) {
		%>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false">접속하기<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="login.jsp">로그인</a></li>
					<li><a href="join.jsp">회원가입</a></li>
				</ul></li>
		</ul>
		<%
			} else {
		%>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false">회원관리<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="logoutAction.jsp">로그아웃</a></li>
				</ul></li>
		</ul>
		<%
			}
		%>
	
	</nav>
	<div class="container">
		<div>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
								if (userID != null && userID.equals(bbs.getUserID())) {
							%>
			<a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a>
			<a onclick="return confirm('정말로 삭제하시겠습니까?')"
				href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭제</a>
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
							style="background-color: #eeeeee; text-align: center;">게시판 글
							보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%">카테고리</td>
						<td><%=bbs.getBbsCategory()%></td>
					</tr>
					<tr>
						<td style="width: 20%">글제목</td>
						<td><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br/>")%></td>
					</tr>
					<tr>
						<td style="width: 20%">작성일자</td>
						<td><%=bbs.getBbsDate().substring(0, 16)%></td>
					</tr>
					<tr>
						<td style="width: 20%">작성자</td>
						<td><%=bbs.getUserID()%></td>
					</tr>
					<tr>
						<td style="width: 20%">조회수</td>
						<td><%=bbs.getBbsHit()%></td>
					</tr>
					<tr>
						<td style="width: 20%">추천수</td>
						<td><%=bbs.getBbsLike()%></td>
					</tr>
					<%
						if (bbs.getBbsVideoSrc() != null) {
					%>
					<tr>
						<td colspan="2"><iframe width="640" height="360"
								src="https://www.youtube.com/embed/<%=bbs.getBbsVideoSrc()%>"
								frameborder="0" allowfullscreen></iframe></td>
					</tr>
					<%
						}
					%>
					<tr>
						<td style="width: 20%">내용</td>
						<td style="min-height: 200px; text-align: left;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br/>")%></td>
					</tr>
					<tr>
						<td colspan="2"><a href="like.jsp?bbsID=<%=bbsID%>"
							class="btn btn-primary">추천<br /><%=bbs.getBbsLike()%></a></td>
					</tr>
				</tbody>
			</table>
			<div class="container">
				<div class="row">
					<form method="post" action="cmtWriteAction.jsp">
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
											placeholder="댓글 내용" name="cmtContent" maxlength="200"
											style="height: 80px;"></textarea></td>
									<td style="width: 20%;"><input
										style="width: 100%; height: 80px;" type="submit"
										class="btn btn-primary" value="댓글 작성"></td>
								</tr>
							</tbody>
							<input style="display: none;" type="text" name="bbsID"
								value="<%=bbsID%>">
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
								CmtDAO cmtDAO = new CmtDAO();
								ArrayList<Cmt> list = cmtDAO.getList(cmtPageNumber);
								for (int i = 0; i < list.size(); i++) {
									if (list.get(i).getBbsID() == bbsID) {
							%>
							<tr>
								<td style="width: 30%"><%=list.get(i).getUserID()%><br /><%=list.get(i).getCmtDate().substring(0, 16)%></td>
								<td style="width: 60%;"><p style="text-align: left;"><%=list.get(i).getCmtContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
							.replaceAll(">", "&gt;").replaceAll("\n", "<br/>")%></p></td>
								<%
									if (userID != null && userID.equals(list.get(i).getUserID())) {
								%>
								<td><a href="cmtUpdate.jsp?cmtID=<%=list.get(i).getCmtID()%>">수정</a> | <a
									onclick="return confirm('정말로 삭제하시겠습니까?')"
									href="cmtDeleteAction.jsp?cmtID=<%=list.get(i).getCmtID()%>">삭제</a></td>
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