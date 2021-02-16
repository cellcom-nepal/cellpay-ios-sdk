//
//  StringConstants.swift
//  CellPaySDK
//
//  Created by CellPay on 2/12/21.
//  Copyright © 2021 CellPay. All rights reserved.
//

import Foundation
let currentLanguageType         = "cuurentLanguageType"
class StringConstants: NSObject {
    var invalidPin:String!
    var invoiceNumber: String!
    var invalidNumber:String!
    var invalidOTP:String!
    var missingPin:String!
    var confirmPin:String!
    var logIn:String!
    var pinPlaceholder:String!
    var submit:String!
    var mobileNumber:String!
    var pin:String!
    var pinConfrim:String!
    var acceptTermsCondition:String!
    var payment:String!
    var chooseLanguage:String!
    var selectAccount:String!
    var selectBankFrom:String!
    var selectBankTo:String!
    var selectAccountNumber:String!
    var enterAmountToSend:String!
    var enterAmount:String!
    var selectBank:String!
    var enterAccountNumber:String!
    var addAccount:String!
    var sessionExpired:String!
    var currentAppLang           = LanguageType.english
    
    class var sharedInstance: StringConstants {
        struct Static {
            static let instance: StringConstants = StringConstants()
        }
        return Static.instance
    }
    func setupLanguage(whichlanguage:LanguageType)  {
        
        if whichlanguage == .nepali {
            currentAppLang   = whichlanguage
            UserDefaults.standard.setValue(LanguageType.nepali.rawValue, forKey:currentLanguageType)
            setNepali()
        }else {
            UserDefaults.standard.removeObject(forKey: currentLanguageType)
            currentAppLang   = whichlanguage
            setEnglish()
        }
    }
    func setNepali()  {
        invalidPin               = "कृपयाआफ़्नो सहि ६ अङ्कको पिन  राख्नुहोस्"
        invalidNumber            = "कृपया आफ़्नो १० अङ्कको मोबाइल नम्बर लेख्नुहोस्"
        invalidOTP               = "तपाईको मोबाइल नम्बरमा पठाइएका ६ अङ्कको ओटीपी राख्नुहोस्"
        missingPin               = "कृपया आफ़्नो ६ अङ्कको पिन  राख्नुहोस्"
        confirmPin               = "कृपया आफ्नो पिन पुष्टि गर्नुहोस्"
        logIn                       = "लग-इन"
        pinPlaceholder              = "६ अङ्कको पिन  राख्नुहोस्"
        submit                      =  "बुझाउनुहोस्"
        mobileNumber                = "मोबाइल नम्बर"
        pin                         = "पिन"
        pinConfrim                  = "पुन:पिन पुष्टि गर्नुहोस्"
        acceptTermsCondition            = "कृपया सर्तहरू स्वीकार गर्नुहोस्।"
        payment                = "भुक्तानी"
        chooseLanguage  =     "भाषा छान्नुहोस्"
        selectAccount              =  "भुक्तानी गर्ने खाता छान्नुहोस्"
        selectBankFrom              = "बाट"
        selectBankTo                = "लाई"
        selectAccountNumber        = " डेबिट गर्ने खाता नम्बर चयन गर्नुहोस्"
        enterAmountToSend          =  "पठाउन चाहेको रकम राख्नुहोस्"
        enterAmount = "रकम राख्नुहोस्"
        selectBank              = "बैंक छान्नुहोस्"
        enterAccountNumber      = "खाता नम्बर राख्नुहोस्"
        addAccount              = "खाता थप्नुहोस्"
        sessionExpired = "सत्र समाप्त भयो"
    }
    func setEnglish()  {
        invoiceNumber = "Please enter invoice number"
        invalidPin               = "Please enter a valid 6 digits PIN"
        invalidNumber            = "Please enter valid mobile number"
        invalidOTP               = "Please enter six digits OTP, which we sent on your mobile number"
        missingPin               = "Please enter your  6 digit PIN"
        confirmPin               = "Please Confirm Your PIN"
        logIn                       = "Log In"
        pinPlaceholder              = "Enter 6 Digit PIN"
        submit                      =  "Submit"
        mobileNumber                = "Mobile Number"
        pin                         = "PIN"
        pinConfrim                  = "Confirm PIN"
        acceptTermsCondition            = "Please accept our terms & conditions"
        payment                = "Payment"
        chooseLanguage  =     "Choose Language"
        selectAccount              =  "Select Bank to Debit"
        selectBankFrom              = "Select Bank From"
        selectBankTo                = "Select Bank To"
        selectAccountNumber        = "Select Account Number to Debit"
        enterAmountToSend          =  "Enter Amount to Send"
        enterAmount = " Please enter Amount"
        selectBank              = "Select Bank"
        enterAccountNumber      = "Enter Account Number"
        addAccount              = "Add Account"
        sessionExpired = "Session Expired"
    }
}
