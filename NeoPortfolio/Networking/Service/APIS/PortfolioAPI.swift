//
//  AccountAPI.swift
//  RBT
//
//  Created by WSLOSX121 on 09/09/2021.
//

import Foundation
import Alamofire
import ObjectMapper

enum PortfolioAPI:URLRequestBuilder {
    
    
    case portfolio
    case options
    case historical
    
    var path: String{
        switch self {
        case .portfolio:
            return "/portfolios"
        case .options:
            return "/options"
        case .historical:
            return "historical_data"
        }
    }
    
    var parameters: Parameters?{
        switch self {
        default:
            return nil
        }
    }
        
        var method: HTTPMethod{
            switch  self {
            case .historical, .options, .portfolio:
                return .get
            }
        }
    }

