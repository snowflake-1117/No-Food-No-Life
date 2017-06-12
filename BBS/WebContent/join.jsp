<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width" name="viewport" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/main.css">	
<title>회원가입</title>


<script>
function idCheck(){//아이디길이 4~12자 제한 체크, 영문+숫자인지 체크
	var id= document.addform.userID.value;
	var str = /^[A-Za-z0-9_-]{4,12}/; //아이디 영문대소문자,숫자,(_)로만 구성하도록 검사할 정규표현식
	
	if(!str.test(id)){//아이디(id)가 str의 범주에 해당할 경우(영문대소문자나 숫자,(_)가 아닐 경우)+글자 수 만족 안 할 때 조건문이 참이된다.
		alert("아이디를 4~12글자의 영문대소문자+숫자,(_)로  입력해주세요.");	
		document.addform.userID.focus();
		return false; 
	}
	return true;//아이디 제대로 입력시 true 반환
}
function passCheck(){ //비밀번호, 비밀번호 확인 같은지 체크
	 var pass= document.addform.userPassword.value;
	 var str = /^[A-Za-z0-9_-]{6,16}$/;//비밀번호를 영문대소문자,숫자,(_)로만 구성하도록 검사할 정규표현식
	 if(!str.test(pass)){//비밀번호(pass)가 str의 범주에 해당할 경우(영문대소문자나 숫자,(_)가 아닐 경우)+글자수 만족 안 할 때 조건문이 참이된다.
		 alert("비밀번호를 6~16글자의 영문 대소문자나 숫자,(_)로  입력해주세요.");
		 document.addform.userPassword.focus();
		 return false;
	 }
	 else if(document.addform.userPassword.value!=document.addform.userPassword_Re.value){
		 //비밀번호와 비밀번호 확인의 값이 다를 경우
		 alert('비밀번호가 일치하지 않습니다');
		 document.addform.userPassword_Re.focus();
		 return false;
	 }
	 return true;
}
function emailCheck() {
	var email = document.addform.userEmail.value;
	var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

	if (regex.test(email)==false) {
		alert("잘못된 이메일 형식입니다.");
		return false;
	}
	else return true;

}
/*
function nameCheck() {
	var name = document.addform.userName.value;
	if (name)
		return true;
	else {
		alert("이름을 입력하지 않았습니다.");
		reutnr false;
	}
}*/
function memReg(){//가입하기 전 id길이와 비밀번호 체크
	var v = idCheck();//v는 아이디 제대로 입력시 true, 그렇지 않을시 false가 된다.
	if(v)//아이디가 제대로 입력됐다면 비밀번호 검사실행, 아니면 비밀번호 체크 함수는 실행하지 않음.
		var v = passCheck();
	if(v)
		var v = emailCheck();
	if(v)
		document.addform.submit();
	

}
</script>
</head>
<body>
	<nav>
		<header class="header" style="font-size:60px; margin-top:100px;"><a href="main.jsp" style="text-decoration: none; color:#ff7846">No Food, No life!</a></header>
		
		<div class="container">
			<div style="margin-top:200px; width:380px; position:absolute; left:50%; margin-left:-190px; margin-bottom:100px;">
				<div class="jumbotron" style="height:400px; padding-top:20px; padding-bottom:10px;">
					<form method="post" action="joinAction.jsp" name="addform">
						<h3 style="text-align:center;">회원가입 화면</h3>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="아이디(4~12자)" name="userID" maxlength="10" onblur="ID_Check()">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호(6~16자)" name="userPassword" maxlength="20">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호 확인" name="userPassword_Re" maxlength="20">
 						</div>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="이름" name="userName" value="" maxlength="20">
						</div>
						<div class="form-group">
							<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="50">
						</div>
						<br><input type="button" onclick="memReg()" style="width:250px;background-color:orange; border-color:orange; "class="btn btn-primary form-control" value="가입하기">
					</form>
				</div>
				<hr>
				<a href="login.jsp">로그인</a>
				</div>
			</div>
		
	</nav>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>