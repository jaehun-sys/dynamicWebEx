<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
    
<%!	//변수 선언
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String user = "webdb";
	String pass = "webdb12";
	
	StringBuilder sql = new StringBuilder();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="./css/table.css">
</head>
<body>
	<table width="800" class="tbl-ex">
		<tr>
			<th>저자번</th>
			<th>저자</th>
			<th>설명</th>
		</tr>
		<%
		try {
		// 1. JDBC 드라이버 (Oracle) 로딩 
			Class.forName("oracle.jdbc.driver.OracleDriver");
			sql.append("SELECT A.AUTHOR_ID	 		 AS author_id     , ");
			sql.append("	   A.AUTHOR_NAME		 AS author_name   , ");
			sql.append("	   A.AUTHOR_DESC		 AS author_desc     ");
			sql.append("FROM AUTHOR   A ");
			sql.append("ORDER BY author_id ");
			
		// 2. Connection 얻어오기
			conn = DriverManager.getConnection(url, user, pass);
			
		// 3. SQL문 준비 / 바인딩 / 실행 
			pstmt = conn.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
		// 4.결과처리
			int selectCnt = 0;
			while(rs.next()) {
				selectCnt++;
				out.print("<tr>");
				out.print("<td>"+rs.getInt("author_id")+"</td>");
				out.print("<td>"+rs.getString("author_name")+"</td>");
				out.print("<td>"+rs.getString("author_desc")+"</td>");
				out.print("</tr>");
//				System.out.println(authorId + "\t" + authorName + "\t" + authorDesc + "\t");
			}
			System.out.println(selectCnt + "건 조회 완료");
		} catch (ClassNotFoundException e) { 
			System.out.println("error: 드라이버 로딩 실패 - " + e);
		} catch (SQLException e) { 
			System.out.println("error:" + e);
		} finally {
		// 5. 자원정리
			try {
			if (rs != null) {
				rs.close(); 
			}
			if (pstmt != null) { 
				pstmt.close();
			} 
			if (conn != null) {
				conn.close(); 
			}
			} catch (SQLException e) {
				e.printStackTrace();
				System.err.println("error:" + e); 
			}
		}
		%>
	</table>
	
	<br><a href="./home.html">돌아가기</a>
</body>
</html>