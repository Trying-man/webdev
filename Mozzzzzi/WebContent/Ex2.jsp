<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>

<%

	String name="블루25";
	ResultSet rs = null;
	try {
		// 1. JDBC 라이브러리 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		// 2. DB 서버 연결
		String conUrl = "jdbc:oracle:thin:@localhost:1521:xe";
		Connection con = DriverManager.getConnection(conUrl, "scott", "tiger");
		
		// 3. SQL 문장
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
    <title>여러개 마커 표시하기</title>
    
</head>
<body>
<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=838338d237cae9646ef84df5b932af7a&libraries=clusterer"></script>
<script>

var object = '<%=name%>';
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
 
// 마커를 표시할 위치와 title 객체 배열입니다 

var positions = [
    
    {
        title: '<%=request.getParameter("username")%>', 
        latlng: new kakao.maps.LatLng(<%=request.getParameter("userLng")%>, <%=request.getParameter("userLat")%>)
    },
    {
        title: '텃밭', 
        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
    },
    {
        title: '근린공원',
        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
    }
    
];


// 마커 이미지의 이미지 주소입니다
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
    
for (var i = 0; i < positions.length; i ++) {
    
    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new kakao.maps.Size(24, 35); 
    
    // 마커 이미지를 생성합니다    
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng, // 마커를 표시할 위치
        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage // 마커 이미지 
    });
}
</script>
</body>
</html>
		
	