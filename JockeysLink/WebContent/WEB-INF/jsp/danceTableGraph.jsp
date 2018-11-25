<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.pckeiba.racedata.RaceDataSet"
         import="com.pckeiba.umagoto.UmagotoDataSet"
         import="com.pckeiba.umagoto.UmagotoDrunSet"
         import="com.pckeiba.umagoto.UmagotoDataIndexLoad"
         import="com.pckeiba.umagoto.UmagotoDataIndexSet"
         import="com.pckeiba.analysis.UmagotoAnalysis"
         import="java.util.List"
         import="java.util.Map"
         import="java.io.PrintWriter"
         import="com.util.UtilClass"
         import="java.math.BigDecimal"
         import="java.lang.IndexOutOfBoundsException"
   		 import="java.time.LocalDate"
   		 import="java.util.HashMap"
   		 import="java.util.ArrayList"
%>
<%
RaceDataSet raceData = (RaceDataSet) request.getAttribute("raceData");
List<UmagotoDataSet> umaNowData = UtilClass.AutoCast(request.getAttribute("umaList"));
List<Map<String,UmagotoDataSet>> umaKakoData = UtilClass.AutoCast(request.getAttribute("umaMap"));
List<UmagotoDrunSet> drunList = UtilClass.AutoCast(request.getAttribute("drunList"));
UmagotoDataIndexLoad indexLoad = UtilClass.AutoCast(request.getAttribute("index"));
List<UmagotoDataIndexSet> indexList = indexLoad.getIndexList();
UmagotoAnalysis analysis = (UmagotoAnalysis) request.getAttribute("analysis");
PrintWriter pw = response.getWriter();
String kyosoTitle = raceData.getKyosomeiHondai().length()>0
				?raceData.getKyosomeiHondai()
				:raceData.getKyosoShubetsu().substring(raceData.getKyosoShubetsu().indexOf("系")+1, raceData.getKyosoShubetsu().length()) + raceData.getKyosoJoken();

/************************<変数の説明>****************************
* raceData = 指定したレースコードのレースデータを取得します
* umaNowData = 指定したレースコードの馬毎データを取得します
* umaKakoData = 過去走の馬毎データを取得します
* drunList = 馬毎のDRunを取得します
***************************************************************/

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://fonts.googleapis.com/earlyaccess/roundedmplus1c.css" rel="stylesheet" />
<link href="../css/danceTableGraph.css" rel="stylesheet">
<link href="/JockeysLink/css/danceTableGraph.css" rel="stylesheet">
<title><%out.print(kyosoTitle); %></title>
</head>
<body>

<!-- *****************************************************************************************
     *****************************************************************************************
     							レースデータを記述します
     *****************************************************************************************
     ***************************************************************************************** -->
<div id="title">
  <div class="roundData">
  	  <span class="kaisai"><% out.print(raceData.getKaisaiNenGappi() + "（" + raceData.getYobi() + "）"); %></span>
	  <span class="keibajo"><% out.print(raceData.getKeibajo()); %></span>
	  <span class="round"><% out.print(raceData.getRaceBango() + "R"); %></span>
  </div>
  <div id="kyosomei">
  	<% String jushoKaiji = raceData.getJushoKaijiCode()==0?"":"第" + raceData.getJushoKaiji() + "回"; %>
    <span class="kaiji"><% out.print(jushoKaiji); %></span>
  	<span class="kyosomei"><% out.print(kyosoTitle); %></span>
  </div>
  <div class="data courseData">
    <span><% out.print(raceData.getKyori() + "m"); %></span>
    <span><% out.print(raceData.getTrackCode()); %></span>
    <span><% out.print(raceData.getHassoJikoku()); %></span>
  </div>
  <div class="data raceData">
  	<span><% out.println(raceData.getKyosoJoken()); %></span>
  	<span><% out.println(raceData.getKyosoShubetsu()); %></span>
  	<span><% out.println(raceData.getKyosoKigo()); %></span>
  	<span><% out.print(raceData.getJuryoShubetsu()); %></span>
  	<span><% out.print(raceData.getTorokuTosu() + "頭"); %></span>
  </div>
</div>

