//
//  baseResponse.swift
//  OTP_Generator
//
//  Created by Wellysson Avelar on 08/11/20.
//

import Foundation
import ObjectMapper

class BaseResponse: Mappable {
    var message: String?
    var secret: String?
    var status: String?
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.message <- map["message"]
        self.secret <- map["secret"]
        self.status <- map["status"]
    }
}
