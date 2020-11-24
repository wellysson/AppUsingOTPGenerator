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
        let userId = "05111620656"
        let device_id = "myphone"
        let public_key = "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7QMQLb8nBZ5qKgBMNj3y\njlN1Qz8UAWcHnNzuKFF6yNoryWt7wDxt3eDYzqVfN5wK2r2xCaxNSO2AFeXShbOY\neIcxAOauRsBIAHkhlrr62Z8m5CXsaX9FmwQ2wHo6nlJ3eKso/qH5vfDJJ/JLtlmh\nzOoe1CxGj86Cjs2wvTgtcT6MR2+1LzHllcqSbsd23LPgodYmuAjKjrMzJAIyojCS\nZD2MbtMyXACaaIwmRJm3DuRRrsN0ZdSS/Ata/WWMu1g94yVIrMbvF3ikkw6KVEdD\nECYju6wp56hv2F6GkyHWauMsXFhFHqZaYBtrKJru4Ts+52FxFmIeT33DEcJGjkwX\nGwIDAQAB\n-----END PUBLIC KEY-----"
        let private_Key = "-----BEGIN RSA PRIVATE KEY-----\nMIIEowIBAAKCAQEA7QMQLb8nBZ5qKgBMNj3yjlN1Qz8UAWcHnNzuKFF6yNoryWt7\nwDxt3eDYzqVfN5wK2r2xCaxNSO2AFeXShbOYeIcxAOauRsBIAHkhlrr62Z8m5CXs\naX9FmwQ2wHo6nlJ3eKso/qH5vfDJJ/JLtlmhzOoe1CxGj86Cjs2wvTgtcT6MR2+1\nLzHllcqSbsd23LPgodYmuAjKjrMzJAIyojCSZD2MbtMyXACaaIwmRJm3DuRRrsN0\nZdSS/Ata/WWMu1g94yVIrMbvF3ikkw6KVEdDECYju6wp56hv2F6GkyHWauMsXFhF\nHqZaYBtrKJru4Ts+52FxFmIeT33DEcJGjkwXGwIDAQABAoIBAQCGJ/24Z0LHQ2wE\naja5XUc2mLb/YW0JfjAo8kU8PSKrHhM658QchBgMR4FxNto2t/TM7CKRvx3f8c9W\nlcgcNhRP5PYv9GMhWSVoXyhMEXp8REHXUkAHVysnG7OCL62OgE9v1jJWL4kVon26\nRsPka8fSHZNltcobDGGKQ5OPB4VxW0dMChHg2YKp8GUHFzQjS13FE08z5HJ2GsTv\nRpJB5OS7R92G0mq1yMO7/nX1kfnx+Ko6wG/iBxCJDh9kdKwDqiov4ExtRIEpMTnt\nAiM6rS7YZAlsW/Ynrxbp7p2w8oXaNOwkkszFbM0cgjxjMzW7diR1aAOi6+Q3LJWL\naOuMWGgBAoGBAPxLgwlJyLHG0X2Dk9Q23sGO3iPXephw1d5j9yv8tACpH5ErzLku\ngknc3xykZdlkm0e0GqrAqA7wi3WqUDJ6ovsETJanXYoO+NArPOzgB58BE76gfeuz\nWi7KmdBSnlWbJ70s8ZrulAaafRxIPqwP1/ZjZcFaJr8JJpP7BYIfP3ubAoGBAPB+\nGIVlXCYl9bidRhuXbTZebkrt5AAivfOuIaaUw6/RcdZIDLOIAr+Xa4wcJS8R5JYh\nArQY15aJ73fiYCgC1RNuwcEcGIaPd3jFsyN3VmBHsgtVxkTN28Md9iAzCpsO0N3P\n19UHGKieJitI7WWNkMZ52WUg/W9Dkxt9b19r/EqBAoGAB1hbdEXFpgdXygOuphsC\n2TfDl9+KHi4Ky/K1G3677tj9pkhUKYAFIwlfJYJTxMR9ENVZgWcifWzbYo2W0CFp\n5Uz2vdwZiQ9uhwD7QRo0nph1brNVdys9kOctGzeMjIl72rIYRp5ziM2unsgrqu67\nJt019S8euakWinBgdK1cN8kCgYAv01O7C3o01+2yxgwQJqAAZO0YF5D0+fO+hw2I\nHCOCTmuOCowEE/M/+LPZjCtU3gEQXgY0nJAbDtlBhRJMQqvvDmKXraeu8s72hJJo\nZi4WPYvJt0gTnMCsX8P3iU79oQemZNPuOFgOCE1c5EbZoDp/TfIOq23a95xEpkBE\nwKvOgQKBgEX/VpVhjU0OguW3IbaTlGbr9AyJkHTXClJg31oQxDKT1kXOooE+++lm\nrhU3mpVFv5wC9nBzf6uDQTp5kIZe7dVhPrzCz2l7qOM6MMA7nBB6JfePkB7FvbTW\n5r6OIAiFMd4A2OMyok5Jq8MTylfBtDdseaSVQyQbo6H2aLwDT4O+\n-----END RSA PRIVATE KEY-----"
        let os_name = "iOS"
        let os_version = "10.3"
        let app_version = "1234"
        
        OTPHelper.otp = OTPGenerator(userId: userId, device_id: device_id, public_key: public_key, private_Key: private_Key, os_name: os_name, os_version: os_version, app_version: app_version)
    }
}
