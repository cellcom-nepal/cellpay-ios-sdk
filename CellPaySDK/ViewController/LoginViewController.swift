//
//  LoginViewController.swift
//  CellPaySDK
//
//  Created by CellPay on 2/12/21.
//  Copyright © 2021 CellPay. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: TKTransitionSubmitButton!
    @IBOutlet weak var pinNumberTF: SkyFloatingLabelTextField!
    @IBOutlet weak var mobileNumberTF: SkyFloatingLabelTextField!
    var cellPayArguments: CellPayPaymentArguments?
    var delegate:PaymentProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTapAround()
        self.setupView()
        self.setupLanguageForSDK()
    }
    
    func hideKeyboardOnTapAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        if mobileNumberTF.text?.isEmpty ?? true  || mobileNumberTF.text?.count ?? 0 < 10{
            mobileNumberTF.errorMessage = StringConstants.sharedInstance.invalidNumber
        }
            
        else if pinNumberTF.text?.count ?? 0 < 6 || pinNumberTF.text?.isEmpty ?? true {
            pinNumberTF.errorMessage = StringConstants.sharedInstance.invalidPin
        }
            
        else {
            mobileNumberTF.errorMessage = ""
            pinNumberTF.errorMessage = ""
            self.callLogin()
            print("button was clicked")
        }
    }
    
}

extension LoginViewController {
    
    func getData(requiredData: CellPayPaymentArguments,delegate:PaymentProtocol) {
        self.cellPayArguments = requiredData
        self.delegate = delegate
    }
}

extension LoginViewController {
    
    private func callLogin() {
        self.loginButton.startLoadingAnimation()
        let apiCalling = ApiCalling()
        apiCalling.userLogin(userName:mobileNumberTF.text ?? "",password:pinNumberTF.text ??          "",completion: { (status) in
            switch status {
            case .success(let result):
                print(result)
                self.getBankAccount()
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.loginButton.returnToOriginalState()
                    
                }
                
                
            }
        })
    }
    
    private func getBankAccount() {
        let apiCalling = ApiCalling()
        apiCalling.getCellPayBankAccoutList { (status) in
            switch status {
            case .success(let response):
                DispatchQueue.main.async {
                    self.loginButton.returnToOriginalState()
                    CellPaySDKInitialize.performSegueToMerchantTransactionDetailVC(caller: self, merchantDetailList: response.payload.memberDetailsList, requiredArguments: self.cellPayArguments!, delegate: self.delegate!)
                }
                
                //self.callPayMerchantmemberPayment()
                print(response)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loginButton.returnToOriginalState()
                    
                }
                print(error)
                
            }
        }
    }
}

extension LoginViewController:UITextFieldDelegate {
    
    private func setupView(){
        self.loginButton.layer.cornerRadius = 22.5
        self.mobileNumberTF.delegate = self
        self.pinNumberTF.delegate = self
        
    }
    
    private func  setupLanguageForSDK() {
        if UserDefaults.standard.object(forKey: currentLanguageType) != nil {
            StringConstants.sharedInstance.setupLanguage(whichlanguage: LanguageType.nepali)
        }else {
            StringConstants.sharedInstance.setupLanguage(whichlanguage: LanguageType.english)
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == mobileNumberTF {
            mobileNumberTF.errorMessage = ""
        }
        else if textField == pinNumberTF {
            pinNumberTF.errorMessage = ""
        }
    }
}
