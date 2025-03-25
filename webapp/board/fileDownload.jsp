<%-- <%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@page import="magic.board.BoardBean"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
int bid = Integer.parseInt(request.getParameter("fileN"));
BoardDBBean db = BoardDBBean.getInstance();
BoardBean board = db.getFileName(bid);

String fileName="";
String realFileName="";

// 첨부파일 존재시
if(board != null) {
	fileName = board.getB_fname();
	realFileName = board.getB_rfname();
	
}
String  saveDirectory = application.getRealPath("/upload");
//넘버링 처리된 파일명
String path = saveDirectory + File.separator + fileName;

//다운로드 대상 파일
File file = new File(path);
long length = file.length();
realFileName = new String(realFileName.getBytes("ms949"),"8859_1");

// octet-stream : 기본 ContentType
response.setCharacterEncoding("application/octet-stream");
response.setContentLength((int)length);
//Content.Disposition : 브라우저에 실제 파일명 컨첸츠가 있다 알림
response.setHeader("Content-Disposition","attachment;filename="+realFileName);

//파일 다운로드에 임시저장공간 사용
BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
//기존 파일이 남아 있는 경우 초기화
out.clear();

//다운로드 준비
out=pageContext.pushBody();

// 다운로드로 파일 내보낼때 사용
BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());

int data;
// bis로 읽어서 bos에 쓰기
while((data=bis.read())!= -1) {
	bos.write(data);
}
bis.close();
bos.close();
%> --%>

<%-- <%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@page import="magic.board.BoardBean"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int bid = Integer.parseInt(request.getParameter("fileN"));
	BoardDBBean db = BoardDBBean.getInstance();
	BoardBean board = db.getFileName(bid);
	
	String fileName="";
	String realFileName="";
	
// 	첨부파일이 있으면
	if(board != null){
		fileName = board.getB_fname();
		realFileName = board.getB_rfname();
	}

// 	실제 업로드 되어 있는 경로
	String saveDirectory = application.getRealPath("/upload");
// 	File.separator : 디렉토리명과 파일명을 연결하는 구분자(운영체제마다 상이할수 있음)
// 	fileName : 넘버링 처리된 파일명
	String path = saveDirectory + File.separator + fileName;

// 	file : 다운로드 대상 파일
	File file=new File(path);
	long length = file.length();
// 	jsp 기본 한글 처리
	realFileName = new String(realFileName.getBytes("ms949"), "8859_1");

// 	response 객체에 필요한 내용들을 담아서 전송
// 	octet-stream : 기본 ContentType
	response.setCharacterEncoding("application/octet-stream");
	response.setContentLength((int)length);
// 	Content-Disposition : 브라우저에 실제파일명 컨텐츠가 있다고 알림
	response.setHeader("Content-Disposition", "attachment;filename="+realFileName);

// 	파일 다운로드할때 임시저장공간을 사용
	BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));

// 	기존 파일이 남아 있는 경우 초기화
	out.clear();
// 	다운로드 준비
	out=pageContext.pushBody();
// 	다운로드로 파일 내보낼때 사용
	BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());

	int data;
// 	bis 로 읽어서 bos 에 쓰기
	while((data=bis.read()) != -1){
		bos.write(data);
	}

	bis.close();
	bos.close();
%>
 --%>
 
 <%@page import="java.io.*" %>
<%@page import="java.net.URLEncoder" %>
<%@page import="magic.board.BoardBean" %>
<%@page import="magic.board.BoardDBBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// 요청된 파일 ID 가져오기
	int bid = Integer.parseInt(request.getParameter("fileN"));

	// DB에서 파일 정보 조회
	BoardDBBean db = BoardDBBean.getInstance();
	BoardBean board = db.getFileName(bid);

	String fileName = "";
	String realFileName = "";

	// 첨부파일이 존재하는 경우
	if (board != null) {
		fileName = board.getB_fname();
		realFileName = board.getB_rfname();
	}

	// 실제 파일 경로 설정
	String saveDirectory = application.getRealPath("/upload");
	String path = saveDirectory + File.separator + fileName;

	// 파일 객체 생성
	File file = new File(path);

	// 파일 존재 여부 확인
	if (!file.exists()) {
		out.println("<script>alert('파일이 존재하지 않습니다.'); history.back();</script>");
		return;
	}

	// 파일 크기
	long length = file.length();

	// 파일명 한글 처리
	realFileName = URLEncoder.encode(realFileName, "UTF-8").replaceAll("\\+", "%20");

	// HTTP 응답 헤더 설정
	response.reset();
	response.setContentType("application/octet-stream");
	response.setContentLength((int) length);
	response.setHeader("Content-Disposition", "attachment; filename=\"" + realFileName + "\"");
	response.setHeader("Content-Transfer-Encoding", "binary");

	// 파일 읽기 및 다운로드 처리
	try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
		 BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream())) {

		byte[] buffer = new byte[4096];
		int bytesRead;
		while ((bytesRead = bis.read(buffer)) != -1) {
			bos.write(buffer, 0, bytesRead);
		}
		bos.flush();
	} catch (IOException e) {
		e.printStackTrace();
		out.println("<script>alert('파일 다운로드 중 오류가 발생했습니다.'); history.back();</script>");
	}
%>
 











