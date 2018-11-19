<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.pckeiba.racedata.RaceDataSet"
         import="com.pckeiba.umagoto.UmagotoDataSet"
         import="com.pckeiba.umagoto.UmagotoDrunSet"
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
<title><%out.print(kyosoTitle); %></title>
</head>
<body>

<!-- *****************************************************************************************
     ********************************ここからグラフを記述する*****************************************
     ***************************************************************************************** -->


        <!-- ①チャート描画先を設置 -->
        <canvas id="myChart" style="width: 100%; height: 600;"></canvas>

        <!-- その他内容（任意） -->

        <!-- ②Chart.jsの読み込み -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js"></script>

        <!-- ③チャート描画情報の作成 -->
        <script>
            var ctx = document.getElementById("myChart");
            var myChart = new Chart(ctx, {
                type: 'horizontalBar', // チャートのタイプ
                data: { // チャートの内容
                	<%
                	for(int i = 0; i < drunList.size(); i++){
                		UmagotoDrunSet uma1 = drunList.get(i);
						if(i==0){
							out.print("labels: [");
						}
                		out.print("\"" + uma1.getBamei() + "\"");
                		if(i > umaNowData.size()-2){
                			out.print("],");
                			break;
                		}
                		out.print(",");
                	}
                	%>

                    datasets: [{
                        label: 'タイムランク',
                        <%
                        for(int i = 0;;i++){
                        	int umaban = i + 1;
                        	UmagotoDrunSet uma1 = drunList.get(i);
                        	if(i == 0){
                        		out.print("data: [");
                        	}
                        	out.print(uma1.getDrun().add(BigDecimal.valueOf(12)).multiply(BigDecimal.valueOf(4.5)));
                    		if(i > drunList.size()-2){
                    			out.print("],");
                    			break;
                    		}
                    		out.print(",");
                        }
                        %>
                        backgroundColor: 'rgba(255, 99, 132, 0.8)',
                        borderWidth: 1
                    }]
                },
                options: { // チャートのその他オプション
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero:true,
                                min: 40,
                                max: 60
                            }
                        }]
                    }
                }
            });
        </script>

<!-- *****************************************************************************************
     **********************************グラフ記述ここまで*******************************************
     ***************************************************************************************** -->

</body>
</html>