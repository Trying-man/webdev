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
	�˻� : <input type="text" name="id" />
	<p>
	<div class="mapWrap">
		<div id="map" style="width: 100%; height: 400px;"></div>
	</div>
	<div id="coordXY"></div>
	</div>
	
	<!-- �� Ű�Է� ���� &libraries=services �ʼ��Է� -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=838338d237cae9646ef84df5b932af7a&libraries=clusterer"></script>
	<p style="margin-top:-12px">
   <H1> ����� �����͸� ���÷��� </H1>
    <em class="link">
       <a href="js\jquery-3.5.1.js" target="_blank">���⸦ Ŭ���ϼ���!</a>
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
    var map = new kakao.maps.Map(document.getElementById('map'), { // ������ ǥ���� div
        center : new kakao.maps.LatLng(36.2683, 127.6358), // ������ �߽���ǥ 
        level : 13 // ������ Ȯ�� ���� 
    });
    
    // ��Ŀ Ŭ�����ͷ��� �����մϴ� 
    var clusterer = new kakao.maps.MarkerClusterer({
        map: map, // ��Ŀ���� Ŭ�����ͷ� �����ϰ� ǥ���� ���� ��ü 
        averageCenter: true, // Ŭ�����Ϳ� ���Ե� ��Ŀ���� ��� ��ġ�� Ŭ������ ��Ŀ ��ġ�� ���� 
        minLevel: 7 // Ŭ������ �� �ּ� ���� ���� 
    });
  
    
    
    
   
    
    
    
    
    $(document).ready(function(){
    	console.log('start');
    	
    
	    // �����͸� �������� ���� jQuery�� ����մϴ�
    	// �����͸� ������ ��Ŀ�� �����ϰ� Ŭ�����ͷ� ��ü�� �Ѱ��ݴϴ�
    	$.get("/download/web/data/chicken.json", function(positions) {
        // �����Ϳ��� ��ǥ ���� ������ ��Ŀ�� ǥ���մϴ�
        // ��Ŀ Ŭ�����ͷ��� ������ ��Ŀ ��ü�� ������ �� ���� ��ü�� �������� �ʽ��ϴ�
        	var markers = $(positions).map(function(i, position) {
            	return new kakao.maps.Marker({
                	position : new kakao.maps.LatLng(position.lat, position.lng)
            	});
        	});

        	// Ŭ�����ͷ��� ��Ŀ���� �߰��մϴ�
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

