//
//  RegistrationService.swift
//  OTPGenerator
//
//  Created by Wellysson Avelar on 10/11/20.
//

import Foundation
import Alamofire
import ObjectMapper

public class RegistrationService {
    static var urlBase = "https://yawning-small-neontetra.gigalixirapp.com/api"
    
    static func registrationStart(customer: Customer, completion: ((BaseResponse) -> Void)?) {
        let parameters = customer.toJSON()
        let url = "\(self.urlBase)/activations"
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            
            if let json = response.result.value as? [String: Any] {
                if let baseResponse = Mapper<BaseResponse>().map(JSON: json) {
                    completion?(baseResponse)
                }
            } else {
                let baseResponse = BaseResponse()
                completion?(baseResponse)
            }
        }
    }
    
    static func registrationFinish(userId: String, device_id: String, otp: String, completion: ((BaseResponse) -> Void)?) {
        var parameters = [String: Any]()
        parameters["device_id"] = device_id
        parameters["otp"] = otp
        let url = "\(self.urlBase)/activations/\(userId)"
        
        Alamofire.request(url, method: .put, parameters: parameters).responseJSON { response in
            
            if let json = response.result.value as? [String: Any] {
                if let baseResponse = Mapper<BaseResponse>().map(JSON: json) {
                    completion?(baseResponse)
                }
            } else {
                let baseResponse = BaseResponse()
                completion?(baseResponse)
            }
        }
    }
    
    static func validation(userId: String, device_id: String, otp: String, completion: ((BaseResponse) -> Void)?) {
        var parameters = [String: Any]()
        parameters["device_id"] = device_id
        parameters["otp"] = otp
        let url = "\(self.urlBase)/activations/\(userId)/check"
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            
            if let json = response.result.value as? [String: Any] {
                if let baseResponse = Mapper<BaseResponse>().map(JSON: json) {
                    completion?(baseResponse)
                }
            } else {
                let baseResponse = BaseResponse()
                completion?(baseResponse)
            }
        }
    }
    
    static func getStatus(userId: String, completion: ((BaseResponse) -> Void)?) {
        let url = "\(self.urlBase)/status/myphone/05111620656"
        
        Alamofire.request(url, method: .get).responseJSON { response in
            
            if let json = response.result.value as? [String: Any] {
                if let baseResponse = Mapper<BaseResponse>().map(JSON: json) {
                    completion?(baseResponse)
                }
            } else {
                let baseResponse = BaseResponse()
                completion?(baseResponse)
            }
        }
    }
}

