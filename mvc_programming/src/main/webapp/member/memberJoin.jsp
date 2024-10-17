<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE> 회원가입페이지 </TITLE>
  <link href="../css/style.css" type="text/css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-latest.min.js"></script> <!-- jquery CDN주소 -->
  
  <script>
  // alert("test"); // 디버깅용 코드
  
  const email = /[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]$/i;
	  
  //alert(email.test("hello5@email.com")); // 이메일 디버깅 true값
  
  // 버튼을 눌렀을때 check 함수 작동
  
  //Document document; // 이 객체가 이미 내장되어있음. 그래서 생략.
  function check() {
	  var fm = document.frm;
	  
	  
	  if (fm.memberid.value =="") {
		  alert("아이디를 입력해주세요");
		  fm.memberid.focus();
		  return;
	  }else if (fm.btn.value == "") {
		  alert("아이디를 입력해주세요");
		  fm.memberid.focus();
		  return;
	  }else if (fm.btn.value == "N") {
		  alert("아이디중복체크를 해주세요");
		  fm.memberid.focus();
		  return;
	  }else if (fm.memberpwd.value =="") {
		  alert("비밀번호를 입력해주세요");
		  fm.memberpwd.focus();
		  return;
	  }else if (fm.memberpwd2.value =="") {
		  alert("비밀번호가 일치하지 않습니다.");
		  fm.memberpwd2.value="";
		  fm.memberpwd2.focus();
		  return;
	  }else if (fm.membername.value =="") {
		  alert("이름을 입력해주세요");
		  fm.membername.focus();
		  return;
	  }else if (fm.memberemail.value =="") {
		  alert("이메일을 입력해주세요");
		  fm.memberemail.focus();
		  return;
	  }else if (email.test(fm.memberemail.value)==false) {
		  alert("이메일 형식이 올바르지 않습니다.");
		  fm.memberemail.value="";
		  fm.memberemail.focus();
		  return;		  
	  }else if (fm.memberphone.value =="") {
		  alert("전화번호를 입력해주세요");
		  fm.memberphone.focus();
		  return;
	  }else if (fm.memberbirth.value =="") {
		  alert("생년월일을 입력해주세요")
		  fm.memberbirth.focuse();
		  return;
		  
	  }else if (hobbyCheck() == false ) {
		  alert("취미를 한개 이상 선택해주세요.");
		  return;
	  }
	  
	  var ans = confirm("저장하시겠습니까?");
	  if (ans == true) {
		  //alert("이동할 정보등록할 차례입니다.");
		  //action="./memberJoinAction.jsp" method="post" html 홈태그 기능을 자바스크립트로 제어
		  
		  
		  // 가상경로를 사용해서 쓸 예정  가짜경로 형식은 /기능/세부기능.aws
		  fm.action="<%=request.getContextPath()%>/member/memberJoinAction.aws";
		  fm.method="post";
		  fm.submit();
	  }
	  
	  
	  
	  
	  
	  
	  return;  // return 값을 안쓰면 그냥 멈춤 종료.
  }
  
  
  
  function hobbyCheck() {
	  var arr = document.frm.memberhobby; // 문서 객체안에 폼 객체 안에 input 객체선언
	  var flag = false; // 체크유무 초기값 false 선언
	  
	  for (var i=0;i<arr.length;i++) { // 선택한 여러값을 반복해서 출력
		if (arr[i].checked == true) { // 하나라도 선택했다면 true 값 리턴
			flag = true; 
			break;
		}  
		  
	  }
	  /* if (flag == false) {
		  alert("취미를 한개 이상 선택해주세요.");
		  return false;
	  } */
	  return flag;
  }
  
  $(document).ready(function(){
	  $("#btn").click(function(){
		  //alert("중복체크버튼 클릭확인");
		  let memberId = $("#memberid").val();
		  if(memberId == "")
			  alert("아이디를 입력해주세요")
			  
		  
	      $.ajax({
	    	  type : "post",  // 전송방식
	    	  url : "<%=request.getContextPath()%>/member/memberIdCheck.aws",  
	    	  dataType : "json",     // json타입은 문서에서 {"키값" : "value값", "키값2" : "value값2"}
	    	  data : {"memberId" : memberId},
	    	  success : function(result){  //결과가 넘어와서 성공했을때 받는 영역
	    		  //alert("전송성공 테스트");
	    		  //alert("길이는?"result.length);
	    		  //alert("cnt값은?"result.cnt);
	    		  if(result.cnt == 0) {
	    			  alert("사용할 수 있는 아이디입니다.");
	    			  $("btn").val("Y");
	    		  }else{
	    			  alert("사용할 수 없는 아이디입니다.");
	    			  $("#memberid").val(""); // 입력한 아이디 지우기
	    		  }
	    		  
	    	  },
	    	  error : function(){  // 결과가 실패했을때 받는 영역
	    		  alert("전송실패 테스트");
	    	  }
		    
		  
		  
	      });
		  
	  });
	  
  });
  
  </script>



 </HEAD>

 <BODY>

 <header> <a href="./memberJoin.jsp" style="text-decoration : none">회원가입 페이지</a></header>
 <nav> <a href="./memberLogin.jsp" style="text-decoration : none"> 회원로그인 가기</a> </nav>
 <section>
	<article>
	<form name="frm" action="memberJoinAction.jsp" method="post">

	<style>
		table {
			margin:0 auto;



		}

	</style>
	<table border=1 style="length:300px;">
	<tr> 
		<th class="idcolor">아이디</th>
				<td>
					<input type="text" id="memberid" style="width:200px;" maxlength="30" placeholder="아이디를 입력하세요">
					<button type="button" name="btn" id="btn" value="N">아이디 중복 체크</button>
				</td>
	</tr>
	<tr> 
		<th class="idcolor">비밀번호</th>
				<td>
					<input type="password" name="memberpwd" style="width:100px;" maxlength="30">
				</td>
	</tr>
	<tr> 
		<th>비밀번호 확인</th>
				<td>
					<input type="password" name="memberpwd2" style="width:100px;" maxlength="30">
				</td>
	</tr>
	<tr> 
		<th id="name">이름</th>
				<td>
					<input type="text" name="membername" style="width:200px;">
				</td>
	</tr>
	<tr> 
		<th>이메일</th>
				<td>
					<input type="email" name="memberemail" style="width:200px;">
				</td>
	</tr>
	<tr> 
		<th>연락처</th>
				<td>
					<input type="number" name="memberphone" style="width:200px;">
				</td>
	</tr>
	<tr> 
		<th>주소</th>
				<td>
					<select name="memberaddr" style="width:100px;">
						<option value="서울">서울</option>
						<option value="대전" selected>대전</option>
						<option value="부산">부산</option>
						<option value="인천">인천</option>
					</select>
	
				</td>
	</tr>
	<tr> 
		<th>성별</th>
			<td>
				<input type="radio" name="membergender" id="select1"  value="M"><label for="select1">남성</label> 
				<input type="radio" name="membergender" id="select2" value="F" checked><label for="select2">여성</label> 
			</td>
	</tr>
	<tr> 
		<th>생년월일</th>
				<td>
					<input type="number" name="memberbirth" style="width:100px;" maxlength="8"> 예) 20240101
				</td>
	</tr>
	<tr> 
		<th>취미</th>
				<td>
					<input type="checkbox" name="memberhobby" id="check1" value="야구"><label for="check1"> 야구</label>
					<input type="checkbox" name="memberhobby" id="check2" value="축구"><label for="check2"> 축구</label>
					<input type="checkbox" name="memberhobby" id="check3" value="농구"><label for="check3"> 농구</label>
				</td>
	</tr>
	<tr>
		<td colspan=2 style="text-align:center;">
		<button type="button" onclick="check();">
		<img src="https://t1.daumcdn.net/daumtop_deco/images/pctop/2023/logo_daum.png" width="20px" height="20px">
		</button>
			<!-- <input type="submit" name="btn" value="회원정보 저장하기">
			<input type="reset" name="btn" value="초기화"> -->
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
