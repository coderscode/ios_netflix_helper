//
//  WebService.swift
//  SPARE
//
//  Created by Prakash Kotwal on 11/21/18.
//  Copyright © 2018 SPARE. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class WebService: NSObject {
    
    func sendData(showLoader: Bool = true, loadingMessage: String, router : Router, completionHandler: @escaping ((ResponseModel) -> Void))
    {
        if !isNetWorkAvailable() {
            let handlerValue = NSMutableDictionary()
            handlerValue["response_code"] = "503"
            handlerValue["response_msg"] = "No Internet Connection"
            handlerValue["response_data"] = [:]
            print("response failure:- \(handlerValue)")
            let responseModel   =   ResponseModel(response: handlerValue as NSDictionary)
            return completionHandler(responseModel)
        }
        
        if showLoader {
            self.showLoader()
        }
        Alamofire
            .request(router)
            .validate(statusCode: 200..<505)
            .responseString(completionHandler: { (response) in
                //929-TnmClq7pnRNtdqoX
                //929-TnmClq7pnRNtdqoX
//                print("response string:- \(response)")
            })
            .responseJSON
            { response in
                self.hideLoader()
                
                switch response.result {
                case .success(let value):
//                    print("response success:- \(value) and url:- \(router.urlRequest)")
                    let handlerValue = NSMutableDictionary()
                    handlerValue["status"] = "200"
                    handlerValue["message"] = "Success"
                    handlerValue["data"] = value
                    let responseModel   =   ResponseModel(response: handlerValue as NSDictionary)
//                    let responseModel   =   ResponseModel(response: value as! NSDictionary)
                    completionHandler(responseModel)
                    
                case .failure(let error):
                    let handlerValue = NSMutableDictionary()
                    handlerValue["status"] = "Error"
                    handlerValue["message"] = error.localizedDescription
                    handlerValue["data"] = [:]
                    print("response failure:- \(handlerValue)")
                    let responseModel   =   ResponseModel(response: handlerValue as NSDictionary)
                    return completionHandler(responseModel)
                    
                }
        }
    }
    
    
    func showLoader()
    {
        SVProgressHUD.show()
    }
    
    func hideLoader()
    {
        SVProgressHUD.dismiss()
    }
    
    func isNetWorkAvailable()->Bool
    {
        let reachability:NetworkReachabilityManager = NetworkReachabilityManager.init()!
        
        return reachability.isReachable
    }
}
