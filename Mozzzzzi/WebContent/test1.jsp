<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script
  src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
<head>
<meta charset="UTF-8">
	<div align="center">
	<h1>TEST1</h1>
	검색 : <input type="text" name="id" />
	<p>
	<div class="mapWrap">
		<div id="map" style="width: 100%; height: 400px;"></div>
	</div>
	<div id="coordXY"></div>
	</div>
	
	<!-- ★ 키입력 뒷편 &libraries=services 필수입력 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=838338d237cae9646ef84df5b932af7a&libraries=clusterer"></script>
	<p style="margin-top:-12px">
   <H1> 사용한 데이터를 보시려면 </H1>
    <em class="link">
       <a href="js\jquery-3.5.1.js" target="_blank">여기를 클릭하세요!</a>
    </em>
</p>

 <div id="map" style="width:100%;height:350px;"></div>
 <script type="text/javascript">
 	var request = new XMLHttpRequest();
 	function searchFunction(){
 		request.open("Post", "./UserSearchServlet?userName" + encodeURIComponent(document.getElementById("userName").value), true);
 		request.onreadystatechange = searchProcess;
 		request.send(null);
 	}
 	function searchProcess(){
 		var table = document.getElementById("ajaxTable");
 		table.innerHTML = "";
 		if(request.readyState == 4 && request.status == 200){
 			var object eval('('+request.responseText + ')');
 			var result = object.result;
 			for(var i=0; i<result.length; i++){
 				var row = table.insertRow(0);
 				for(var j=0;j<result[i].length; j++){
 					cell.innerHTML = result[i][j].value;
 				}
 			}
 		}
 	}
 
 
 </script>
<script>
    var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
        center : new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
        level : 13 // 지도의 확대 레벨 
    });
    
    // 마커 클러스터러를 생성합니다 
    var clusterer = new kakao.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 7 // 클러스터 할 최소 지도 레벨 
    });
  
    
    
    
   
    
    
    
    
    $(document).ready(function(){
    	console.log('start');
    	
    
	    // 데이터를 가져오기 위해 jQuery를 사용합니다
    	// 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
    	$.get("/download/web/data/chicken.json", function(positions) {
        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
        	var markers = $(positions).map(function(i, position) {
            	return new kakao.maps.Marker({
                	position : new kakao.maps.LatLng(position.lat, position.lng)
            	});
        	});

        	// 클러스터러에 마커들을 추가합니다
        	clusterer.addMarkers(markers);
    	});
    })
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

<%=request.getParameter("yy")%>
	<script>
	
	
	</script>
	
</body>

</html>

