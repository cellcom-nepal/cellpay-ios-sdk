//
//  ConfirmPaymentVC.swift
//  CellPaySDK
//
//  Created by esewa on 2/12/21.
//  Copyright © 2021 esewa. All rights reserved.
//

import Foundation
import UIKit

class ConfirmPaymentVC: UIViewController {
    
    @IBOutlet weak var confirmButtonView: UIView!
    @IBOutlet weak var otpTF: SkyFloatingLabelTextField!
    @IBOutlet weak var enterOtpView: UIView!
    @IBOutlet weak var enterPinTF: SkyFloatingLabelTextField!
    @IBOutlet weak var enterPinView: UIView!
    @IBOutlet weak var amountTF: SkyFloatingLabelTextField!
    @IBOutlet weak var amountTFView: UIView!
    @IBOutlet weak var confirmButton: TKTransitionSubmitButton!
    @IBOutlet weak var appliedFeeLabel: UILabel!
    @IBOutlet weak var closeButtonClicked: UIButton!
    var delegate: PaymentProtocol?
    var requiredArguments: CellPayPaymentArguments?
    var userName: String?
    var accountNumber: String?
    var otpEnable:Bool?
    var paymentDescription: String?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.setupView()
        self.fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmPaymentButtonClicked(_ sender: Any) {
        if amountTF.text?.isEmpty ?? true{
            amountTF.errorMessage = StringConstants.sharedInstance.enterAmount
        }
        else if enterPinTF.text?.isEmpty ?? true || enterPinTF.text?.count ?? 0 < 6{
            enterPinTF.errorMessage = StringConstants.sharedInstance.invalidPin
        }
//        if otpEnable == true {
//            if otpTF.text?.isEmpty ?? true  {
//                otpTF.errorMessage = StringConstants.sharedInstance.invalidOTP
//            }
//        }
        else {
            enterPinTF.errorMessage = ""
            otpTF.errorMessage = ""
            amountTF.errorMessage = ""
            self.callConfirmPayMerchantMemberPayment()
        }
        
    }
    
}

extension ConfirmPaymentVC {
    
    func callConfirmPayMerchantMemberPayment(){
        self.confirmButton.startLoadingAnimation()
        let customValues:[InternalCustomValues] = [
            SelectBankInternalValue(fieldID: "35",value: userName ?? ""),
            PaymentMethodInternalValue(fieldID: "15", value: "Account"),
            AccountNumberInternalValue(fieldID: "14", value: accountNumber ?? ""),
            InvoiceNumberInternalValue(fieldID: "99", value: self.requiredArguments?.invoiceID ?? "")
        ]
        let memberParams = ConfirmMemberBasePaymentSP(transferTypeID: "50", amount: String(self.requiredArguments?.price ?? 0), toMemberPrincipal: self.requiredArguments?.mobileNumber ?? "", basePaymentSPDescription: self.paymentDescription ?? "Pay Merchant", currencyID: "1",transactionPin: enterPinTF.text,otp: otpTF.text ?? "", webRequest: true, customValues: customValues.map(BasePaymentCustomValues.init), isOtpEnable: false)
        
        let systemParams = SystemBasePaymentSP(transferTypeID: "174", amount: String(self.requiredArguments?.price ?? 0), basePaymentSPDescription: "Pay Merchant", currencyID: "1", webRequest: true, customValues:        customValues.map(BasePaymentCustomValues.init), isOtpEnable: false)
        
        let sendParams: [String: Any]?
        if self.requiredArguments?.paymentType == 1{
            sendParams = try? memberParams.toDictionary()
        }
        else {
            sendParams = try? systemParams.toDictionary()
        }
        let apiCalling = ApiCalling()
        apiCalling.callConfirmMemberPayments(parameters: sendParams) { (status) in
            switch status {
            case .success(let response):
                DispatchQueue.main.async {
                    self.confirmButton.returnToOriginalState()
                    let alert = UIAlertController(title: "Sucessfull", message: "Payment Successfull", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        if self.delegate != nil {
                            self.delegate?.sucess(paymentResponse: response, cellPayArguments: self.requiredArguments!)
                        }
                        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                print(response)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.confirmButton.returnToOriginalState()
                    let alert = UIAlertController(title: "Transaction failed", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        if self.delegate != nil {
                            self.delegate?.failed(cellPayArguments: self.requiredArguments!)
                        }
                        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                print(error)
                
            }
        }
        
    }
}

extension ConfirmPaymentVC {
    
    func getRequiredArguments(requiredArguments: CellPayPaymentArguments,userName: String,accountNumber: String,paymentDescription:String,otpEnable: Bool,delegate: PaymentProtocol) {
        self.requiredArguments = requiredArguments
        self.accountNumber = accountNumber
        self.userName = userName
        self.otpEnable = otpEnable
        self.paymentDescription = paymentDescription
        self.delegate = delegate
    }
}

extension ConfirmPaymentVC: UITextFieldDelegate {
    
    private func setupView(){
        self.confirmButton.layer.cornerRadius = 22.5
        self.enterPinTF.delegate = self
        self.amountTF.delegate = self
        self.otpTF.delegate = self
        if otpEnable == true {
            self.enterOtpView.isHidden = false
        }
        else {
            self.enterOtpView.isHidden = true
        }
        
    }
}

extension ConfirmPaymentVC {
    
    private func fetchData() {
        self.amountTF.text = String(requiredArguments?.price ?? 0)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == amountTF {
            amountTF.errorMessage = ""
        }
        else if textField == enterPinTF {
            enterPinTF.errorMessage = ""
        }
        else if textField == otpTF {
            otpTF.errorMessage = ""
        }
        
    }
}
