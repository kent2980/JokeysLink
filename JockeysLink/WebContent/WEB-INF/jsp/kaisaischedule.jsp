<%@ page
	language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"

    import="com.pckeiba.schedule.*"
    import="java.util.*"
    import="java.time.LocalDate"
    import="java.time.format.DateTimeFormatter"
%>
<%
SelectYearSchedule schedule = (SelectYearSchedule)request.getAttribute("schedule");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/StyleDanceTable.css" rel="stylesheet">
<link href="/JockeysLink/css/StyleDanceTable.css" rel="stylesheet">
<title>開催スケジュール</title>
</head>
<body>

<nav>
	<ui>
		<li><a href="/JockeysLink/index">HOME</a></li>
		<li><a href="#">本日のレース</a></li>
		<li><a href="/JockeysLink/kaisaichedule?year=<% out.println(LocalDate.now().getYear()); %>">開催スケジュール</a></li>
		<li><a href="#">データベース</a></li>
		<li class="map"><a href="#">サイトマップ</a></li>
	</ui>
</nav>

<div id="kaisaiSchedule">
<%
	//本日までのレースのみを抽出します
	List<KaisaiScheduleSet> scheduleList = schedule.getScheduleList(LocalDate.now().plusDays(4));
	//開催スケジュールを表示します
	LocalDate date = LocalDate.of(1900, 1, 1);
	for(KaisaiScheduleSet s : scheduleList){
		//開催年月日が異なる場合は・・・
		if(!s.getKaisaiNengappi().isEqual(date)){
			if(!date.isEqual(LocalDate.of(1900, 1, 1)))
				out.println("</div>");
			date = s.getKaisaiNengappi();
			out.print("<div class=\"nengappi\">");
			%>
			<a href="/JockeysLink/index?kaisai=<% out.print(s.getKaisaiNengappi()); %>"><% out.print(s.getKaisaiNengappi().format(DateTimeFormatter.ofPattern("MM月dd日")) + "（" + s.getYobi() + "）"); %></a>
			<%
		}
		if(s.getJusho1().getTokubetsuKyosoBango()>0){
			%>
			<span class="keibajo"><% out.print(s.getKeibajo()); %>競馬場</span>
			<span class="kyosoTitle"><a href="/JockeysLink/Race?racecode=<% out.print(s.getJusho1().getRaceCode()); %>"><% out.print(s.getJusho1().getKyosomeiRyakusho_6()); %></a></span>
			<%
		}else{
			%>
			<span class="keibajo notJusho"><% out.print(s.getKeibajo()); %>競馬場</span>
			<%
		}
	}
	out.println("<div>");
%>
</div>
</body>
</html>