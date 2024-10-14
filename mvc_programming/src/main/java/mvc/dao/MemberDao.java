package mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import mvc.dbcon.Dbconn;

public class MemberDao {  // mvc 방식으로 가기전에 첫번쨰 model 1 방식
	
	private Connection conn;  // 전역변수로 사용 페이지 어느곳에서도 사용할 수 있다.
	
	// 생성자를 통해서 db연결해서 메소드 사용
	public MemberDao() {
		Dbconn dbconn = new Dbconn(); // DB객체 생성
		conn = dbconn.getConnection();  // 메소드 호출해서 연결객체를 가져온다.
		
	}
	
	
	// 어디서나 접근 가능 public, 리턴값 타입은 숫자형 int= 메소드 타입과 같음, 각 매개변수(파라미터 변수-전달변수)
	 public int memberInsert(String memberId, String memberPwd, 
			 String memberName, String memberGender, String memberBirth, String memberAddr, 
			 String memberPhone, String memberEmail, String memberInHobby) {
		int value = 0;  // 메소드 지역변수 결과값을 담는다
		String sql = "";
		PreparedStatement pstmt = null; // 쿼리 구문클래스 선언
		
			try{
				
				sql = "insert into member(memberid,memberpwd,membername,"
						+"membergender,memberbirth,memberaddr,"
						+"memberphone,memberemail,memberhobby)values(?,?,?,?,?,?,?,?,?)";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, memberId);      // 문자형 메소드 사용
				pstmt.setString(2, memberPwd);	   // 숫자형은 setInt(번호,값);
				pstmt.setString(3, memberName);
				pstmt.setString(4, memberGender);
				pstmt.setString(5, memberBirth);
				pstmt.setString(6, memberAddr);
				pstmt.setString(7, memberPhone);
				pstmt.setString(8, memberEmail);
				pstmt.setString(9, memberInHobby);
				value = pstmt.executeUpdate();   // 구문객체 실행하면 성공시 1 실패시 0 리턴
	
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally{                // try를 했던 catch를 했던 꼭 실행해야하는 영역
				//객체 사라지게 하고
				//db연결 끊기
				try{
				pstmt.close();
				conn.close();
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		
		return value;
		
	}
	
	
	
	
	

}
