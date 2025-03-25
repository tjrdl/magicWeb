<%@page import="com.jspsmart.upload.File"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	SmartUpload upload = new SmartUpload();
// 업로드할 파일이 있으면 비움
	upload.initialize(pageContext);
// 업로드 준비
	upload.upload();
// 업로드 파일 갯수
	int last = upload.getFiles().getCount();
	int cnt = 0;
	
// 업로드 파일 갯수 만큼 반복
	for(int i = 0; i<last; i++) {
		File file = upload.getFiles().getFile(i);
		
		if(!file.isMissing()) {
			file.saveAs("/upload/"+file.getFieldName());
			
			out.print("폼 태그 필드 이름 : "+file.getFieldName()+"<br>");
			out.print("파일 이름 : "+file.getFileName()+"<br>");
			out.print("파일 크기 : "+file.getSize()+"<br>");
			out.print("파일 확장자 : "+file.getFileExt()+"<br>");
			out.print("파일 경로 : "+file.getFilePathName()+"<br>");
			out.print("<br>=====================================<br>");
			cnt++;
		}
	}
out.print("파일"+cnt+"개를 업로드 했습니다.");
%>