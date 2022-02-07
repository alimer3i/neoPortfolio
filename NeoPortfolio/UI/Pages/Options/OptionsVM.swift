//
//  OptionsVM.swift
//  NeoPortfolio
//
//  Created by Ali Merhie on 2/5/22.
//

import Foundation

class OptionsVM: BaseVM {
    
    var reloadCollectionViewClosure: (()->())?
    var navigateToEducation: ((PortfolioModel)->())?
    var selectedPortfolio: PortfolioModel?
    var selectedIndex: Int?
    var isOptionSelected: Box<Bool> = Box(false)
    var numberOfPages: Box<Int> = Box(0)
    
    private var options: [OptionsModel] = [OptionsModel]() {
        didSet {
            numberOfPages.value = numberOfItems
            self.reloadCollectionViewClosure?()
        }
    }

    var numberOfItems: Int {
        return options.count
    }
    
    required init() {
        
    }
    func pageDidLoad(){
        isOptionSelected.value = false
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: .optionsUpdated, object: nil)
        fetchData()
    }
    @objc func fetchData(){
        self.options = Array(OptionsRealmHelper.shared.load())
    }
    
    func continueClicked(){
        self.navigateToEducation?(selectedPortfolio ?? PortfolioModel())
    }

    func didSelectRow(at indexPath: IndexPath){
        if let currentIndex = selectedIndex {
            if currentIndex == indexPath.row{
                return
            }
            options[currentIndex].isSelected = false
        }
        isOptionSelected.value = true
        selectedIndex = indexPath.row
        let item = options[indexPath.row]
        item.isSelected = true
        self.reloadCollectionViewClosure?()
    }
    
    func configure(cell: OptionCollectionViewCell, at indexPath: IndexPath ) {
        let item = options[indexPath.row]
        cell.setUp(option: "Option \(indexPath.row + 1)", title: item.name ?? "-", cost: "$\((item.risk_score ?? 0) * 1000)", desc: item.short_description ?? "-", isSelected: item.isSelected ?? false)
    }
}
