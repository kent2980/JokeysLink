<%@ page
	language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"

    import="com.pckeiba.schedule.*"
    import="java.util.*"
    import="java.time.LocalDate"
%>
<%
SelectYearSchedule schedule = (SelectYearSchedule)request.getAttribute("schedule");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//本日までのレースのみを抽出します
	List<KaisaiScheduleSet> scheduleList = schedule.getScheduleList(LocalDate.now().plusDays(2));
	//開催スケジュールを表示します
	for(KaisaiScheduleSet s : scheduleList){
		out.println("<a href=\"/JockeysLink/index?kaisai=" + s.getKaisaiNengappi() + "\">" + s.getKaisaiNengappi() + "</a>");
		out.println("<br>");
		out.println(s.getJusho1().getKyosomeiHondai());
		out.println("<br>");
	}
%>
</body>
</html>