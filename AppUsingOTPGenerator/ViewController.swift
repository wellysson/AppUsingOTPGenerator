//
//  ViewController.swift
//  AppUsingOTPGenerator
//
//  Created by Wellysson Avelar on 16/11/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    
    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var validatorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startOTPGenerator()
    }
    
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

