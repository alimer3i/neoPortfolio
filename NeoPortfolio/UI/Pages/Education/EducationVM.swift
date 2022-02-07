//
//  EducationVM.swift
//  NeoPortfolio
//
//  Created by Ali Merhie on 2/6/22.
//

import Foundation
import Charts

class EducationVM: BaseVM {
     
    var id: Box<String> = Box("")
    var createdAt: Box<String> = Box("")
    var riskScore: Box<String> = Box("")
    var investmentType: Box<String> = Box("")
    var chartData: Box<LineChartData> = Box(LineChartData())
    var hisotricalList: [HistoricalModel] = []{
        didSet{
            updateChartData()
        }
    }
    
    var selectedPortfolio: PortfolioModel? {
        didSet{
            id.value = selectedPortfolio?.id ?? "-"
            createdAt.value = selectedPortfolio?.created_at.toDate(format: "yyyy-MM-dd HH:mm:ss.SSS").toDateString(format: "dd MMMM") ?? "-"
            riskScore.value = "\(selectedPortfolio?.modified_risk_score ?? 0)"
            investmentType.value = selectedPortfolio?.investment_type ?? "-"
        }
    }

    func pageDidLoad(){
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: .historicalUpdated, object: nil)
        fetchData()
    }
    required init() {
        
    }
    
    @objc func fetchData(){
        self.hisotricalList = Array(HistoricalRealmHelper.shared.load())
    }
    private func updateChartData(){
        var benchMarkValues: [ChartDataEntry] = []
        var smartWealthValues: [ChartDataEntry] = []
        
        for dayData in hisotricalList {
            var date = (dayData.date ?? "Jan 2021").toDate(format: "MMM YYYY")
            let dayInSeconds = date.timeIntervalSince1970 ?? Date().timeIntervalSince1970
            benchMarkValues.append(ChartDataEntry(x: dayInSeconds, y: Double(dayData.benchmarkValue ?? 0)))
            smartWealthValues.append(ChartDataEntry(x: dayInSeconds, y: Double(dayData.smartWealthValue ?? 0)))
        }
        let benchMarkSet = LineChartDataSet(entries: benchMarkValues, label: "Benchmark")
        benchMarkSet.axisDependency = .left
        benchMarkSet.setColor(UIColor.red)
        benchMarkSet.lineWidth = 1.5
        benchMarkSet.drawCirclesEnabled = false
        benchMarkSet.drawValuesEnabled = false
        benchMarkSet.circleRadius = 3
        benchMarkSet.fillAlpha = 0.26
        benchMarkSet.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        benchMarkSet.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        benchMarkSet.drawCircleHoleEnabled = false
        
        let smartWealthSet = LineChartDataSet(entries: smartWealthValues, label: "Smart Wealth")
        smartWealthSet.axisDependency = .left
        smartWealthSet.setColor(UIColor.blue)
        smartWealthSet.lineWidth = 1.5
        smartWealthSet.drawCirclesEnabled = false
        smartWealthSet.drawValuesEnabled = false
        smartWealthSet.fillAlpha = 0.26
        smartWealthSet.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        smartWealthSet.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        smartWealthSet.drawCircleHoleEnabled = false
        
        let data = LineChartData(dataSets: [benchMarkSet, smartWealthSet])
        data.setValueTextColor(.black)
        data.setValueFont(.systemFont(ofSize: 9, weight: .light))
        chartData.value = data
        
    }
    public class DateValueFormatter: NSObject, IAxisValueFormatter {
        private let dateFormatter = DateFormatter()
        
        override init() {
            super.init()
            dateFormatter.dateFormat = "yyyy"
        }
        
        public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return dateFormatter.string(from: Date(timeIntervalSince1970: value))
        }
    }
}
