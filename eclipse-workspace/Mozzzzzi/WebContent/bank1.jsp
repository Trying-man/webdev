<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String uid = "scott"; String pass = "tiger";
	String sql = "select * from member";

	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection(url, uid, pass);
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
	%>
	<table width="800" border="1">
	<tr><th>�̸�</th><th>���̵�</th><th>��ȣ</th><th>�̸���</th><th>��ȭ��ȣ</th><th>����</th></tr>
<%while (rs.next()) {
out.println("<tr>");
out.println("<td>" + rs.getString("name") + "</td>");
out.println("<td>" + rs.getString("userid") + "</td>");
out.println("<td>" + rs.getString("pwd") + "</td>");
out.println("<td>" + rs.getString("email") + "</td>");
out.println("<td>" + rs.getString("phone") + "</td>");
out.println("<td>" + rs.getInt("admin") + "</td>"); // getString �ص� ��
out.println("</tr>");
}//while�� ��
%>
</table>
<%} catch (Exception e) {
out.print("�˼��մϴ�. �ý��ۻ� ������ ������ <br>" + e.getMessage());
}
%>
