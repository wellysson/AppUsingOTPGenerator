//
//  OTPGenerator.swift
//  OTPGenerator
//
//  Created by Wellysson Avelar on 10/11/20.
//

import Foundation
import OneTimePassword
import Base32
import SwiftyRSA

public class OTPGenerator {
    
    let userId: String
    let device_id: String
    let public_key: String
    let private_Key: String
    let os_name: String
    let os_version: String
    let app_version: String
    
    var token: Token?


    public init(urlServiceBase: String? = nil, userId: String, device_id: String, public_key: String ,private_Key: String, os_name: String, os_version: String, app_version: String) {
        self.userId = userId
        self.device_id = device_id
        self.public_key = public_key
        self.private_Key = private_Key
        self.os_name = os_name
        self.os_version = os_version
        self.app_version = app_version
        
        if let urlBase = urlServiceBase {
            RegistrationService.urlBase = urlBase
        }
    }
}

//Services
extension OTPGenerator {
    public func startActivation(forceRegister: Bool = false, completion: ((_ registerSuccess: Bool) -> Void)?) {
        let customer = Customer()
        customer.customer_id = self.userId
        customer.device_id = self.device_id
        customer.registration = Registration()
        customer.registration?.public_key = self.public_key
        customer.registration?.device_id = self.device_id
        customer.registration?.os_name = self.os_name
        customer.registration?.os_version = self.os_version
        customer.registration?.app_version = self.app_version
        
        let otpRegisterKey: String = "OTP_KEY_\(self.userId)"
        
        if forceRegister == false, let otpKey: String = PreferencesManager.getObject(otpRegisterKey) {
            self.createToken(secret: otpKey)
            completion?(true)
        } else {
            RegistrationService.registrationStart(customer: customer, completion: { [weak self, completion, otpRegisterKey] baseResponse in
                guard let self = self else {
                    return
                }
                let secret = baseResponse.secret ?? ""

                if let secretDecript = self.getDecrypt(base64Encoded: secret) {
                    self.createToken(secret: secretDecript)
                    PreferencesManager.saveObject(otpRegisterKey, value: secretDecript)
                    if let token = self.token {
                        self.finishActivation(token: token, completion: { [completion] isValid in
                            completion?(isValid)
                        })
                    }
                }
            })
        }
    }
    
    public func validation(otp: String, onValidate: ((_ isValid: Bool) -> Void)?) {
        RegistrationService.validation(userId: self.userId, device_id: self.device_id, otp: otp, completion: { [onValidate] baseResponse in
            
            let isValid = baseResponse.status?.lowercased() == "ok"
            onValidate?(isValid)
        })
    }
    
    public func getStatus(completion: ((_ isON: Bool) -> Void)?) {
        RegistrationService.getStatus(userId: self.userId, completion: { [completion] baseResponse in
            
            let isOn = baseResponse.status?.lowercased() == "ok"
            completion?(isOn)
        })
    }
    
    func finishActivation(token: Token, completion: ((_ isValid: Bool) -> Void)?) {
        RegistrationService.registrationFinish(userId: self.userId, device_id: self.device_id, otp: token.currentPassword ?? "", completion: { [completion] baseResponse in
            
            let isValid = baseResponse.status?.lowercased() == "ok"
            
            completion?(isValid)
        })
    }
}

extension OTPGenerator {
    func createToken(secret: String) {
        let name = self.os_name
        let issuer = self.device_id
        let secretString = secret

        guard let secretData = MF_Base32Codec.data(fromBase32String: secretString),
            !secretData.isEmpty else {
            print("Invalid secret")
            self.token = nil
            return
        }

        guard let generator = Generator(
            factor: .timer(period: 30),
            secret: secretData,
            algorithm: .sha1,
            digits: 6) else {
            print("Invalid generator parameters")
            self.token = nil
            return
        }

        let token = Token(name: name, issuer: issuer, generator: generator)
        self.token = token
    }
    
    public func getCurrentKey() -> String? {
        return self.token?.currentPassword
    }

    public func getTimeToEndValidate() -> Int {
        let currentPassword = self.token?.currentPassword ?? ""
        var idDiferent = true
        var time = 0
        while idDiferent {
            do {
                let nextPassword = try self.token?.generator.password(at: Date().addingTimeInterval(TimeInterval(time)))
                                                              
                if currentPassword != nextPassword {
                    idDiferent = false
                } else {
                    time += 1
                }
            } catch {
            }
        }
        
        return time
    }
    
    func getDecrypt(base64Encoded: String) -> String? {
        do {
            let privateKey = self.private_Key
            
            let privateKeyObj = try PrivateKey(pemEncoded: privateKey)
            let encrypted = try EncryptedMessage(base64Encoded: base64Encoded)
            let clear = try encrypted.decrypted(with: privateKeyObj, padding: .PKCS1)

            let string = try clear.string(encoding: .utf8)
            
            return string
        } catch let error {
            print("erro decrypt:" + error.localizedDescription)
        }
        
        return nil
    }
}
