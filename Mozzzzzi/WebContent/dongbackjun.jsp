<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("id");
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String uid = "scott";
	String pass = "tiger";
	//String sql = "select * from bankmember order by id";
	String sql = "select * from dbusan order by name";

	//String sql2 = "select * from banktrade where id = ? order by tradedate desc";
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection(url, uid, pass);
		Statement cre = conn.createStatement();
		ResultSet rs = cre.executeQuery(sql);
		
%>

<!DOCTYPE html>
<html lang="ko">
<head >


<meta charset ="EUC-KR"> 
<title>Insert title here </title> 
</head> 
<body style	="background-color: #E0F8E0 "> 

<div align ="center"> 
<table width="500" boder ="1"> 




<ul> <li>가맹점명 </li> <li>주소 </li> <li>승인유무 </li> </ul> 

</style>
</table>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
</div>
</body>

<%
	} catch (Exception e) {
		out.print("오류 발생했습니다. 고객센터로 연락바랍니다. <p>" + e.getMessage());
	}
%>





<body>
<head>
<meta charset="UTF-8">
	<div align="center">
	<h1>동백전 가맹점 위치 찾기</h1>
	
	검색 : <input type="text" name="id" />
	<p>
	<div class="mapWrap">
		<div id="map" style="width: 100%; height: 400px;"></div>
	</div>
	<div id="coordXY"></div>
	</div>
	
	
	<!-- ★ 키입력 뒷편 &libraries=services 필수입력 -->
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=838338d237cae9646ef84df5b932af7a&libraries=services"></script>
	<script>
	
	
	
		//////////////////// 
		// 카카오 지도 API S 
		/////////////////// 

		var listData =[

			"부산 연제구  월드컵대로73번길 84, 1층 (연산동)",
			"부산 금정구  중앙대로 1617-12, 상가 101동 105호 (부곡동,부곡동푸르지오)",
			"부산 남구  진남로 11, 2층 (대연동)",
			"부산 해운대구  삼어로133번길 34-19, 1층 (반여동)",
			"부산 북구  화명신도시로 156, 103동 102호 (화명동,화명동롯데아파트낙천대)",
			"부산 부산진구  범양로 121-1, 1층 (양정동)",
			"부산 사상구  새벽로 169 (감전동)",
			"부산 수영구  연수로249번길 10 (망미동)",
			"확인불가",
			"부산 남구  용호로216번가길 10, 상가동 108호 (용호동,용호예가)",
			"부산 부산진구  중앙대로775번길 23, 5,6호 (부전동)",
			"부산 금정구  구서중앙로15번길 20, 1동 201호 (구서동,승산스포렉스)",
			"부산 서구  충무대로276번길 5 (충무동1가)",
			"부산 연제구  안연로 33, 상가 A동 106호 (연산동,더샵파크시티)",
			"부산 사상구  사상로148번길 26, 1층 (감전동)",
			"부산 사하구  다송로 42 (다대동)",
			"부산 해운대구  양운로42번길 12, 7층 703호 (좌동,가람프라자)",
			"부산 사상구  백양대로494번길 10, 101동 302호 (주례동,주례1차동일아파트)",
			"부산 금정구  중앙대로1841번길 77 (구서동)",
			"부산 사상구  광장로37번길 63, 1층 (괘법동,섹시노래방)",
			"부산 남구  못골로12번길 53 (대연동)",
			"확인불가",
			"부산 동래구  연안로51번길 77, 1층 일부 (안락동)",
			"부산 사하구  낙동남로1390번길 5, 2층 206호 (하단동,나산리버빌)",
			"부산 연제구  월드컵대로 325, 상가 203,204 (거제동,삼정그린코아아파트)",
			"부산 해운대구 재송동 1210벽산E-클래스원106호, 206호",
			"부산 남구  못골로41번길 12 (대연동)",
			"부산 동구  중앙대로274번길 4, 1층 (초량동,동아빌딩)",
			"부산 부산진구  중앙대로 979, 1층 (양정동,동성빌딩)",
			"부산 남구  수영로 345, 115동 102호 (대연동,대연힐스테이트푸르지오)",
			"부산 사하구  승학로2번길 40 (당리동)",
			"부산 수영구  구락로10번길 21 (수영동)",
			"부산 강서구  유통단지1로 41, 125동 108호 (대저2동,부산티플렉스)",
			"부산 동래구  충렬대로181번길 43-1 (명륜동)",
			"부산 남구  못골로 51, 1층 (대연동,대연꽃n수족관)"
			
		]
		
		
		var coordXY = document.getElementById("coordXY");

		//검색 지도 경도위도 알아내기 
		var container = document.getElementById('map');

		//지도를 담을 영역의 DOM 레퍼런스 
		var options = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 위도경도 
			level : 3
		//지도의 레벨(확대, 축소 정도) 
		};
		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴 

		// 지도타입 컨트롤, 줌 컨트롤 생성 
		var mapTypeControl = new kakao.maps.MapTypeControl();
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

		// ★ 주소-좌표 변환 객체를 생성 
		var geocoder = new kakao.maps.services.Geocoder();

		
		
		
		
		
		
				
		listData.forEach(function(addr, index) {
					// ★ 주소로 좌표를 검색 
					geocoder.addressSearch(addr,function(result, status) {

										// 정상적으로 검색이 완료됐으면 
										if (status === kakao.maps.services.Status.OK) {

											var coords = new kakao.maps.LatLng(result[0].y, result[0].x); 
											
											
											
											var xx= result[0].x;
											<%String x2=request.getParameter("xx");%>
											var yy= result[0].y;
											
											<%String x3=request.getParameter("result[0].y");%>
											
											document.getElementById("1").innerHTML ="lat : "+ xx+ " lng : "+yy;
											

											/// 결과값으로 받은 위치를 마커로 표시 
											var marker = new kakao.maps.Marker(
													{
														
														map : map,
														position : coords
													});
											
											
											
											<%--$.get(xx,yy,function(data){
												var markers = $ (data.positions).map(function(i,position)){
													return new kakao.Marker({
														position : new kakao.maps.LatLng(position.lat, position.lng)
													});
												});
											
											clusterer.addMarkers(markers);
											--%>
											
											

											// 지도의 중심을 결과값으로 받은 위치로 이동 
											map.setCenter(coords);

											// ★ resize 마커 중심 
											var markerPosition = marker.getPosition();
											$(window).on('resize', function() {
												map.relayout();
												map.setCenter(markerPosition);
											});
		
											
											}					
										
									});
					
					
				});
		
		
		var clusterer = new kakao.maps.MarkerClusterer({
			map: map,	//마커들을 클러스터로 관리하고 표시할 지도 객체
			averageCenter: true,	//클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
			minLevel: 10	//클러스터 할 최소 지도 레벨
		});
		
		(addr,function(data){
			
			var markers = $(data.positions).map(function(i,position){
				return new kakao.maps.Marker({
					position : new kakao.maps.LatLng(position.lat, position.lng)
				});
			});
		
			clusterer.addMarkers(markers);
		
		
		
		
		});	
		
		
		// 카카오 지도 API E 
		///////////////////
	</script>
	</head>
	</body>
	
</html>

<html lang="ko">

<head>
	<meta charset="UTF-8">
	<title>JavaScript Output</title>
</head>

<body>
<p id="1"></p> 
	
	<script>

	
	
	</script>
	
</body>

</html>

