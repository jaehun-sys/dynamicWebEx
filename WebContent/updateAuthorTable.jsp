<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="./css/table.css">
</head>
<body>

		<%		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "webdb";
		String pass = "webdb12";
		
		request.setCharacterEncoding("utf-8");
		String author_name = request.getParameter("author_name");
		String author_desc = request.getParameter("author_desc");
		int author_id = Integer.parseInt(request.getParameter("author_id"));
		
		System.out.println("author_id = " + author_id);
		System.out.println("author_name = " + author_name);
		System.out.println("author_desc = " + author_desc);
		
		Connection conn = null;
		PreparedStatement pstmt = null;

		StringBuilder sql = new StringBuilder();
		
		try {
			// 1. JDBC 드라이버 (Oracle) 로딩 
			Class.forName("oracle.jdbc.driver.OracleDriver");
			sql.append("UPDATE 	AUTHOR ");
			sql.append("SET		AUTHOR_NAME = ?, ");
			sql.append("		AUTHOR_DESC = ?	 ");
			sql.append("WHERE	AUTHOR_ID = ? ");
			
		// 2. Connection 얻어오기
			conn = DriverManager.getConnection(url, user, pass);
			
		// 3. SQL문 준비 / 바인딩 / 실행 
			pstmt = conn.prepareStatement(sql.toString());
			
		// 4.결과처리
			int index = 1;
			pstmt.setString(index++, author_name);
			pstmt.setString(index++, author_desc);
			pstmt.setInt(index++, author_id);
			
			//실행 결과 리턴. sql 문장 실행 후, 변경된 row 수 int 타입으로 리턴
			int r = pstmt.executeUpdate();
			//pstmt.executeQuery() : select
			//pstmt.executeUpdate() : insert, update, delete
			System.out.println(r + "건 처리");
		} catch (ClassNotFoundException e) { 
			System.out.println("error: 드라이버 로딩 실패 - " + e);
		} catch (SQLException e) { 
			System.out.println("error:" + e);
		} finally {
		// 5. 자원정리
			try {
				out.println("<span>수정되었습니다!</span>");
				
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
		<br><a href="./home.html">돌아가기</a>
	<!-- 
	</table>
	 -->
</body>
</html>