<!-- *****************************************************************************************
     ********************************ここからグラフを記述する*****************************************
     ***************************************************************************************** -->

        <!-- ①チャート描画先を設置 -->
        <%
        	int tosu = raceData.getShussoTosu();
        	int height = tosu < 15 ? 25 : 30;
        %>
        <div id="Chart" width:"100%">
        	<h2 class=title>タイムランク</h2>
        	<canvas id="myChart" width="100" height="<% out.print(height); %>"></canvas>
		</div>

        <!-- ②Chart.jsの読み込み -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js"></script>

		<!-- ③チャート描画情報の作成 -->
		<script>
			window.onload = function() {
			    ctx = document.getElementById("myChart").getContext("2d");
			    window.myBar = new Chart(ctx, {
			        type: 'bar',
			        data: barChartData,
			        options: complexChartOption
			    });
			};
		</script>

        <!-- ④チャートデータの作成 -->
        <script>
            var barChartData = {
                	labels: [<%
                		for(int i = 0; i < indexList.size(); i++){
                			UmagotoDataIndexSet uma1 = indexList.get(i);
                    		int umaban = uma1.getUmaban()==0 ? i + 1 : uma1.getUmaban();
							out.print("\"" + umaban + ". " + uma1.getBamei() + "\"");
							if(i + 1 < indexList.size()){
								out.print(",");
							}
                		}
                	%>],
                    datasets: [
                    {
                    	type: 'bar',
                        label: 'タイムランク',
                    	data: [<%
                    		for(int i = 0; i < indexList.size(); i++){
                    			UmagotoDataIndexSet uma1 = indexList.get(i);
								out.print(uma1.getDrun());
								if(i + 1 < indexList.size()){
									out.print(",");
								}
                    		}
                    	%>],
                    	backgroundColor : [<%
                            String escape = "'rgba(255, 57, 59, 0.8)'";
                        	String preceding = "'rgba(255, 140, 60, 0.8)'";
                        	String insert = "'rgba(246, 255, 69, 0.8)'";
                        	String last = "'rgba(57, 157, 255, 0.8)'";
                        	String defaultColor = "'rgba(184, 184, 184, 0.8)'";
                        	for(int i = 0; i < indexList.size(); i++){
								String kettoTorokuBango = indexList.get(i).getKettoTorokuBango();
								int kyakushitsu = analysis.getPredictionKyakushitsuHantei(kettoTorokuBango);
								switch(kyakushitsu){
								case 1:
									out.print(escape);
									break;
								case 2:
									out.print(preceding);
									break;
								case 3:
									out.print(insert);
									break;
								case 4:
									out.print(last);
									break;
								default:
									out.print(defaultColor);
								}
								if(i + 1 < indexList.size()){
									out.print(",");
								}
                        	}
                        %>],
                        borderWidth: 1
                    },
                    {
                    	type: 'line',
                    	label: 'トップスピード',
                    	data: [<%
                    		for(int i = 0; i < indexList.size(); i++){
                    			UmagotoDataIndexSet uma1 = indexList.get(i);
								out.print(uma1.getSpeedRate());
								if(i + 1 < indexList.size()){
									out.print(",");
								}
                    		}
                    	%>],
                    	borderColor : 'rgba(54,164,235,0.5)',
                        backgroundColor : 'rgba(54,164,235,0.5)'
                    }
                    ],
            };
		</script>

		<!-- ⑤オプションの作成 -->
		<%
	    int minDrun = indexList.stream()
	    					   .filter(s -> s.getDrun() != null)
		   					   .mapToInt(s -> s.getDrun().setScale(-1, BigDecimal.ROUND_DOWN).intValue())
		   					   .min().getAsInt();
	    int minSpeedRate = indexList.stream()
	    							.filter(s -> s.getSpeedRate() != null)
					 				.mapToInt(s -> s.getSpeedRate().setScale(-1, BigDecimal.ROUND_DOWN).intValue())
								    .min().getAsInt();
	    int minYscale = minDrun < minSpeedRate ? minDrun : minSpeedRate;
		%>
		<script>
		var complexChartOption = {
	              responsive: true,
                    scales: {
                    	xAxes: [{
                    		ticks: {
                    			autoSkip: false,
                    			fontSize: 13
                    		},
                    	}],
                        yAxes: [{
                            ticks: {
                                beginAtZero:true,
                                min: <% out.print(minYscale); %>,
                                max: 60,
                                fontSize: 14
                            },
                        }],
                    }
            };
        </script>

<!-- *****************************************************************************************
     **********************************グラフ記述ここまで*******************************************
     ***************************************************************************************** -->

