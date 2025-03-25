package test.emp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import magic.board.BoardBean;


public class empdb {
	private static empdb instance = new empdb();

	public static empdb getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		return ((DataSource) (new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
	}
	
	public emp getBoard() throws Exception {
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		emp emp1 = null;

		String sql = "select * from emp";

		try {
			conn = getConnection();

			rs = pstmt.executeQuery();
			while (rs.next()) {
				emp1 = new emp();
				
				emp1.setEmpno(rs.getInt(1));
				emp1.setEname(rs.getString(2));
				emp1.setJob(rs.getString(3));
				emp1.setMgr(rs.getInt(4));
				emp1.setHiredate(rs.getTimestamp(5));
				emp1.setSal(rs.getInt(6));
				emp1.setComm(rs.getInt(7));
				emp1.setDeptno(rs.getInt(8));
			
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
		return emp1;
	}
	
	public ArrayList<emp> listBoard() throws Exception {
	    ArrayList<emp> boardList = new ArrayList<>();
	    Statement stmt = null;
	    Connection conn = null;
	    ResultSet rs = null;
	    ResultSet pageSet = null;

	    String sql = "SELECT * FROM emp";

	    System.out.println("=====listBoard======");

	    try {
	        conn = getConnection();
			emp emp1 = null;


	        // ✅ `Statement`를 TYPE_SCROLL_SENSITIVE로 생성
	        stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);

	        // ✅ stmt를 사용하여 `ResultSet` 가져오기
	        rs = stmt.executeQuery(sql);


	            while (rs.next()) {
	            	emp1 = new emp();
					
					emp1.setEmpno(rs.getInt(1));
					emp1.setEname(rs.getString(2));
					emp1.setJob(rs.getString(3));
					emp1.setMgr(rs.getInt(4));
					emp1.setHiredate(rs.getTimestamp(5));
					emp1.setSal(rs.getInt(6));
					emp1.setComm(rs.getInt(7));
					emp1.setDeptno(rs.getInt(8));

	                boardList.add(emp1);

	                if (rs.isLast()) {
	                    break;
	                } else {
	                    rs.next();
	                }
	        }

	        System.out.println("조회 성공");

	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("조회 실패");
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (stmt != null) stmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    return boardList;
	}
}
