//
//  networkServicesManager.swift
//  NeoPortfolio
//
//  Created by Ali Merhie on 2/6/22.
//

import Foundation


class NetworkServicesManager: NSObject {

    static let shared: NetworkServicesManager = NetworkServicesManager()

    func updatePortfolioData(){
        ServiceLayer.request(router: PortfolioAPI.portfolio, model: PortfolioModel.self) { result in
            switch result{
            
            case .success(let response):
                PortfolioRealmHelper.shared.save(data: response)
                break
            case .failure(let error):
                break
            }
        }
    }
    func updateOptionData(){
        ServiceLayer.request(router: PortfolioAPI.options, model: OptionsModel.self) { result in
            switch result{
            case .success(let response):
                OptionsRealmHelper.shared.save(data: response)
                break
            case .failure(let error):
                break
            }
        }
    }
    func updateHistoricalData(){
        ServiceLayer.request(router: PortfolioAPI.historical, model: HistoricalModel.self) { result in
            switch result{
            case .success(let response):
                HistoricalRealmHelper.shared.save(data: response)
                break
            case .failure(let error):
                break
            }
        }
    }
}
