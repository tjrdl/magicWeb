package magic.board;

import java.sql.Timestamp;

public class BoardBean {
	private String B_name;
	private String B_email;
	private String B_title;
	private String B_content;
	private int B_id;
	private Timestamp B_date;
	private int B_hit;
	private String B_pwd;
	private String B_ip;
	private int B_ref;
	private int B_step;
	private int B_level;
	
	private String B_fname;
	private int B_fsize;
	private String B_rfname;
	
	public String getB_rfname() {
		return B_rfname;
	}
	public void setB_rfname(String b_rfname) {
		B_rfname = b_rfname;
	}
	public String getB_fname() {
		return B_fname;
	}

	public void setB_fname(String b_fname) {
		B_fname = b_fname;
	}

	public int getB_fsize() {
		return B_fsize;
	}

	public void setB_fsize(int b_fsize) {
		B_fsize = b_fsize;
	}

	public static int pageSize = 10; // 한 페이지당 10개 출력물
	public static int pageCount = 1; // 페이지 개수 지정 변수
	public static int pageNum = 1; // 페이지 번호

	// limit: 화면에 표시되는 페이지 최대갯수
	   public static String pageNumber(int limit) {
		      String str = "";
		      int temp = (pageNum - 1) % limit;
		      int startPage = pageNum - temp;

		      // [이전] 출력
		      if ((startPage - limit) > 0) {
		         str = "<a href='list.jsp?pageNum=" + (startPage - 1) + "'>[이전]</a>&nbsp;&nbsp;";
		      }

		      // 페이지 번호 나열하기
		      for (int i = startPage; i < (startPage + limit); i++) {
		         if (i == pageNum) {
		            str += "[" + i + "]&nbsp;&nbsp";
		         } else {
		            str += "<a href='list.jsp?pageNum=" + i + "'>" + "[" + i + "]</a>&nbsp;&nbsp;";
		         }
		         if (i >= pageCount)
		            break;
		      }

		      // [다음] 출력
		      if ((startPage + limit) <= pageCount) {
		         str += "<a href='list.jsp?pageNum=" + (startPage + limit) + "'>[다음]</a>";
		      }
		      return str;
		   }

	public int getB_ref() {
		return B_ref;
	}

	public void setB_ref(int b_ref) {
		B_ref = b_ref;
	}

	public int getB_step() {
		return B_step;
	}

	public void setB_step(int b_step) {
		B_step = b_step;
	}

	public int getB_level() {
		return B_level;
	}

	public void setB_level(int b_level) {
		B_level = b_level;
	}

	public String getB_ip() {
		return B_ip;
	}

	public void setB_ip(String b_ip) {
		B_ip = b_ip;
	}

	public String getB_pwd() {
		return B_pwd;
	}

	public void setB_pwd(String b_pwd) {
		B_pwd = b_pwd;
	}

	public int getB_hit() {
		return B_hit;
	}

	public void setB_hit(int b_hit) {
		B_hit = b_hit;
	}

	public Timestamp getB_date() {
		return B_date;
	}

	public void setB_date(Timestamp b_date) {
		B_date = b_date;
	}

	public int getB_id() {
		return B_id;
	}

	public void setB_id(int b_id) {
		B_id = b_id;
	}

	public String getB_name() {
		return B_name;
	}

	public void setB_name(String b_name) {
		B_name = b_name;
	}

	public String getB_email() {
		return B_email;
	}

	public void setB_email(String b_email) {
		B_email = b_email;
	}

	public String getB_title() {
		return B_title;
	}

	public void setB_title(String b_title) {
		B_title = b_title;
	}

	public String getB_content() {
		return B_content;
	}

	public void setB_content(String b_content) {
		B_content = b_content;
	}

}
