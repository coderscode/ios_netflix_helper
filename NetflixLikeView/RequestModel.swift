//
//  RequestModel.swift
//  SPARE
//
//  Created by ADMIN on 11/21/18.
//  Copyright © 2018 SPARE. All rights reserved.
//

import UIKit

class ResponseModel: NSObject {
    var status: String!
    var message: String!
    var data : AnyObject
    
    init(response : NSDictionary) {
        if response["data"] != nil{
            let responseData    =   response["data"] as! NSDictionary
            self.status  =   (responseData["status"] as? NSNumber)?.stringValue ?? ""
            self.message   =   responseData["message"] as? String ?? ""
            self.data  =   responseData//responseData["data"] as? AnyObject ?? [:] as AnyObject
        }else{
            self.status  =   response["status"] as? String ?? ""
            self.message   =   response["message"] as? String ?? ""
            self.data  =   response["data"] as? AnyObject ?? [:] as AnyObject
        }
    }
}
