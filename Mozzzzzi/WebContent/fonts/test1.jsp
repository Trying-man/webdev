<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" 
	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" 
	crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" 
    integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" 
    crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" 
    integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" 
    crossorigin="anonymous"></script>
	<title>JSP AJAX</title>
	
	<!--
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->
	
	
	<link rel="icon" href="data:;base64,iVBORw0kGgo=">
	
	
	<script type = "text/javascript">
		var request = new XMLHttpRequest();
		function searchFunction(){
			request.open("Post","./UserSearchServlet?userName="+ encodeURIComponent(document.getElementById("userName").value),true);
			request.onreadystatechange = searchProcess;
			request.send(null);
		}

		function searchProcess(){
			var table = document.getElementById("ajaxTable");
			table.innerHTML = "";
			if(request.readyState == 4 && request.status == 200){
				var object = eval('('+ request.responseText + ')');
				var result = object.result;
				
				for(var i=0; i < result.length; i++){
					var row = table.insertRow(0);
					for(var j=0; j < result[i].length; j++){
						var cell = row.insertCell(j);
						cell.innerHTML = result[i][j].value;
					}
				}
			}															
		}
		window.onload = function (){
			searchFunction();
		} 
	
	</script>
<title>Insert title here</title>
</head>
<body>
	<br>
	<div class="container">
		<div class="form-group row small-right">
			<div class="col-xs-8">
				<input class="form-control" id ="userName" onkeyup="searchFunction()" type="text" size="20">		
		</div>
		<div class="col-xs-2">
			<button class="btn btn-primary" onclick="searchFunction()" type="button">검색</button>
		</div>
	</div>
	<table class="talbe" style="text-align: center; border: 1px solid #dddddd">
		<thead> 
			<tr>
				<th style="background-color: #fafafa; text-align: center;">상호명</th>
				<th style="background-color: #fafafa; text-align: center;">경도</th>
				<th style="background-color: #fafafa; text-align: center;">위도</th>
			</tr>
		</thead>
		<tbody id="ajaxTable">			
		</tbody>
	</table>
	</div>
</body>
</html>