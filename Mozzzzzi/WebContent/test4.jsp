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
	<tr><th>�̸�</th><th>���̵�</th><th>��ȭ��ȣ</th><th>����</th></tr>
<%while (rs.next()) {
out.println("<tr>");
out.println("<td>" + rs.getString("userName") + "</td>");
out.println("<td>" + rs.getFloat("userLat") + "</td>");
out.println("<td>" + rs.getFloat("userLng") + "</td>"); // getString �ص� ��
out.println("</tr>");
}//while�� ��
%>
</table>
<%} catch (Exception e) {
out.print("�˼��մϴ�. �ý��ۻ� ������ ������ <br>" + e.getMessage());
}
%>
