package com.test;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.model.RaceDataLoader;
import com.pckeiba.racedata.RaceDataLoad;
import com.pckeiba.racedata.RaceDataSet;
import com.pckeiba.umagoto.UmagotoDataLoad;
import com.pckeiba.umagoto.UmagotoDataSet;

public class ListLoadTest {
	
	public static void main(String[] args) {
		RaceDataLoader loader = new RaceDataLoader("2018042908030411",4);
		RaceDataSet raceData = loader.getRaceDataSet();
		List<UmagotoDataSet> umaList = loader.getNowRaceDataList();
		System.out.println(raceData.getKyosomeiHondai());
		System.out.println(umaList.get(0).getBamei());
	}
}
