package mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import mvc.dbcon.Dbconn;
import mvc.vo.BoardVo;


public class BoardDao {
	private Connection conn; // 전역적으로 연결객체를 쓴다. 외부에서 접속못하게 private으로 막아놓기
	private PreparedStatement pstmt;
	
	public BoardDao() {  // 생성자를 만든다 DB연결하는 /Dbconn 객체 생성하려고, 이거 생성해야 mysql 접속한다.
		Dbconn db = new Dbconn();
		this.conn = db.getConnection();
		
	}
	
	public ArrayList<BoardVo> boardSelectAll () {
		ArrayList<BoardVo> alist = new ArrayList<BoardVo>();  // ArrayList에 BoardVo를 담겠다. BoardVo 안에는 컬럼값을 담겠다.
		 String sql = "SELECT * from board order by originbidx desc, depth asc";
		 ResultSet rs = null; // db 값을 가져오기 위한 전용 클래스
		 
		 //System.out.println("alist");
		 
		 try {
			pstmt = conn.prepareStatement(sql);
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
	
	
	

}
