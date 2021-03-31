<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%request.setCharacterEncoding("UTF-8"); String id = request.getParameter("id");
String url = "jdbc:oracle:thin:@localhost:1521:XE";
String uid = "scott"; String pass = "tiger";
String sql = "select * from bankmember where id = ?"; // 변수 자리에 물음표
try{
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection conn = DriverManager.getConnection(url, uid, pass);
PreparedStatement pre = conn.prepareStatement(sql); // 클래스명, 메소드명, 괄호안
pre.setString(1,id); // 물음표 하나니까
ResultSet rs = pre.executeQuery(); // 괄호안
if(rs.next()) {
session.setAttribute("id", id);
session.setMaxInactiveInterval(60*60);
response.sendRedirect("menu.jsp");
}
%>
<script>
alert("미등록 아이디입니다~ 문의전화: 051)200-1035");
location.href="login.jsp";
</script>
<%} catch (Exception e) {
out.print("아이디 체크 문제.. 고객 센터로 연락주세요~ <p>" + e.getMessage());
}
%>