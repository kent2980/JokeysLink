package com.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.RaceDataLoader;
import com.pckeiba.racedata.RaceDataSet;
import com.pckeiba.umagoto.UmagotoDataSet;

/**
 * Servlet implementation class ServletTest
 */
@WebServlet("/Race")
public class RaceSouceServlet extends HttpServlet {
	RaceDataLoader loader;
	@Override
	public void destroy() {
		// TODO 自動生成されたメソッド・スタブ
		super.destroy();
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO 自動生成されたメソッド・スタブ
		super.init(config);
	}

	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public RaceSouceServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//URLパラメータからレースコードを取得する
		String requestPara = request.getParameter("racecode");
		loader = new RaceDataLoader(requestPara,4);
		//各レース詳細オブジェクトを取得する
		RaceDataSet raceData = loader.getRaceDataSet();
		List<UmagotoDataSet> umaList = loader.getNowRaceDataList();
		List<Map<String,UmagotoDataSet>> umaMap = loader.getKakoRaceDataMapList();

		//各レース詳細オブジェクトをフォワードする
		request.setAttribute("raceData", raceData);
		request.setAttribute("umaList", umaList);
		request.setAttribute("umaMap", umaMap);
		RequestDispatcher di = request.getRequestDispatcher("/WEB-INF/jsp/danceTable.jsp");
		di.forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
