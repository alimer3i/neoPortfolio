//
//  EducationViewController.swift
//  NeoPortfolio
//
//  Created by Ali Merhie on 2/6/22.
//

import UIKit
import Charts

class EducationViewController: BaseViewController<EducationVM> {
    
    override class var pageStoryBoard: AppStoryboard {
        get { return .Education }
    }
    
    @IBOutlet weak var idTitleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var createdTitleLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var riskTitleLabel: UILabel!
    @IBOutlet weak var riskLabel: UILabel!
    @IBOutlet weak var typeTitleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Education"
        idTitleLabel.text = "ID"
        createdTitleLabel.text = "Created At"
        riskTitleLabel.text = "Risk Score"
        typeTitleLabel.text = "Investment Type"
        // Do any additional setup after loading the view
        lineChartView.leftAxis.enabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.drawGridBackgroundEnabled = false        
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.labelTextColor = .black
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.centerAxisLabelsEnabled = false
        //xAxis.granularity = 3600
        xAxis.valueFormatter = EducationVM.DateValueFormatter()
        viewModel.fetchData()
    }
    
    
    override func bindToViewModel() {
        super.bindToViewModel()
        
        viewModel.id.bind { [weak self] value in
            if let strongSelf = self{
                strongSelf.idLabel.text = value
            }
        }
        
        viewModel.createdAt.bind { [weak self] value in
            if let strongSelf = self{
                strongSelf.createdLabel.text = value
            }
        }
        
        viewModel.riskScore.bind { [weak self] value in
            if let strongSelf = self{
                strongSelf.riskLabel.text = value
            }
        }
        
        viewModel.investmentType.bind { [weak self] value in
            if let strongSelf = self{
                strongSelf.typeLabel.text = value
            }
        }
        
        viewModel.chartData.bind { [weak self] data in
            if let strongSelf = self{
                if data.entryCount > 0 {
                    strongSelf.lineChartView.data = data
                }else{
                    strongSelf.lineChartView.clear()
                }
            }
        }
        
    }
    
}
