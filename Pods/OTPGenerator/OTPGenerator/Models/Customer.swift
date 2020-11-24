//
//  Customer.swift
//  OTP_Generator
//
//  Created by Wellysson Avelar on 08/11/20.
//

import Foundation
import ObjectMapper

class Customer: Mappable {
    var customer_id: String?
    var device_id: String?
    var registration: Registration?
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.customer_id <- map["customer_id"]
        self.device_id <- map["device_id"]
        self.registration <- map["registration"]
    }
}

class Registration: Mappable {
    var public_key: String?
    var device_id: String?
    var os_name: String?
    var os_version: String?
    var app_version: String?
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.public_key <- map["public_key"]
        self.device_id <- map["device_id"]
        self.os_name <- map["os_name"]
        self.os_version <- map["os_version"]
        self.app_version <- map["app_version"]
    }
}
