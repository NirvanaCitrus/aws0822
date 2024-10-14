<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mv" class="mvc.vo.MemberVo" scope="page" />
<%@ page import="mvc.dao.MemberDao" %>
<jsp:setProperty name="mv" property="*" />  <!-- 바인딩 기술을 위해 변수이름을 같게 -->
    
<% 

String[] memberHobby = request.getParameterValues("memberhobby");
String memberInHobby = "";
//if (memberHobby != null) {
    for (int i = 0; i < memberHobby.length; i++) {
        memberInHobby = memberInHobby + memberHobby[i] + ",";
  //  }
}
	MemberDao md = new MemberDao();
	int value = md.memberInsert(mv.getMemberid(),  
				mv.getMemberpwd(),
				mv.getMembername(),
				mv.getMembergender(),
				mv.getMemberbirth(),
				mv.getMemberaddr(),
				mv.getMemberphone(),
				mv.getMemberemail(),
				memberInHobby);



	// 매개변수에 인자값 대입해서 함수호출하자
	
	
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
	console.log(pageUrl);
	
	// 디버깅
	
	</script>
  