<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
    
<%	//변수 선언
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
			<th>사번</th>
			<th>이름</th>
			<th>입사일</th>
			<th>근무부서</th>
			<th>매니저</th>
			<th>급여</th>
		</tr>
		<%
		try {
		// 1. JDBC 드라이버 (Oracle) 로딩 
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
		// 2. Connection 얻어오기
			conn = DriverManager.getConnection(url, user, pass);
			
		// 3. SQL문 준비 / 바인딩 / 실행 
			sql.append("SELECT E.EMPLOYEE_ID	 						  AS employee_id     , ");
			sql.append("	   E.FIRST_NAME		 						  AS employee_name   , ");
			sql.append("	   TO_CHAR(E.HIRE_DATE, 'YYYY\".\"MM\".\"DD') AS hire_date       , ");
			sql.append("	   D.DEPARTMENT_NAME 						  AS department_name , ");
			sql.append("	   M.FIRST_NAME		 						  AS manager_name    , ");
			sql.append("	   E.SALARY			 						  AS salary            ");
			sql.append("FROM HR.EMPLOYEES   E, ");
			sql.append("	 HR.EMPLOYEES   M, ");
			sql.append(" 	 HR.DEPARTMENTS D  ");
			sql.append("WHERE M.EMPLOYEE_ID = E.MANAGER_ID ");
			sql.append("AND   E.DEPARTMENT_ID = D.DEPARTMENT_ID ");
			sql.append("ORDER BY E.EMPLOYEE_ID ");
			pstmt = conn.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
		// 4.결과처리
			int selectCnt = 0;
			while(rs.next()) {
				selectCnt++;
				out.print("<tr>");
				out.print("<td>"+rs.getInt("employee_id")+"</td>");
				out.print("<td>"+rs.getString("employee_name")+"</td>");
				out.print("<td>"+rs.getString("hire_date")+"</td>");
				out.print("<td>"+rs.getString("department_name")+"</td>");
				out.print("<td>"+rs.getString("manager_name")+"</td>");
				out.print("<td>"+rs.getInt("salary")+"</td>");
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
</body>
</html>