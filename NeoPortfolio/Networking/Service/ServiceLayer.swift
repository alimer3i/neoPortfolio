//
//  ServiceLayer.swift
//  RBT
//
//  Created by User on 22/07/2021.
//

import Foundation
import ObjectMapper
import Alamofire

class ServiceLayer {
    
    class func request<T: Mappable & Codable>(router: URLRequestBuilder, model: T.Type, completion: @escaping (Result<Array<T>, AFError>) -> ()) {
        
        do{
            APIManager.shared.sessionManager.request(
                try router.asURLRequest()
            ).validate().responseJSON { (response) in
                let result = response.result
                
                switch result{
                case .success(_):
                    guard let itemsData = response.data else {
                        completion(.failure(.explicitlyCancelled))
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let items = try decoder.decode([T].self, from: itemsData)
                        DispatchQueue.main.async {
                            completion(.success(items))
                        }
                    }catch {
                        completion(.failure(.explicitlyCancelled))
                    }
                    break
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                    break
                }
            }
        }catch{
            print(error.localizedDescription)
            completion(.failure(.explicitlyCancelled))
        }
    }
}


extension Array: Mappable {
    public mutating func mapping(map: Map) {
        
    }
    
    public init?(map: Map) {
        self.init()
    }
}
