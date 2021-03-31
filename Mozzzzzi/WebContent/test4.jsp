<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String uid = "scott"; String pass = "tiger";
	
	try{
		String sql = "select * from address1 where userName like '?'";

		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection(url, uid, pass);
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
	%>
	<table width="800" border="1">
	<tr><th>이름</th><th>아이디</th><th>전화번호</th><th>구분</th></tr>
<%while (rs.next()) {
out.println("<tr>");
out.println("<td>" + rs.getString("userName") + "</td>");
out.println("<td>" + rs.getFloat("userLat") + "</td>");
out.println("<td>" + rs.getFloat("userLng") + "</td>"); // getString 해도 됨
out.println("</tr>");
}//while의 끝
%>
</table>
<%} catch (Exception e) {
out.print("죄송합니다. 시스템상 문제가 생겼어요 <br>" + e.getMessage());
}
%>
