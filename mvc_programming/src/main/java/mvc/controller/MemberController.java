package mvc.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mvc.dao.MemberDao;
import mvc.vo.MemberVo;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;


@WebServlet("/MemberController")  // 서블릿: 자바로 만든 웹페이지 (접속주소:/MemberController)
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String location; // 멤버변수(전역) 초기화 => 이동할 페이지
	
	public MemberController(String location) {
		this.location = location;
		
	}
	
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		// 넘어온 모든 값은 여기에서 처리해서 분기한다 - controller 역활
		
		//System.out.println("값이 넘어오나요?");
		
		// 전체주소를 추출
		/*
		 * String uri = request.getRequestURI(); //System.out.println("uri"+uri); //
		 * uri/mvc_programming/member/memberJoinAction.aws String[] location =
		 * uri.split("/"); // 위의 주소에서 끝부분에 있는 글자가 무엇인지 물어보는 것
		 */		
		
		String paramMethod = "";  // 전송방식이 sendRedirect면 S forward방식이면 F
		String url="";
		
		if(location.equals("memberJoinAction.aws")) {  //4번째 방의 값이 memberJoinAction.aws이면 처리를 하라.
			
			String memberId = request.getParameter("memberid");
			String memberPwd = request.getParameter("memberpwd");
			String memberPwd2 = request.getParameter("memberpwd2");
			String memberName = request.getParameter("membername");
			String memberEmail = request.getParameter("memberemail");
			String memberPhone = request.getParameter("memberphone");
			String memberAddr = request.getParameter("memberaddr");
			String memberGender = request.getParameter("membergender");
			System.out.println("membergender" + memberGender);
			String memberBirth = request.getParameter("memberbirth");
			String[] memberHobby = request.getParameterValues("memberhobby");
			String memberInHobby = "";
			    for (int i = 0; i < memberHobby.length; i++) {
			        memberInHobby = memberInHobby + memberHobby[i] + ",";
			}
				MemberDao md = new MemberDao();
				int value = md.memberInsert(
						 memberId,  
						 memberPwd,
						 memberName,
						 memberGender,
						 memberBirth,
						 memberAddr,
						 memberPhone,
						 memberEmail,
						 memberInHobby);

				String msg = "";
				
				HttpSession session = request.getSession();
				
				if (value == 1) {
					msg="회원가입 되었습니다";
					session.setAttribute("msg", msg);
					
					url = request.getContextPath()+"/"; 
					
				
				}else{
					msg="회원 가입 오류발생하였습니다";
					session.setAttribute("msg", msg);
					
					url = request.getContextPath()+"/member/memberJoin.jsp";
					  //sendRedirect 방식은 새롭게 다른쪽으로 가라고 지시
				
				}
				//System.out.println("msg는?" + msg);
				paramMethod="S";  // 밑에서 sendRedirect 방식으로 처리한다.
				
		}else if(location.equals("memberJoin.aws")){
			//System.out.println("들어왔나?");
			
			url ="/member/memberJoin.jsp";
			paramMethod ="F";  // 하단에서 포워드로 처리합니다.
			  // 스펠링 꼭 체크할것 
			// 아무리 코드를 잘 했다고 하더라도 마지막까지 변수이름이랑 스펠링이 맞는지 확인 필요.
			//System.out.println("rd객체가 생겼니?" + rd);
			 // 포워드 방식 : 내부안에서 넘겨서 토스하겠다는 뜻
		
		
	  }else if(location.equals("memberLogin.aws")) {
		  //System.out.println("들어왔나?");
		  url ="/member/memberLogin.jsp";
		  paramMethod ="F";  // 하단에서 포워드로 처리합니다.
		 
	  }else if (location.equals("memberLoginAction.aws")) {
		  
		 // System.out.println("memberLoginAction 들어왔나?");
		  
		  String memberId = request.getParameter("memberid");
		  String memberPwd = request.getParameter("memberpwd");
		  
		  
		  MemberDao md = new MemberDao();
		  MemberVo mv = md.memberLoginCheck(memberId, memberPwd);
		  //System.out.println("mv객체가 생겼나요?" + mv); mv 객체가 생겼나 디버깅
		  
		  if (mv == null) {
			  url=request.getContextPath()+"/member/memberLogin.aws";
			  paramMethod = "S";		  
			    // 해당 주소로 다시 가세요
			  
		  }else {
			  // 해당되는 로그인 사용자가 있으면 세션에 회원정보 담아서 메인으로 가라
			  String mid = mv.getMemberid();  // 아이디 꺼내기
			  int midx = mv.getMidx();  // 회원번호 꺼내기
			  String memberName = mv.getMembername();  // 이름 꺼내기
			  
			  HttpSession session = request.getSession();
			  session.setAttribute("mid", mid);
			  session.setAttribute("midx", midx);
			  session.setAttribute("memberName", memberName);
			  
			  url = request.getContextPath()+"/";
			  paramMethod = "S";  // 로그인 되었으면 메인으로 가세요
		  }		  
	  }else if (location.equals("memberLogout.aws")) {
		  //System.out.println("memberLogout");
		  
		  // 세션 삭제
		  HttpSession session = request.getSession();  // 세션 객체 이용
		  session.removeAttribute("mid");
		  session.removeAttribute("midx");
		  session.removeAttribute("memberName");
		  session.invalidate();
		  
		  // 초기화 하고 다시 메인으로 가기
		  
		  url = request.getContextPath()+"/";
		  paramMethod = "S";
		  
		  
	  }else if (location.equals("memberList.aws")) {
		  System.out.println("들어옴?");
		  
		  //1. 메소드 불러서 처리하는 코드를 만들어야한다
		  MemberDao md = new MemberDao(); // 객체 생성
		  ArrayList<MemberVo> alist = md.memberSelectAll();
		  
		  request.setAttribute("alist", alist);
		  
		  
		  //2. 보여줄 페이지를 forward 방식으로 보여준다. 공유의 특성을 가지고있다.
		  String uri2 = "/member/memberList.jsp";
		 url = "/member/memberList.jsp";
		 paramMethod="F";
		  
		  
	  }else if (location.equals("memberIdCheck.aws")) {
		  System.out.println("넘어옴?");
		  
		  String memberId = request.getParameter("memberId");
		  
		  MemberDao md = new MemberDao();
		  int cnt = md.memberIdCheck(memberId);
		  //System.out.println("cnt:"+cnt);
		  PrintWriter out = response.getWriter();
		  out.println("{\"cnt\": \" "+cnt+" \"}");
		  
		  
		  
	  }
		
		if (paramMethod.equals("F")) {
			RequestDispatcher rd = request.getRequestDispatcher(url);
			rd.forward(request, response);
		}else if(paramMethod.equals("S")){
			response.sendRedirect(url);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
