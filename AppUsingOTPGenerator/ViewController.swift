//
//  ViewController.swift
//  AppUsingOTPGenerator
//
//  Created by Wellysson Avelar on 16/11/20.
//

import UIKit
import SwiftyRSA

class ViewController: UIViewController {
    
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    
    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var validatorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let keyPair = try SwiftyRSA.generateRSAKeyPair(sizeInBits: 2048)
            print(try keyPair.publicKey.pemString())
            print(try keyPair.privateKey.pemString())
            
            let text = "Teste texto criptografia"
            print("Texto Limpo: \(text)")
            let enctypt = self.encryptText(publicKeyString: try keyPair.publicKey.pemString(), text: text)
            print(enctypt)
            print("Texto decriptado: \(self.getDecrypt(priateKeyString: try keyPair.privateKey.pemString(), base64Encoded: enctypt))")
            
            
            print("OK")
        } catch {
        }
        
        
        
        
        self.startOTPGenerator()
    }
    
    func encryptText(publicKeyString: String, text: String) -> String {
        var base64String = ""
        
        do {
            let publicKey = try PublicKey(pemEncoded: publicKeyString)
            let clear = try ClearMessage(string: text, using: .utf8)
            let encrypted = try clear.encrypted(with: publicKey, padding: .PKCS1)

            // Then you can use:
//            let data = encrypted.data.
            base64String = encrypted.base64String
        } catch {
            print(error)
        }
        
        return base64String
    }
    
    func getDecrypt(priateKeyString: String, base64Encoded: String) -> String {
        do {
            let privateKey = priateKeyString
            
            let privateKeyObj = try PrivateKey(pemEncoded: privateKey)
            let encrypted = try EncryptedMessage(base64Encoded: base64Encoded)
            let clear = try encrypted.decrypted(with: privateKeyObj, padding: .PKCS1)

            let string = try clear.string(encoding: .utf8)
            
            return string
        } catch let error {
            print("erro decrypt:" + error.localizedDescription)
        }
        
        return ""
    }
    
//    func sha256(data : Data) -> Data {
//        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
//        data.withUnsafeBytes {
//            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
//        }
//        return Data(hash)
//    }
    
    private func startOTPGenerator() {
        OTPHelper.otp?.startActivation(completion: { [weak self] registerSuccess in
            guard let self = self else { return }
            if registerSuccess {
                self.setKeyAndTimer()
            } else {
                print("Erro ao iniciar OTPGenerator")
            }
        })
    }
    
    func validateOTP(otp: String) {
        OTPHelper.otp?.validation(otp: otp, onValidate: { [weak self] isValid in
            guard let self = self else { return }
            
            if isValid {
                self.validatorLabel.text = "Valido"
                self.validatorLabel.textColor = .blue
            } else {
                self.validatorLabel.text = "Inválido"
                self.validatorLabel.textColor = .red
            }
        })
    }
    
    func setKeyAndTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            let timerToReset = OTPHelper.otp?.getTimeToEndValidate() ?? 0
            self.countdownLabel.text = "\(timerToReset)"
            self.keyLabel.text = OTPHelper.otp?.getCurrentKey()
            if self.keyLabel.text != self.keyTextField.text && timerToReset == 30 {
                self.keyTextField.text = OTPHelper.otp?.getCurrentKey()
                self.validatorLabel.text = "-"
                self.validatorLabel.textColor = .white
            }
        }
    }
    
    @IBAction func ValidateAction(sender: Any) {
        let otp = self.keyTextField.text ?? ""
        
        self.validateOTP(otp: otp)
    }
}

