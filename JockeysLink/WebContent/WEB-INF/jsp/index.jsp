<%@ page
	language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"

    import="com.pckeiba.schedule.RaceListLoad"
    import="com.pckeiba.racedata.RaceDataSet"
    import="java.util.List"
    import="java.util.Map"
    import="java.util.stream.Collectors"
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
<body id="index">
<header>
<div class="headbar"></div>
<div class="headbutton">
	<div class="home">
		<a href="/JockeysLink/index">Home</a>
	</div>
	<div class="schedule headbutton">
		<a href="#">Schedule</a>
	</div>
	<div class="data headbutton">
		<a href="#">Data</a>
	</div>
</div>
</header>

<div class="keibajo">
<%
	int i = 0;
	for(String keibajo : loader.getKeibajoList()){
		out.println("<div class=\"keibajo" + i + "\">");
		out.println(keibajo);
		out.println("</div>");
		i++;
	}
%>
</div>

<div class="racebox">
<%
	int kaisaiArea = loader.getKeibajoCount();
	i = 0;
	out.println("<selection class=\"kaisai" + kaisaiArea + "\">");
	for(String keibajo : loader.getKeibajoList()){
		out.println("<div class=\"keibajo" + i + "\">");
		List<RaceDataSet> raceList = loader.getRaceList(keibajo);
		for(RaceDataSet rs : raceList){
			String kyosoTitle = rs.getKyosomeiHondai().length()>0
					?rs.getKyosomeiRyaku10()
					:rs.getKyosoShubetsu().substring(rs.getKyosoShubetsu().indexOf("系")+1, rs.getKyosoShubetsu().length()) + rs.getKyosoJoken();
			out.println("<div>");
			out.println("<a href=\"http://192.168.10.60:8080/JockeysLink/Race?racecode=" + rs.getRaceCode() + "\">");
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