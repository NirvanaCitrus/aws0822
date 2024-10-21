package mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import mvc.dbcon.Dbconn;
import mvc.vo.BoardVo;
import mvc.vo.Criteria;


public class BoardDao {
	private Connection conn; // 전역적으로 연결객체를 쓴다. 외부에서 접속못하게 private으로 막아놓기
	private PreparedStatement pstmt;  // 구문 객체
	
	public BoardDao() {  // 생성자를 만든다 DB연결하는 /Dbconn 객체 생성하려고, 이거 생성해야 mysql 접속한다.
		Dbconn db = new Dbconn();
		this.conn = db.getConnection();
		
	}
	
	public ArrayList<BoardVo> boardSelectAll (Criteria cri) {
		int page = cri.getPage();   // 페이지 번호
		int perPageNum = cri.getPerPageNum();   // 화면 노출 리스트 갯수.
		ArrayList<BoardVo> alist = new ArrayList<BoardVo>();  // ArrayList에 BoardVo를 담겠다. BoardVo 안에는 컬럼값을 담겠다.
		 String sql = "SELECT * from board order by originbidx desc, depth asc limit ?,?";
		 ResultSet rs = null; // db 값을 가져오기 위한 전용 클래스
		 
		 //System.out.println("alist");
		 
		 try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (page-1)*perPageNum);
			pstmt.setInt(2, perPageNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {  // 커서가 다음으로 이동해서 첫 글이 있느냐 물어보고 true면 진행
				int bidx = rs.getInt("bidx");
				String subject = rs.getString("subject");
				String contents = rs.getString("contents");
				String writer = rs.getString("writer");
				int viewcnt = rs.getInt("viewcnt");
				String writeDay = rs.getString("writeday");
				
				BoardVo bv = new BoardVo();  // 첫행부터 mv에 옮겨담기
				bv.setBidx(bidx);
				bv.setSubject(subject);
				bv.setContents(contents);
				bv.setViewcnt(viewcnt);
				bv.setWriter(writer);
				bv.setWriteday(writeDay);
				alist.add(bv);	
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		 
		 
		
		return alist;
	}
	
	// 게시물 전체 갯수 구하기
	public int boardTotalCount() {
		int value = 0;
		// 1. 쿼리 만들기
		String sql="select count(*) as cnt from board where delyn='N'";
		// 2. conn 객체 안에있는 구문 클래스 호출하기
		// 3. DB 컬럼값을 받는 전용 클래스 ResultSet 호출하기(ResultSet 특징은 데이터를 그대로 복사하기 때문에 전달이 빠름)
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {  // 커서를 이동시켜서 첫줄로 옮긴다
				value = rs.getInt("cnt");  // 지역변수 value에 담아서 리턴해서 가져간다.
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {  // 각 객체부터 소멸시키고 DB연결 끊는다.
				rs.close();
				pstmt.close();
				//conn.close();  // conn 은 끊지 않게
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return value;
	}
	
	public int boardInsert(BoardVo bv) {
		int value = 0;
		String subject = bv.getSubject();
		String contents = bv.getContents();
		String writer = bv.getWriter();
		String password = bv.getPassword();
		int midx = bv.getMidx();
		
		String sql = "insert into board(originbidx,depth,level_,subject,content,writer,password,midx)"
				+ " value(null,0,0,'?','?','?','?','?')";
		String sql2 = "update board set originbidx =(select A.maxbidx from(select max(bidx) as maxbidx from board)A)"
				+ "where bidx= (select A.maxbidx from(select max(bidx) as maxbidx from board)A)";
		
		try {
			conn.setAutoCommit(false);  // 수동커밋으로 하겠다
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, contents);
			pstmt.setString(3, writer);
			pstmt.setString(4, password);
			pstmt.setInt(5, midx);
			int exec = pstmt.executeUpdate();   // 실행되면 1 안되면 0
			
			pstmt = conn.prepareStatement(sql2);
			int exec2 = pstmt.executeUpdate();   // 실행되면 1 안되면 0
			
			conn.commit();  // 일괄처리 커밋
			
			value = exec+exec2;
			
		} catch (SQLException e) {
			try {
				conn.rollback();   // 실행중 오류 발생시 rollback 처리
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}finally {
			try {  // 각 객체부터 소멸시키고 DB연결 끊는다.
				pstmt.close();
				conn.close();  // conn 은 끊지 않게
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return value;
	}
	
	

}
