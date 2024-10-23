package mvc.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mvc.dao.BoardDao;
import mvc.vo.BoardVo;
import mvc.vo.Criteria;
import mvc.vo.PageMaker;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


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
			
			String page = request.getParameter("page");
			if (page == null) page = "1";
			int pageInt = Integer.parseInt(page);  // 문자를 숫자로 변경한다. criteria가 가지고 다닐수 있게
			Criteria cri = new Criteria();
			cri.setPage(pageInt);
			
			PageMaker pm = new PageMaker();
			pm.setCri(cri);
				
			
			BoardDao bd = new BoardDao();
			// 페이징 처리하기 위한 전체 데이터 갯수 가져오기
			int boardCnt = bd.boardTotalCount();
			//System.out.println("게시물 수는?"+boardCnt);
			pm.setTotalCount(boardCnt);                     // <-------- PageMaker에 전체 게시물수를 담아서 페이지 계산		
			
			ArrayList<BoardVo> alist = bd.boardSelectAll(cri);
			//System.out.println("alist==>"+alist);  // 객체 주소가 나오면 객체가 생성된것을 짐작할수 있다.
			
			request.setAttribute("alist", alist);  // 화면까지 가지고 가기위해 request객체에 담는다
			request.setAttribute("pm", pm);     // forward 방식으올 넘기기 때문에 공유가 가능하다.
			
			paramMethod="F";
			url="/board/boardList.jsp";  // 실제 내부경로
			
		}else if (location.equals("boardWrite.aws")) {
			System.out.println("boardWrite");
			
			paramMethod="F";   // 포워드 방식은 내부에서 공유하는것이기 때문에 내부에서 활동하고 이동한다.
			url = "/board/boardWrite.jsp";
			
		} else if (location.equals("boardWriteAction.aws")) {
			System.out.println("boardWriteAction.aws");
			
			/*
			 * //저장될 위치 String savePath ="D:\\"; int sizeLimit = 15*1024*1024; //15M String
			 * dataType ="UTF-8"; DefaultFileRenamePolicy policy = new
			 * DefaultFileRenamePolicy();
			 * 
			 * MultipartRequest multi = new
			 * MultipartRequest(request,savePath,sizeLimit,dataType,policy);
			 */
			
			
			
			// 1. 파라미터 값을 넘겨 받는다
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");
			String password = request.getParameter("password");
			
			HttpSession session = request.getSession();  // 세션 객체를 불러와서
			int midx = Integer.parseInt(session.getAttribute("midx").toString());  // 로그인 할때 담았던 세션변수 midx 값을 꺼낸다.
			
			BoardVo bv = new BoardVo();
			bv.setSubject(subject);
			bv.setContents(content);
			bv.setWriter(writer);
			bv.setPassword(password);
			bv.setMidx(midx);
			System.out.println("값 들어옴?" + bv);
			
			
			// 2. DB처리한다.
			BoardDao bd = new BoardDao();
			int value = bd.boardInsert(bv);
			
			if(value == 2) {  // 입력성공
				paramMethod="S";
				url = request.getContextPath()+"/board/boardList.aws";
			} else {  // 실패했으면
				paramMethod="S";
				url = request.getContextPath()+"/board/boardWrite.aws";
			}
			System.out.println("값 들어옴?" + bd);
			
			
			// 3. 처리후 이동한다 sendRedirect.
			paramMethod="S";
			url = request.getContextPath()+"/board/boardList.aws";
			
			
		}else if (location.equals("boardContents.aws")) {
			System.out.println("boardContents.aws");
			
			// 1. 넘어온 값 받기ㅔ
			String bidx = request.getParameter("bidx");
			System.out.println("bidx --->" +bidx);
			int bidxInt = Integer.parseInt(bidx);
			System.out.println("CobidxInt"+bidxInt);
			
			// 2. 처리하기
			BoardDao bd = new BoardDao();
			int value = bd.boardViewCntUpdate(bidxInt);
			BoardVo bv = bd.boardSelectOne(bidxInt);  // 생성한 메소드 호출(해당되는 bidx의 게시물 데이터 가져옴)
			
			
			request.setAttribute("bv", bv);  // 포워드 방식이라 같은 영역안에 있어서 공유해서 jsp 페이지에서 꺼내쓸수있다
			System.out.println("Cobv" +bv);
			
			// 3. 이동해서 화면 보여주기
			paramMethod = "F";  // 화면을 보여주기 위해 이동
			url = "/board/boardContents.jsp";
			
			
		}else if (location.equals("boardModify.aws")) {
			System.out.println("boardModify.aws");
			
			String bidx = request.getParameter("bidx");
			int bidxInt = Integer.parseInt(bidx);	
			BoardDao bd = new BoardDao(); 
			BoardVo bv = bd.boardSelectOne(bidxInt); 
			
			request.setAttribute("bv", bv);
			
			paramMethod="F"; 			
			url= "/board/boardModify.jsp";
			
		}else if(location.equals("boardModifyAction.aws")) {
			System.out.println("boardModifyAction.aws");
			
			String subject = request.getParameter("subject");
			String contents = request.getParameter("contents");
			String writer = request.getParameter("writer");
			String password = request.getParameter("password");
			String bidx = request.getParameter("bidx");
			int bidxInt = Integer.parseInt(bidx);   //숫자형변환
			
			BoardDao bd = new BoardDao(); 
			BoardVo bv = bd.boardSelectOne(bidxInt); // 원본 게시글 내용이 담긴 bv
			
			paramMethod="S"; 
			
			//비밀번호 체크
			if (password.equals(bv.getPassword())) {				
				
				// 비밀번호가 일치하면	
				BoardDao bd2 = new BoardDao();
				BoardVo bv2 = new BoardVo();  // 수정할 게시글을 담을 bv
				bv2.setSubject(subject);
				bv2.setContents(contents);
				bv2.setWriter(writer);
				bv2.setPassword(password);
				bv2.setBidx(bidxInt);
				
				int value = bd2.boardUpdate(bv2);
				
				if(value == 1) {
					request.setAttribute("bv", bv);	
					url ="/board/boardContents.aws?bidx="+bidx;	
					
				} else {
					url ="/board/boardModify.aws?bidx="+bidx;
				}
			}else {
				//비밀번호가 다르면
				
				url= request.getContextPath()+"/board/boardModify.aws?bidx="+bidx;
			}			
					
		}else if (location.equals("boardRecom.aws")) {
			
			String bidx = request.getParameter("bidx");
			int bidxInt = Integer.parseInt(bidx);
			
			BoardDao bd = new BoardDao();
			int recom = bd.boardRecomUpdate(bidxInt);
			
			PrintWriter out = response.getWriter();
			out.println("{\"recom\": \" "+recom+" \"}");   // json 파일 형태대로 받는 걸로 만듬.
			
			
		//	paramMethod="S";
		//	url="/board/boardContents.aws?bidx="+bidx;
			
			
			
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
