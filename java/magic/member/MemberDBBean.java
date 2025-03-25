package magic.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDBBean {
	// jsp소스에서 MemberDBBean 객체 생성을 위한 참조 변수
	private static MemberDBBean instance = new MemberDBBean();

	// 전역 MemberDBBean 객체 레퍼런스를 리턴하는 메소드
	public static MemberDBBean getInstance() {
		return instance;
	}

	// 쿼리작업에 사용할 커넥션 객체를 리턴하는 메소드
	public Connection getConnection() throws Exception {
		return ((DataSource) (new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
//		Context ctx = new InitialContext();
//		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
//		Connection conn = ds.getConnection();
//		
//		return conn;
	}

	// 전달인자로 받은 member를 memberT 테이블에 삽입하는 메소드
	public int insertMember(MemberBean member) throws Exception {
		PreparedStatement pstmt = null;
		Connection conn = null;
		int re = -1;

		String sql = "insert into memberT values(?, ?, ?, ?, ?)";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, member.getMem_uid());
			pstmt.setString(2, member.getMem_pwd());
			pstmt.setString(3, member.getMem_name());
			pstmt.setString(4, member.getMem_email());
			pstmt.setString(5, member.getMem_addr());

			// 쿼리 정상 실행되면 1 저장
			re = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return re;
	}

	// 회원 가입시 아이디 중복 확인할 때 사용하는 메소드
	public int confirmID(String id) throws Exception {
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		int re = -1;
		
		String sql = "select mem_uid, mem_pwd, mem_name,mem_email, mem_address from memberT where mem_uid=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			
			// 중복되는 값이 있으면 rs존재
			if(rs.next()) {
				re = 1;
			} else { // 중복되는 값 없을 때
				re = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return re;
	}
	
	// 사용자 인증시 사용하는 메소드
	public int userCheck(String id, String pwd) throws Exception {
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		int re = -1;
		
		String db_mem_pwd;
		String sql = "select mem_pwd from memberT where mem_uid=?";
				
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);			

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				db_mem_pwd = rs.getString("mem_pwd");
				if(db_mem_pwd.equals(pwd)) {
					re = 1;
				} else {
					re = 0;
				}
			} else { // 중복되는 값 없을 때
				re = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return re;
	}
	
	//아이디가 일치하는 멤버의 정보를 얻어오는 메소드
	public MemberBean getMember(String id) throws Exception {
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		String sql = "select mem_uid, mem_pwd, mem_name,mem_email, mem_address from memberT where mem_uid=?";
		
		MemberBean member=null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberBean();
				member.setMem_uid(id);
				member.setMem_pwd(rs.getString("mem_pwd"));
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_email(rs.getString("mem_email"));
				member.setMem_addr(rs.getString("mem_address"));
			} else {
				System.out.println("값없엉");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return member;
	}
	
	// 사용자 정보수정
	public int updateMember(MemberBean member) throws Exception {
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		int re = -1;
		
		String sql = "update memberT set mem_pwd=?, mem_email=?, mem_address=? where mem_uid=?";
				
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMem_pwd());
			pstmt.setString(2, member.getMem_email());
			pstmt.setString(3, member.getMem_addr());
			pstmt.setString(4, member.getMem_uid());

			rs = pstmt.executeQuery();
			if(rs.next()) {
				re = 1;
			} else { // 중복되는 값 없을 때
				re = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return re;
	}
	
}
