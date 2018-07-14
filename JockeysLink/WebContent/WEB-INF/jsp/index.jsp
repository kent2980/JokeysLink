<%@ page
	language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"

    import="com.pckeiba.schedule.RaceListLoad"
    import="com.pckeiba.racedata.RaceDataSet"
    import="com.pckeiba.racedata.RaceDataSetComparetor"
    import="java.util.List"
    import="java.util.Map"
    import="java.util.stream.Collectors"
    import="java.util.Collections"
%>
<%
	RaceListLoad loader = (RaceListLoad)request.getAttribute("loader");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/StyleDanceTable.css" rel="stylesheet">
<link href="/JockeysLink/css/StyleDanceTable.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body class="index">

<nav>
	<ui>
		<li><a href="#">HOME</a></li>
		<li><a href="#">本日のレース</a></li>
		<li><a href="#">開催スケジュール</a></li>
		<li><a href="#">データベース</a></li>
		<li class="map"><a href="#">サイトマップ</a></li>
	</ui>
</nav>

<div id="keibajo">
<ui>
<%
	int i = 0;
	for(String keibajo : loader.getKeibajoList()){
		out.println("<div class=\"keibajo" + i + "\">" + keibajo + "</div>");
		i++;
	}
%>
</ui>
</div>

<div class="racebox">
<%
	int kaisaiArea = loader.getKeibajoCount();
	i = 0;
	out.println("<selection class=\"kaisai" + kaisaiArea + "\">");
	for(String keibajo : loader.getKeibajoList()){
		out.println("<div class=\"racelist" + i + "\">");
		List<RaceDataSet> raceList = loader.getRaceList(keibajo);
		Collections.sort(raceList, new RaceDataSetComparetor());
		for(RaceDataSet rs : raceList){
			String kyosoTitle = rs.getKyosomeiHondai().length()>0
					?rs.getKyosomeiRyaku10()
					:rs.getKyosoShubetsu().substring(rs.getKyosoShubetsu().indexOf("系")+1, rs.getKyosoShubetsu().length()) + rs.getKyosoJoken();
			out.println("<div>");
			out.println("<a href=\"/JockeysLink/Race?racecode=" + rs.getRaceCode() + "\">");
			out.println(rs.getRaceBango() + "R");
			out.println(rs.getHassoJikoku());
			out.println(kyosoTitle);
			out.println("<br>");
			out.println("<div class=\"kyosoinfo\">");
			out.println(rs.getBaba());
			out.println(rs.getKyori() + "m");
			out.println(rs.getTorokuTosu() + "頭");
			out.println("</div>");
			out.println("</a>");
			out.println("</div>");
		}
		out.println("</div>");
		i++;
	}
	out.println("</selection>");
%>
</div>
</body>
</html>