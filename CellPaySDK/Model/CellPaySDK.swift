//
//  CellPaySDK.swift
//  CellPaySDK
//
//  Created by esewa on 2/11/21.
//  Copyright © 2021 esewa. All rights reserved.
//

import Foundation
import UIKit

public class CellPaySDKInitialize {
    public static func presentFirstViewControllerOn(caller: UIViewController,requiredArgument: CellPayPaymentArguments,delegate:PaymentProtocol,islive:Bool) {
        WebService.isLive = islive
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle(for: LoginViewController.self))
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginVC.getData(requiredData: requiredArgument, delegate: delegate)
        loginVC.modalPresentationStyle = .overFullScreen
        caller.present(loginVC, animated: true, completion: nil)
    }
    static func performSegueToMerchantTransactionDetailVC(caller: UIViewController,merchantDetailList:[MemberDetailsList],requiredArguments: CellPayPaymentArguments,delegate:PaymentProtocol) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle(for: MerchantTransactionDetailVC.self))
        let merchantTransactionVC = storyBoard.instantiateViewController(withIdentifier: "MerchantTransactionDetailVC") as! MerchantTransactionDetailVC
        
        merchantTransactionVC.modalPresentationStyle = .overFullScreen
        merchantTransactionVC.getDataForMerchant(merchantBankList: merchantDetailList, requiredArguments: requiredArguments, delegate: delegate)
        caller.present(merchantTransactionVC, animated: true, completion: nil)
    }
    static func performSegueToConfirmPaymentVC(caller: UIViewController,requiredArguments: CellPayPaymentArguments,userName: String,accountNo: String,paymentDescription:String,otpEnable:Bool,delegate:PaymentProtocol) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle(for: ConfirmPaymentVC.self))
        let confirmPaymentVC = storyBoard.instantiateViewController(withIdentifier: "ConfirmPaymentVC") as! ConfirmPaymentVC
        //  let vc = storyboard.instantiateInitialViewController()!
        confirmPaymentVC.modalPresentationStyle = .popover
        confirmPaymentVC.getRequiredArguments(requiredArguments: requiredArguments, userName: userName,accountNumber:accountNo, paymentDescription: paymentDescription, otpEnable: otpEnable, delegate: delegate)
        caller.present(confirmPaymentVC, animated: true, completion: nil)
    }
}
