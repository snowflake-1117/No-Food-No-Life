<%@ page language="java" contentType="text/html; charset=euc-kr"
	pageEncoding="euc-kr"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="mrbs.MrbsDAO"%>
<%@ page import="mrbs.Mrbs"%>
<%@ page import="mrcmt.MrcmtDAO"%>
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

		MrbsDAO mrbsDAO = new MrbsDAO();

		ArrayList<Mrbs> list = mrbsDAO.getBestList();
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
			<li><a href="introduction.jsp">Introduction</a></li>
			<li><a href="rbs.jsp">Recipe</a></li>
			<li><a class="active" href="mrbs.jsp">Community</a></li>
			<li><a href="nbs.jsp">Notice&amp;QnA</a></li>
		</div>
	</ul>
	</nav>
	<%
		if (userID == null) {
	%>
	<div align="right" class="login">
		<a href="login.jsp">�α���</a> | <a href="join.jsp">ȸ������&nbsp;&nbsp;&nbsp;</a>
	</div>
	<%
		} else {
	%>
	<div align="right" class="login">
	<a><%=userID%>�� ȯ���մϴ�!&nbsp;&nbsp;&nbsp;
		<a href="check.jsp">����������</a> | <a href="logoutAction.jsp">�α׾ƿ� <%
			if (userID != null && userID.equals("admin")) {
		%>
		</a> | <a href="memberInfo.jsp">ȸ������&nbsp;&nbsp;&nbsp;</a>
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
		<li><a class="before" href="mrbs.jsp">My recipes</a></li>
		<li><a class="active" href="best.jsp">Best recipes</a></li>
		<li><a class="before" href="bbs.jsp">Free board</a></li>
	</ul>
	</nav>
	<div class="container" align="center"
		style="padding-top: 350px; padding-bottom: 100px;">
		<div class="row">
			<table class="table table-striped" style="text-align: center;">
				<thead>
					<tr>
						<th
							style="background-color: #695d46; width: 10%; text-align: center; border-radius: 15px 0 0 0;">��ȣ</th>
						<th
							style="background-color: #695d46; width: 10%; text-align: center;">ī�װ�</th>
						<th
							style="background-color: #695d46; width: 30%; text-align: center;">����</th>
						<th
							style="background-color: #695d46; width: 10%; text-align: center;">�ۼ���</th>
						<th
							style="background-color: #695d46; width: 20%; text-align: center;">�ۼ���</th>
						<th
							style="background-color: #695d46; width: 10%; text-align: center;">��ȸ��</th>
						<th
							style="background-color: #695d46; width: 10%; text-align: center; border-radius: 0 15px 0 0;">��õ��</th>
					</tr>
				</thead>
				<tbody>
					<%
						MrcmtDAO mrcmtDAO = new MrcmtDAO();

						for (int i = (pageNumber - 1) * 10; i < pageNumber * 10 && i < totalCount; i++) {
					%>
					<tr>
						<td><%=list.get(i).getMrbsID()%></td>
						<td><%=list.get(i).getMrbsCategory()%></td>
						<td><a href="rbsView.jsp?rbsID=<%=list.get(i).getMrbsID()%>"><%=list.get(i).getMrbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br/>")%> [<%=mrcmtDAO.countMrcmt(list.get(i).getMrbsID())%>]
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
			<div align="center">
				<%
					if (pageNumber != 1) {
				%>
				<a href="best.jsp?pageNumber=<%=pageNumber - 1%>"
					class="btn btn-success pull-left"
					style="background-color: #ff7846; border: 1px solid #ff7846;">����</a>
				<%
					}

					for (int i = startPage; i <= endPage; i++) {
						if (i == pageNumber) {
				%>
				<a href="best.jsp?pageNumber=<%=i%>"><b>&nbsp;&nbsp;<%=i%>&nbsp;&nbsp;
				</b></a>
				<%
					} else {
				%>
				<a href="best.jsp?pageNumber=<%=i%>">&nbsp;&nbsp;<%=i%>&nbsp;&nbsp;
				</a>
				<%
					}
					}
					if (pageNumber < totalPage) {
				%>
				<a href="best.jsp?pageNumber=<%=pageNumber + 1%>"
					class="btn btn-success pull-right"
					style="background-color: #ff7846; border: 1px solid #ff7846;">����</a>
				<%
					}
				%>
			</div>
		</div>
		<div>
			<form name="searchForm" method="post" action="bestSearch.jsp"
				style="padding-top: 50px;">
				<select name="searchOption">
					<option value="mrbsTitle">����</option>
					<option value="mrbsContent">����</option>
					<option value="userId">�۾���</option>
					<option value="mrbsCategory">ī�װ�</option>
				</select> <input name="searchInput" type="text" value=""
					placeholder="�˻��� ������ �Է�" /> <input type="submit"
					name="searchSubmit" value="�˻�" />
			</form>
		</div>
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="js/bootstrap.js"></script>
</body>
</html>
</body>
</html>