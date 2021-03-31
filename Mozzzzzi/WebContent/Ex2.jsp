<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>

<%

	String name="���25";
	ResultSet rs = null;
	try {
		// 1. JDBC ���̺귯�� �ε�
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		// 2. DB ���� ����
		String conUrl = "jdbc:oracle:thin:@localhost:1521:xe";
		Connection con = DriverManager.getConnection(conUrl, "scott", "tiger");
		
		// 3. SQL ����
		String sql = "select * from address1";
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		//int result = pstmt.executeUpdate(); -> insert, update, delete
		
		rs = pstmt.executeQuery(); // -> select
		
		 while(rs.next()) {
			out.print(rs.getString("userName"));
			out.print(rs.getFloat("userLat"));
			out.print(rs.getFloat("userLng"));
		 }
		
		
		} catch(ClassNotFoundException e) {
			out.print("ClassNotFound!");
		} catch(SQLException e) {
			out.print("SQLException!");
		}
%>
		
		<%
		String strJson="";
		strJson="{\"customers\": [";
	
			while(rs.next()) {
		
				
				strJson+="{\"name\":\""+rs.getString("userName")+"\", \"address\":\""+rs.getFloat("userN")+"\"},";
								
				
		
		}
		strJson=strJson.substring(0,strJson.length()-1);
		strJson+="]}";	
		out.println(strJson);
		%>
		
		
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>������ ��Ŀ ǥ���ϱ�</title>
    
</head>
<body>
<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=838338d237cae9646ef84df5b932af7a&libraries=clusterer"></script>
<script>

var object = '<%=name%>';
var mapContainer = document.getElementById('map'), // ������ ǥ���� div  
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // ������ �߽���ǥ
        level: 3 // ������ Ȯ�� ����
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // ������ �����մϴ�
 
// ��Ŀ�� ǥ���� ��ġ�� title ��ü �迭�Դϴ� 

var positions = [
    
    {
        title: '<%=request.getParameter("username")%>', 
        latlng: new kakao.maps.LatLng(<%=request.getParameter("userLng")%>, <%=request.getParameter("userLat")%>)
    },
    {
        title: '�Թ�', 
        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
    },
    {
        title: '�ٸ�����',
        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
    }
    
];


// ��Ŀ �̹����� �̹��� �ּ��Դϴ�
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
    
for (var i = 0; i < positions.length; i ++) {
    
    // ��Ŀ �̹����� �̹��� ũ�� �Դϴ�
    var imageSize = new kakao.maps.Size(24, 35); 
    
    // ��Ŀ �̹����� �����մϴ�    
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    
    // ��Ŀ�� �����մϴ�
    var marker = new kakao.maps.Marker({
        map: map, // ��Ŀ�� ǥ���� ����
        position: positions[i].latlng, // ��Ŀ�� ǥ���� ��ġ
        title : positions[i].title, // ��Ŀ�� Ÿ��Ʋ, ��Ŀ�� ���콺�� �ø��� Ÿ��Ʋ�� ǥ�õ˴ϴ�
        image : markerImage // ��Ŀ �̹��� 
    });
}
</script>
</body>
</html>
		
	