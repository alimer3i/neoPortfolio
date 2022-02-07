//
//  PortfolioVM.swift
//  NeoPortfolio
//
//  Created by Ali Merhie on 2/5/22.
//

import Foundation

class PortfolioVM: BaseVM {
    
    var reloadTableViewClosure: (()->())?
    var navigateToOptions: ((PortfolioModel)->())?
    
    
    private var portfolios: [PortfolioModel] = [PortfolioModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    
    var numberOfItems: Int {
        return portfolios.count
    }
    func pageDidLoad(){
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: .portfolioUpdated, object: nil)
        fetchData()
    }
    
    required init() {
        
    }
    
    @objc func fetchData(){
        
        self.portfolios = Array(PortfolioRealmHelper.shared.load())
        
    }
    func didSelectRow(at indexPath: IndexPath){
        let item = portfolios[indexPath.row]
        self.navigateToOptions?(item)
    }
    func configure(cell: PortfolioTableViewCell, at indexPath: IndexPath ) {
        let item = portfolios[indexPath.row]
        cell.setup(name: item.name ?? "-", balance: "$\(item.balance ?? 0)")
    }
    
}
