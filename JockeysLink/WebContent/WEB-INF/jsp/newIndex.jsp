<%@ page
	language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"

    import="com.pckeiba.schedule.RaceListLoad"
    import="com.pckeiba.racedata.RaceDataDefault"
    import="com.pckeiba.racedata.RaceDataSetComparetor"
    import="java.util.List"
    import="java.util.Map"
    import="java.util.stream.Collectors"
    import="java.util.Collections"
    import="java.time.LocalDate"
         import="com.util.UtilClass"
%>
<%
	RaceListLoad raceListloader = UtilClass.AutoCast(request.getAttribute("raceListloader"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/StyleDanceTable.css" rel="stylesheet">
<link href="/JockeysLink/css/StyleDanceTable.css" rel="stylesheet">
<title><% out.print(raceListloader.getDate()); %></title>
</head>

<body>

</body>
</html>