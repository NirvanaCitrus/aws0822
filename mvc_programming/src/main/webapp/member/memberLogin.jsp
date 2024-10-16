<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE> 회원로그인 </TITLE>
<style>

header {
	width:100%;
	height: 100px;
	text-align:center;
	--background-color:white;
}

nav {
	width: 15%; 
	height: 300px; 
	float: left;
	--background-color:white;

}

section {
	width: 70%;
	height: 300px;
	float: left;
	--background:olivedrab;


}

aside {
	width: 15%;
	height: 300px;
	float: left;
	--background:orange;

}

footer {
	width: 100%;
	height: 15%;
	clear: both;
	text-align:center;
	--background:plum;



}

body {
	background-color:skyblue;
	margin:0px;

}

input[type=text] {
	background : white;
}



</style>

<script>
function check() {
	// 이름으로 객체 찾기
	let memberid = document.getElementsByName("memberid");
	let memberpwd = document.getElementsByName("memberpwd");
	//alert(memberid[0].value);
	//alert(memberpwd[0].value);
	if (memberid[0].value == "") {
		alert("아이디를 입력해주세요");
		memberid[0].focus();
		return;
		
	}else if (memberpwd[0].value == "") {
		alert("비밀번호를 입력해주세요");
		memberpwd[0].focus();
		return;
	}
	
	var fm = document.frm;
	fm.action = "<%=request.getContextPath()%>/member/memberLoginAction.aws";  // 가상경로 지정 action은 처리하는 의미
	fm.method = "post";
	fm.submit();
	
	
	return;
}

</script>


 </HEAD>

 <BODY>

 <header>회원로그인 페이지</header>
 <nav></nav>
 <section>
	<article>
	<div id="parent">
	<div id ="child">
<form name="frm">

	<style>
		table {
			margin:0 auto;



		}

	</style>
	<table border=1 style="length:300px;">
	<tr> 
	<th>아이디</th>
			<td>
				<input type="text" name="memberid" style="width:150px;" maxlength="30">
			</td>
	</tr>
	<tr> 
	<th>비밀번호</th>
			<td>
				<input type="password" name="memberpwd" style="width:150px;" maxlength="30">
			</td>
	</tr>
	
	<tr>
		<td colspan=2 style="text-align:center;">
			<input type="button" name="btn" value="로그인" onclick="check();">
		</td>
	</tr>

	<tr>
		<td>
			<input type="button" name="btn" value="아이디 찾기">
		</td>
		<td>
			<input type="button" name="btn" value="비밀번호 찾기">
		</td>

	</tr>


	</table>
</form>		
	
	
	
	</article>
 </section>
 <aside>
 </aside>


 <footer>
 made by META.
 </footer>
 </BODY>
</HTML>
