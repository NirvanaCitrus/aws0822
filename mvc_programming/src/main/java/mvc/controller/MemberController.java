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


@WebServlet("/MemberController")  // 서블릿: 자바로 만든 웹페이지 (접속주소:/MemberController)
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		// 넘어온 모든 값은 여기에서 처리해서 분기한다 - controller 역활
		
		//System.out.println("값이 넘어오나요?");
		
		// 전체주소를 추출
		String uri = request.getRequestURI();
		System.out.println("uri"+uri);		// uri/mvc_programming/member/memberJoinAction.aws
		String[] location = uri.split("/");
		
		if(location[2].equals("memberJoinAction.aws")) {  //4번째 방의 값이 memberJoinAction.aws이면 처리를 하라.
			
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

				
				String pageUrl = "";
				String msg = "";
				
				HttpSession session = request.getSession();
				
				if (value == 1) {
					msg="회원가입 되었습니다";
					session.setAttribute("msg", msg);
					
					pageUrl = request.getContextPath()+"/"; 
					response.sendRedirect(pageUrl);
				
				}else{
					msg="회원 가입 오류발생하였습니다";
					session.setAttribute("msg", msg);
					
					pageUrl = request.getContextPath()+"/member/memberJoin.jsp";
					response.sendRedirect(pageUrl);  //sendRedirect 방식은 새롭게 다른쪽으로 가라고 지시
				
				}
				//System.out.println("msg는?" + msg);
				
		}else if(location[2].equals("memberJoin.aws")){
			System.out.println("들어왔나?");
			
			String uri2="/member/memberJoin.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(uri2);  // 스펠링 꼭 체크할것 
			// 아무리 코드를 잘 했다고 하더라도 마지막까지 변수이름이랑 스펠링이 맞는지 확인 필요.
			//System.out.println("rd객체가 생겼니?" + rd);
			rd.forward(request, response); // 포워드 방식 : 내부안에서 넘겨서 토스하겠다는 뜻
		
		
	  }else if(location[2].equals("memberLogin.aws")) {
		  System.out.println("들어왔나?");
		  String uri3="/member/memberLogin.jsp";
		  RequestDispatcher rd = request.getRequestDispatcher(uri3);
		  rd.forward(request, response);
	  }
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
