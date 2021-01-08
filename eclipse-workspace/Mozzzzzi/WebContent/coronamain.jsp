<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>

<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.nodes.Element"%>
<%@ page import="org.jsoup.select.Elements"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		Document doc = Jsoup.connect("https://datalab.naver.com/keyword/realtimeList.naver?age=all&groupingLevel=0&news=-2&sports=-2&where=main").get();
		//<ul class="ah_1">
		//<li class="ah_item">

		Elements elements = doc.select("ul.ranking_list"); //클래스는 . 으로 대체한다
		//out.println(elements.size()+"개"); //elements는 3개마다 3개중 첫번째 것만을 취한다

		Element element = elements.get(0);
		Elements lis = element.select("li");
		//out.println(lis.size()+"개"); //20개

		for (Element e : lis) {
			out.println(e.select("span.item_num").get(0).text() + ":");
			out.println(e.select("span.item_title").get(0).text() + "<br>");
		}
	%>

</body>
</html>