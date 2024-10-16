<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>  



<%
String msg="";
if(session.getAttribute("msg") != null){
	msg = (String)session.getAttribute("msg");
}
session.setAttribute("msg","");

int midx = 0;
String memberId = "";
String memberName = "";
String alt = "";
String logMsg="";
if(session.getAttribute("midx") != null) {  // 로그인이 되었으면
	midx = (int)session.getAttribute("midx");
	memberId = (String)session.getAttribute("memberid");
	memberName = (String)session.getAttribute("memberName");
	
	
	alt = memberName+ "님 로그인되었습니다.";
	logMsg = "<a href='"+request.getContextPath()+"/member/memberLogout.aws'>로그아웃</a>";

}else{
	alt = "로그인하세요";
	logMsg = "로그인";
}




%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>와우 메인페이지라고</title>
<link href="./css/style.css" type="text/css" rel="stylesheet">
<script type="text/javascript">
<%if(!msg.equals("")) { %>
	alert('<%=msg%>');
<%}%>
</script>


<style>


.main {
	width : 600px;
	height : 300px;
	text-align : center;
	margin : 50px;
	border : 5px solid skyblue; 
	padding : 50px;
	
	
}


</style>


</head>
<body>
<%=alt %>
<%=logMsg %>
<hr>
<div class="main">어서오시게 메인페이지 일세</div>
<div>
<a href="<%=request.getContextPath() %>/member/memberJoin.aws">회원가입 페이지 가기</a>
</div>

<div>
<a href="<%=request.getContextPath() %>/member/memberLogin.aws">회원로그인 페이지 가기</a>
회원로그인하기
</div>

</body>
</html>
