package magic.board;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import magic.member.MemberBean;

public class BoardDBBean {
	private static BoardDBBean instance = new BoardDBBean();

	public static BoardDBBean getInstance() {
		return instance;
	}

	public Connection getConnection() throws Exception {
		return ((DataSource) (new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();

	}

	public int getId() throws Exception {
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		int number_id = 0;
		String sql = "SELECT MAX(b_id) FROM boardt";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) { // rs에서 데이터를 가져오기 전에 next() 호출
				number_id = rs.getInt(1); // "max(b_id)" 또는 컬럼 인덱스로 가져오기
			}

			number_id = number_id + 1;
			System.out.println("=====getIdBoard======");
			System.out.println(number_id);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return number_id; // 새로운 ID 값 반환
	}

	public int insertBoard(BoardBean board) throws Exception {
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		int re = -1;
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());

		// 게시판 답글 관련
		int id = board.getB_id();
		int ref = board.getB_ref();
		int step = board.getB_step();
		int level = board.getB_level();
		System.out.println("@# id=>" + id);
		String sql2 = "";

		String sql = "insert into boardT values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		int num1 = getId();
		System.out.println("=====insertBoard======");
		System.out.println(num1);
		try {
			conn = getConnection();

//			1..글번호를 가지고 오는 경우(답변)
//			2..글번호를 가지고 오지 않는 경우(신규글)
			if (id != 0) {
//				sql2 = "update boardt set b_step=b_step+1 where b_ref =? and b_step > ?";
				sql2 = "update boardt set b_step=b_step+1 where b_ref=? and b_step > ?";

				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, step);
				pstmt.executeUpdate();

				step = step + 1;
				level = level + 1;
			} else {
				ref = getId();
				step = 0;
				level = 0;
			}

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, board.getB_name());
			pstmt.setString(2, board.getB_email());
			pstmt.setString(3, board.getB_title());
			pstmt.setString(4, board.getB_content());
			pstmt.setInt(5, num1);
			pstmt.setTimestamp(6, timestamp);
			pstmt.setInt(7, 0);
			pstmt.setString(8, board.getB_pwd());
			pstmt.setString(9, board.getB_ip());
			pstmt.setInt(10, ref);
			pstmt.setInt(11, step);
			pstmt.setInt(12, level);
			pstmt.setString(13, board.getB_fname());
			pstmt.setInt(14, board.getB_fsize());
			pstmt.setString(15, board.getB_rfname());
//				pstmt.setString(5, board.getB_id());
			System.out.println("추가 성공");
			// 쿼리 정상 실행되면 1 저장
			re = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("추가 실패");
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

////	public ArrayList<BoardBean> listBoard() throws Exception {
//		public ArrayList<BoardBean> listBoard(String pageNumber) throws Exception {
//		ArrayList<BoardBean> boardList = new ArrayList<>();
//		PreparedStatement pstmt = null;
//		Statement stmt = null;
//		Connection conn = null;
//		ResultSet rs = null;
//		ResultSet pageSet = null;
//
//		int dbCount = 0;
//		int absolutePage = 1;
//		int re = -1;
//
////		String sql = "select b_id, b_title, b_name,b_email,b_content,b_date, b_hit, b_pwd,b_ip from boardT ORDER BY b_id asc";
//		String sql = "select b_id, b_title, b_name, b_email, b_content, b_date, b_hit, b_pwd, b_ip, b_ref, b_step, b_level from boardT ORDER BY b_ref desc, b_step asc";
//		String sql2 = "select count(b_id) from boardt";
//		System.out.println("=====listBoard======");
//		try {
//			conn = getConnection();
//			pstmt = conn.prepareStatement(sql);
//			// type_scroll_sensitive=>scroll도 가능하면서 변경 사항도 적용됨
//			// concur_updatable => 커서의 위치에서 정보 업데이트 가능
//			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//			pageSet = stmt.executeQuery(sql2);
//			
//			if(pageSet.next()) {
//				dbCount = pageSet.getInt(1);
//				pageSet.close();
//			}
//			// BoardBean.pageSize : 10
//			if(dbCount % BoardBean.pageSize == 0) {
//				BoardBean.pageCount = dbCount / BoardBean.pageSize;
//				//dbCount : 80 => 8page
//			} else {
//				// dbCount:84 => 9 page
//				BoardBean.pageCount = dbCount / BoardBean.pageSize + 1;
//			}
//			if(pageNumber != null) {
//				BoardBean.pageNum = Integer.parseInt(pageNumber);
//				absolutePage = (BoardBean.pageNum -1)*BoardBean.pageSize + 1;
//			}
//			rs = pstmt.executeQuery();
//			
//			if(rs.next()) {
//				rs.absolute(absolutePage);
//				int count = 0;
//				while (count<BoardBean.pageSize) {
//					BoardBean board = new BoardBean();
//					
//					board.setB_id(rs.getInt("b_id"));
//					board.setB_title(rs.getString("b_title"));
//					board.setB_name(rs.getString("b_name"));
//					board.setB_email(rs.getString(4));
//					board.setB_content(rs.getString(5));
//					board.setB_date(rs.getTimestamp("b_date"));
//					board.setB_hit(rs.getInt("b_hit"));
//					board.setB_pwd(rs.getString("b_pwd"));
//					board.setB_ip(rs.getString("b_ip"));
//					board.setB_ref(rs.getInt("b_ref"));
//					board.setB_step(rs.getInt("b_step"));
//					board.setB_level(rs.getInt("b_level"));
//					
//					boardList.add(board);
//					
//					if(rs.isLast()) {
//						break;
//					}
//					else {
//						rs.next();
//					}
//					
//					count++;
//				}
//			}
//
//
//			System.out.println("조회 성공");
//			// 쿼리 정상 실행되면 1 저장
//			re = pstmt.executeUpdate();
//		} catch (Exception e) {
//			e.printStackTrace();
//			System.out.println("조회 실패");
//		} finally {
//			try {
//				if (pstmt != null)
//					pstmt.close();
//				if (conn != null)
//					conn.close();
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//		return boardList;
//	}
//
	public BoardBean getBoard(String id) throws Exception {
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		int num = Integer.parseInt(id);
		BoardBean board = null;

		String sql = "select b_id, b_title, b_name,b_email,b_content,b_date,b_hit,b_pwd,b_ip, b_ref, b_step, b_level, b_fname, b_fsize, b_rfname from boardT where b_id= ?";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				board = new BoardBean();
				board.setB_id(rs.getInt(1));
				board.setB_title(rs.getString(2));
				board.setB_name(rs.getString(3));
				board.setB_email(rs.getString(4));
				board.setB_content(rs.getString(5));
				board.setB_date(rs.getTimestamp(6));
				board.setB_hit(rs.getInt(7));
				board.setB_pwd(rs.getString(8));
				board.setB_ip(rs.getString(9));
				board.setB_ref(rs.getInt(10));
				board.setB_step(rs.getInt(11));
				board.setB_level(rs.getInt(12));
				board.setB_fname(rs.getString(13));
				board.setB_fsize(rs.getInt(14));
				board.setB_rfname(rs.getString(15));
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
		return board;
	}
	public ArrayList<BoardBean> listBoard(String pageNumber) throws Exception {
	    ArrayList<BoardBean> boardList = new ArrayList<>();
	    Statement stmt = null;
	    Connection conn = null;
	    ResultSet rs = null;
	    ResultSet pageSet = null;

	    int dbCount = 0;
	    int absolutePage = 1;

	    String sql = "SELECT b_id, b_title, b_name, b_email, b_content, b_date, b_hit, b_pwd, b_ip, b_ref, b_step, b_level, b_fname, b_fsize, b_rfname FROM boardT ORDER BY b_ref DESC, b_step ASC";
	    String sql2 = "SELECT COUNT(b_id) FROM boardT";

	    System.out.println("=====listBoard======");

	    try {
	        conn = getConnection();

	        // ✅ `Statement`를 TYPE_SCROLL_SENSITIVE로 생성
	        stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
	        pageSet = stmt.executeQuery(sql2);
	        
	        if (pageSet.next()) {
	            dbCount = pageSet.getInt(1);
	            pageSet.close();
	        }

	        // ✅ 페이지 계산 로직
	        if (dbCount % BoardBean.pageSize == 0) {
	            BoardBean.pageCount = dbCount / BoardBean.pageSize;
	        } else {
	            BoardBean.pageCount = dbCount / BoardBean.pageSize + 1;
	        }

	        if (pageNumber != null) {
	            BoardBean.pageNum = Integer.parseInt(pageNumber);
	            absolutePage = (BoardBean.pageNum - 1) * BoardBean.pageSize + 1;
	        }

	        // ✅ stmt를 사용하여 `ResultSet` 가져오기
	        rs = stmt.executeQuery(sql);

	        if (rs.next()) {
	            rs.absolute(absolutePage);  // ✅ 이제 문제없이 사용 가능!

	            int count = 0;
	            while (count < BoardBean.pageSize) {
	                BoardBean board = new BoardBean();

	                board.setB_id(rs.getInt("b_id"));
	                board.setB_title(rs.getString("b_title"));
	                board.setB_name(rs.getString("b_name"));
	                board.setB_email(rs.getString("b_email"));
	                board.setB_content(rs.getString("b_content"));
	                board.setB_date(rs.getTimestamp("b_date"));
	                board.setB_hit(rs.getInt("b_hit"));
	                board.setB_pwd(rs.getString("b_pwd"));
	                board.setB_ip(rs.getString("b_ip"));
	                board.setB_ref(rs.getInt("b_ref"));
	                board.setB_step(rs.getInt("b_step"));
	                board.setB_level(rs.getInt("b_level"));
	                board.setB_fname(rs.getString("b_fname"));
	                board.setB_fsize(rs.getInt("b_fsize"));
	                board.setB_rfname(rs.getString("b_rfname"));

	                boardList.add(board);

	                if (rs.isLast()) {
	                    break;
	                } else {
	                    rs.next();
	                }

	                count++;
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

	public int updateCount(String id) throws Exception {
		PreparedStatement pstmt = null;
		Connection conn = null;
		int re = -1;

		int num = Integer.parseInt(id);
		String sql = "update boardt set B_HIT = B_HIT + 1 where b_id= ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
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

	public int deleteBoard(int id, String pw) {
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		String pwd = "";
		int re = -1;

		String sql = "select b_pwd from boardt where b_id = ?";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				// 쿼리 결과에서 b_pwd 컬럼 데이터
				pwd = rs.getString(1);
				if (pwd.equals(pw)) {
					// 비밀번호 일치시 삭제 쿼리 실행
					sql = "delete from boardt where b_id = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, id);
					re = pstmt.executeUpdate();
				} else {
					re = 0;
				}
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

	public int editBoard(BoardBean board, int id) throws Exception {
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		int re = -1;
		String b_pwd = "";
		String sql = "select b_pwd from boardt where b_id = ?";
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				b_pwd = rs.getString(1);
				if (b_pwd.equals(board.getB_pwd())) {
					sql = "update boardt set B_NAME=?, B_EMAIL=?, B_TITLE=?, B_CONTENT=?, B_DATE=? where b_id= ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, board.getB_name());
					pstmt.setString(2, board.getB_email());
					pstmt.setString(3, board.getB_title());
					pstmt.setString(4, board.getB_content());
					pstmt.setTimestamp(5, timestamp);
					pstmt.setInt(6, id);
					re = pstmt.executeUpdate();
					System.out.println("===== update =====");
					System.out.println("업데이트 성공");
				} else {
					re = 0;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
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
	
	public BoardBean getFileName(int bid) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql = "select b_fname, b_rfname from boardt where b_id=?";
		BoardBean board=null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bid);
			rs = pstmt.executeQuery();
			
//			첨부파일이 있으면
			if (rs.next()) {
				board = new BoardBean();
				
				board.setB_fname(rs.getString(1));
				board.setB_rfname(rs.getString(2));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return board;
	}
}
