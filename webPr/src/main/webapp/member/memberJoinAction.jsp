<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>
<%-- <%@page import = "java.sql.Connetion" %> --%>
<%@ include file = "/common/dbconn.jsp" %>
<%@ include file = "/common/function.jsp" %>
<jsp:useBean id="mv" class="Vo.MemberVo" scope="page" />
<!-- scope 범위는 4가지가 있다. page, request, session, application  -->


<jsp:setProperty name="mv" property="*" />  <!-- 바인딩 기술을 위해 변수이름을 같게 -->
    
<% 
/* String memberId = request.getParameter("memberId");
System.out.println("memberId?" + memberId);

String memberPwd = request.getParameter("memberPwd");
System.out.println("memberPwd?" + memberPwd);

String memberPwd2 = request.getParameter("memberPwd2");
System.out.println("memberPwd2?" + memberPwd2);

String memberName = request.getParameter("memberName");
System.out.println("memberName?" + memberName);

String memberEmail = request.getParameter("memberEmail");
System.out.println("memberEmail?" + memberEmail);

String memberPhone = request.getParameter("memberPhone");
System.out.println("memberPhone?" + memberPhone);

String memberAddr = request.getParameter("memberAddr");
System.out.println("memberAddr?" + memberAddr);

String memberGender = request.getParameter("memberGender");
System.out.println("memberGender?" + memberGender);

String memberBirth = request.getParameter("memberBirth");
System.out.println("memberBirth?" + memberBirth);


 String[] memberHobby = request.getParameterValues("memberHobby");
 String memberInHobby="";
for(int i=0; i<memberHobby.length; i++) {
	memberInHobby = memberInHobby+memberHobby[i]+","; 
	System.out.println("memberHobby?"+memberHobby[i]);
	
}  */

// 1. jsp 프로그래밍(낱코딩 방법부터 -> 함수화 -> 객체화 방식)
// 2. java/jsp 프로그래밍(model1, model2, MVC 방식으로 진화되는 방법)
// 3. spring 프레임워크로 프로그래밍 하는 방법.





// conn 객체 안에는 많은 메소드가 있는데. 일단 createStatement 메소드를 사용해서 쿼리 작성

/*  String sql = "insert into member(memberid,memberpwd,membername,"
		+"membergender,memberbirth,memberaddr,"
		+"memberphone,memberemail,memberhobby)"
 + "values('"+memberId+"','"
		+memberPwd+"','"
 		+memberName+"','"
		+memberGender+"','"
 		+memberBirth+"','"
		+memberAddr+"','"
 		+memberPhone+"','"
 		+memberEmail+"','"
 		+memberInHobby+"')";  */



%> 

<%
/* Statement stmt = conn.createStatement(); // 쿼리 구문을 동작시키는 클래스
int value = stmt.executeUpdate(sql); */

// PreparedStatement 클래스는 메소드화 시켜서 사용함

// 매개변수에 인자값 대입해서 함수호출하자
String[] memberHobby = request.getParameterValues("memberhobby");
 String memberInHobby="";
for(int i=0; i<memberHobby.length; i++) {
	memberInHobby = memberInHobby+memberHobby[i]+","; 
	System.out.println("memberhobby?"+memberHobby[i]);
	
}
int value = memberInsert(conn,
						mv.getMemberid(),  // 객체안에 생성해놓은 멤버 메소드를 호출해서 값을 꺼낸다.
						mv.getMemberpwd(),
						mv.getMembername(),
						mv.getMembergender(),
						mv.getMemberbirth(),
						mv.getMemberaddr(),
						mv.getMemberphone(),
						mv.getMemberemail(),
						mv.getMemberhobby());

// value 값이 1이면 입력성공 0이면 입력실패다
// 1이면 성공했기 때문에 다른 페이지로 이동시키고 0이면 다시 회원가입 입력페이지로 간다

String pageUrl = "";
String msg = "";
if (value == 1) {// -> index.jsp 파일은 web.xml 웹설정 파일에 기본등록되어있으니 생략가능.
	msg="회원가입 되었습니다";
	pageUrl = request.getContextPath()+"/"; // request.getContextPath(): 프로젝트 이름
//	response.sendRedirect(pageUrl);  // 전송방식 sendRedirect는 요청받으면 다시 그쪽으로 가기.
}else{
	msg="회원 가입 오류발생하였습니다";
	pageUrl = request.getContextPath()+"/member/memberJoin.jsp";
//	response.sendRedirect(pageUrl);
}
%>

<script>
alert("<%=msg%>");
// 자바스크립트로 페이지 이동시킨다 document 객체 안에 location 객체 안에 주소 속성에 담아서
document.location.href="<%=pageUrl%>";

// 디버깅

</script>
  