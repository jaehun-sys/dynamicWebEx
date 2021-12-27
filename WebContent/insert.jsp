<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String str = request.getParameter("id");
String str2 = request.getParameter("password");
String file = request.getParameter("file");
String authorId = request.getParameter("authorId");

out.println("<span> id: " + str + "</span><br>");
out.println("<span> password: " + str2 + "</span><br>");
out.println("<span> file: " + file + "</span><br>");
out.println("<span> authorId: " + authorId + "</span><br>");
%>
</body>
</html>