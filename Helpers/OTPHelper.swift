//
//  OTPHelper.swift
//  AppUsingOTPGenerator
//
//  Created by Wellysson Avelar on 16/11/20.
//

import Foundation
import OTPGenerator

public class OTPHelper: NSObject {
    public static var otp: OTPGenerator?
    
    public static func createOTPGenerator() {
        let userId = "43997949093"
        
        OTPHelper.otp = OTPGenerator(userId: userId)
    }
}