<!-- *****************************************************************************************
*********************************							**********************************
*********************************	テーブルを作成します(*´ω｀*)	**********************************
*********************************							**********************************************************
********************************************************************************************************************** -->

	<div class="danceIndex">
		<div class="tableTitle">
		<h2>出馬表</h2>
		<table class="danceTable">
			<tr>
				<th>印</th>
				<th>枠番</th>
				<th>馬番</th>
				<th>馬名</th>
				<th>性齢</th>
				<th>脚質</th>
				<th>平均距離</th>
				<th>騎手</th>
				<th>斤量</th>
				<th>単勝人気</th>
				<th>単勝オッズ</th>
				<th>馬体重</th>
				<th>調教師</th>
				<th>毛色</th>
			</tr>
			<% for(int i = 0; i < umaNowData.size(); i++){
					int umaban = i + 1;
					UmagotoDataSet data = umaNowData.get(i);
					String kettoTorokuBango = data.getKettoTorokuBango();
					//枠番が同じ場合に結合を行います
					int wakuban = data.getWakuban();
					int previousWakuban = 0;
					int nextWakuban = 0;
					int thirdWakuban = 0;
					if(i > 0)
						previousWakuban = umaNowData.get(i - 1).getWakuban();
					try{
						nextWakuban = umaNowData.get(i + 1).getWakuban();
						try{
							thirdWakuban = umaNowData.get(i + 2).getWakuban();
						}catch(IndexOutOfBoundsException e2){
							thirdWakuban = 0;
						}
					}catch(IndexOutOfBoundsException e){
						nextWakuban = 0;
					}
					String key = (wakuban * wakuban) == (nextWakuban * thirdWakuban) ? " rowspan=\"3\"" : wakuban == nextWakuban ? " rowspan=\"2\"" : "";
					boolean wakuHantei = wakuban == previousWakuban;
			%>
			<tr>
				<%
					if(wakuHantei == false){
				%>
				<td class="waku<% out.print(data.getWakuban()); %>"<% out.print(key); %>><% out.print(data.getWakuban()==0?"仮":data.getWakuban()); %></td>
				<%
					}
				%>
				<td><% out.print(data.getUmaban()==0 ? umaban : data.getUmaban()); %></td>
				<td>
					<select name="shirushi" class="shirushi">
						<option selected></option>
						<option value="marumaru">◎</option>
						<option value="maru">〇</option>
						<option value="kurosankaku">▲</option>
						<option value="sankaku">△</option>
						<option value="star">★</option>
					</select>
				</td>
				<td class="left"><% out.print(data.getBamei()); %></td>
				<td><% out.print(data.getSeibetsu() + data.getBarei()); %>
				<td><% out.print(analysis.getPredictionKyakushitsu(kettoTorokuBango)); %>
				<td><% out.print(indexLoad.getAverageKyori(kettoTorokuBango)==0?"-":indexLoad.getAverageKyori(kettoTorokuBango) + "m"); %>
				<td><% out.print(data.getKishumei().replace("　", "")); %></td>
				<td><% out.println(data.getFutanJuryo()); %></td>
				<td><% out.println(data.getTanshoNinkijun()==0?"-":data.getTanshoNinkijun()); %></td>
				<td><% out.print(data.getTanshoOdds()==0?"-":data.getTanshoOdds()); %></td>
				<td><% out.print(data.getBataiju()==0?"-":data.getBataiju()); %></td>
				<td class="left"><% out.print("（" + data.getTozaiShozoku().substring(0, 1) + "）" + data.getChokyoshi().replace("　", "")); %></td>
				<td><% out.print(data.getMoshoku()); %></td>
			</tr>
			<% } %>
		</table>
		</div>
		<div id="index">
			<h2>展開予想</h2>
			<div class="data">
				<h3>隊列</h3>
				<span><% out.print(indexLoad.getRaceConvoy()); %></span>
				<h3>ペース</h3>
				<span><% out.print(indexLoad.getRacePace()); %></span>
				<h3>逃げ馬</h3>
				<span>
				<%
					List<String> list1 = analysis.getKyakushitsuLabel(1);
					for(int i = 0; i < list1.size();i++){
						out.print(list1.get(i));
						if(i + 1 < list1.size()){
							out.print("、");
						}
					}
				%>
				</span>
				<h3>先行馬</h3>
				<span>
				<%
					List<String> list2 = analysis.getKyakushitsuLabel(2);
					for(int i = 0; i < list2.size();i++){
						out.print(list2.get(i));
						if(i + 1 < list2.size()){
							out.print("、");
						}
					}
				%>
				</span>
				<h3>差し</h3>
				<span>
				<%
					List<String> list3 = analysis.getKyakushitsuLabel(3);
					for(int i = 0; i < list3.size();i++){
						out.print(list3.get(i));
						if(i + 1 < list3.size()){
							out.print("、");
						}
					}
				%>
				</span>
				<h3>追込み</h3>
				<span>
				<%
					List<String> list4 = analysis.getKyakushitsuLabel(4);
					for(int i = 0; i < list4.size();i++){
						out.print(list4.get(i));
						if(i + 1 < list4.size()){
							out.print("、");
						}
					}
				%>
				</span>
	    	</div>
    	</div>
	</div>

</body>
</html>