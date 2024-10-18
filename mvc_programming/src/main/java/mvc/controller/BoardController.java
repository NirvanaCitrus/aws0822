package mvc.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mvc.dao.BoardDao;
import mvc.vo.BoardVo;

import java.io.IOException;
import java.util.ArrayList;


@WebServlet("/BoardController")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String location; // 멤버변수(전역) 초기화 => 이동할 페이지
	
	public BoardController(String location) {
		this.location = location;
		
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String paramMethod = "";  // 전송방식이 sendRedirect면 S forward방식이면 F
		String url="";
		
		if(location.equals("boardList.aws")) {  // 가상경로
			
			BoardDao bd = new BoardDao();
			ArrayList<BoardVo> alist = bd.boardSelectAll();
			System.out.println("alist==>"+alist);  // 객체 주소가 나오면 객체가 생성된것을 짐작할수 있다.
			
			request.setAttribute("alist", alist);
			
			paramMethod="F";
			url=request.getContextPath()+"/board/boardList.jsp";  // 실제 내부경로
			
		}else if (location.equals("boardWrite.aws")) {
			
			url ="/board/boardWrite.jsp";
			paramMethod="F";
			
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
