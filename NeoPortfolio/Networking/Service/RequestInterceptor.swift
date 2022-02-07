//
//  RequestInterceptor.swift
//  RBT
//
//  Created by User on 22/07/2021.
//

import Foundation
import Alamofire
import UIKit
import ObjectMapper

class RequestInterceptor: Alamofire.RequestInterceptor {
    
    private var isRefreshing = false
    let retryLimit = 5
    let failedRetryLimit = 2
    let retryDelay: TimeInterval = 1
    private var requestsToRetry: [((RetryResult) -> Void)] = []
    private let lock = NSLock()
    
    
    func adapt( _ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var urlRequest = urlRequest
        
        print(urlRequest)
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        if let response = request.task?.response as? HTTPURLResponse{
            let statusCode = response.statusCode
            
            lock.lock() ; defer { lock.unlock() }
            let urlString = (response.url?.absoluteString) ?? ""
            
            print("error: \(error)")
            print(request.retryCount)
            
            //        return
            //        if let afError = error.asAFError {
            //            print(afError)
            //
            //        }
            
            switch statusCode {
            case 401:
                
                break
            case 500...599:
                
                if request.retryCount < failedRetryLimit {
                    completion(.retryWithDelay(retryDelay))
                }else{
                    completion(.doNotRetry)
                }
                break
            default:
                completion(.doNotRetry)
                break
            }
            
        }else{
            completion(.doNotRetry)
        }
    }
}

