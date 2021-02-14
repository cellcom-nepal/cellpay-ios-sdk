//
//  MerchantTransactionDetailVC.swift
//  CellPaySDK
//
//  Created by esewa on 2/12/21.
//  Copyright © 2021 esewa. All rights reserved.
//

import Foundation
import UIKit

class MerchantTransactionDetailVC: UIViewController {
    
    @IBOutlet weak var selectBankToDebitTf: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var invoiceNumberTF: SkyFloatingLabelTextField!
    @IBOutlet weak var totalAmountTF: SkyFloatingLabelTextField!
    @IBOutlet weak var descriptionTF: SkyFloatingLabelTextField!
    @IBOutlet weak var accountNumberTF: SkyFloatingLabelTextField!
    @IBOutlet weak var accountNumberView: UIView!
    @IBOutlet weak var nextButton: TKTransitionSubmitButton!
    @IBOutlet weak var nextButtonView: UIView!
    var memberDetailList:[MemberDetailsList] = []
    var requiredArguments: CellPayPaymentArguments?
    var userName: String?
    var accountNo: String?
    var delegate:PaymentProtocol?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.setupView()
        self.fetchData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getDataForMerchant(merchantBankList: [MemberDetailsList],requiredArguments:CellPayPaymentArguments,delegate:PaymentProtocol) {
        self.memberDetailList = merchantBankList
        self.requiredArguments = requiredArguments
        self.delegate = delegate
    }
    
    @IBAction func selctBankButtonClicked(_ sender: Any) {
        selectBankToDebitTf.errorMessage = ""
        accountNumberTF.errorMessage = ""
        let alert = UIAlertController(title: "Select Bank Account to Debit", message: "", preferredStyle: .actionSheet)
        for data in memberDetailList {
            let selectAction = UIAlertAction(title: data.memberName, style: .destructive) { (action) in
                self.selectBankToDebitTf.text = data.memberName
                self.userName = data.userName
                self.accountNo = data.accountNo
                let intLetters = data.accountNo.suffix(4)
                let stars = String(repeating: "*", count: data.accountNo.count - 3)
                let result = stars + intLetters
                self.accountNumberTF.text = String(result)
                
            }
            alert.addAction(selectAction)
        }
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func selectBankAccountNumberButtonClicked(_ sender: Any) {
    }
    
    @IBAction func bacButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if invoiceNumberTF.text?.isEmpty ?? true{
            invoiceNumberTF.errorMessage = StringConstants.sharedInstance.invoiceNumber
        }
        else if totalAmountTF.text?.isEmpty ?? true  {
            totalAmountTF.errorMessage = StringConstants.sharedInstance.enterAmount
        }
        else if selectBankToDebitTf.text?.isEmpty ?? true {
            selectBankToDebitTf.errorMessage = StringConstants.sharedInstance.selectAccount
        }
        else if accountNumberTF.text?.isEmpty ?? true  {
            accountNumberTF.errorMessage = StringConstants.sharedInstance.selectAccountNumber
        }
        else {
            
            invoiceNumberTF.errorMessage = ""
            totalAmountTF.errorMessage = ""
            selectBankToDebitTf.errorMessage = ""
            accountNumberTF.errorMessage = ""
            self.callPayMerchantmemberPayment()
            
        }
        
    }
}

extension MerchantTransactionDetailVC {
    
    func callPayMerchantmemberPayment(){
        self.nextButton.startLoadingAnimation()
        let customValues:[InternalCustomValues] = [
            SelectBankInternalValue(fieldID: "35",value: userName ?? ""),
            PaymentMethodInternalValue(fieldID: "15", value: "Account"),
            AccountNumberInternalValue(fieldID: "14", value: accountNo ?? ""),
            InvoiceNumberInternalValue(fieldID: "99", value: self.requiredArguments?.invoiceID ?? "")
        ]
        
        let memberParams =  MemberBasePaymentSP(transferTypeID: "50", amount: String(self.requiredArguments?.price ?? 0), toMemberPrincipal: requiredArguments?.mobileNumber ?? "", basePaymentSPDescription: descriptionTF.text ?? "Pay Merchant", currencyID: "1", webRequest: true, customValues: customValues.map(BasePaymentCustomValues.init), isOtpEnable: false)
        let systemParams = SystemBasePaymentSP(transferTypeID: "174", amount: String(self.requiredArguments?.price ?? 0), basePaymentSPDescription: descriptionTF.text ?? "Pay Merchant", currencyID: "1", webRequest: true, customValues:        customValues.map(BasePaymentCustomValues.init), isOtpEnable: false)
        let sendParams: [String: Any]?
        if self.requiredArguments?.paymentType == 1{
            sendParams = try? memberParams.toDictionary()
        }
        else {
            sendParams = try? systemParams.toDictionary()
        }
        
        print(send)
        let apiCalling = ApiCalling()
        apiCalling.callMemberPayments(parameters: sendParams) { (status) in
            print(sendParams as Any)
            switch status {
            case .success(let response):
                DispatchQueue.main.async {
                    self.nextButton.returnToOriginalState()
                    CellPaySDKInitialize.performSegueToConfirmPaymentVC(caller: self, requiredArguments: self.requiredArguments!, userName: self.userName ?? "", accountNo: self.accountNo ?? "", paymentDescription: self.descriptionTF.text ?? "Pay Merchant", otpEnable: response.payload.doPaymentResult.isOtpEnable, delegate: self.delegate!)
                    
                }
                print(response)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.nextButton.returnToOriginalState()
                }
                print(error)
                
            }
        }
        
    }
}

extension MerchantTransactionDetailVC: UITextFieldDelegate {
    
    private func setupView(){
        self.nextButton.layer.cornerRadius = 22.5
        self.invoiceNumberTF.delegate = self
        self.totalAmountTF.delegate = self
        self.descriptionTF.delegate = self
        self.selectBankToDebitTf.delegate = self
        self.accountNumberTF.delegate = self
    }
    
    private func fetchData() {
        self.invoiceNumberTF.text = requiredArguments?.invoiceID
        self.totalAmountTF.text = String(requiredArguments?.price ?? 0)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == invoiceNumberTF {
            invoiceNumberTF.errorMessage = ""
        }
        else if textField == totalAmountTF {
            totalAmountTF.errorMessage = ""
        }
        else if textField == selectBankToDebitTf {
            selectBankToDebitTf.errorMessage = ""
        }
        else if textField == accountNumberTF {
            accountNumberTF.errorMessage = ""
        }
    }
}
