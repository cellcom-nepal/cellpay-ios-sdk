## CellPay-SDK
![](https://cellpay.com.np/themes/ele/assets/img/CellPay.svg | width=150)

# Steps to add CellPay SdK and usage

- Add pod 'MyFramework',:git => 'https://github.com/cellcom-nepal/cellpay-ios-sdk' to your pod file and install pod file.

- Add Pay with CellPay Button with hex value (#193983), rgb(red:25,green:57,blue:131,alpha:1) to viewcontroller.

- After installing pod file  import CellPayButton to viewcontroller.

- Implement PaymentProtocol to ViewController

-Implementing PaymentProtocol to ViewController will inherit two function success and failed you can use these function as per requirement.

- In @IBAction of Pay with CellPay Button call CellPay SDK LoginVC as

```ruby
### Example Code from View Contorller
#### DispatchQueue.main.async {
            CellPaySDKInitialize.presentFirstViewControllerOn(caller: self, requiredArgument: CellPayPaymentArguments(mobileNumber: "9801977861", merchantName: "Online Shop", paymentType: 1, price: 10, invoiceID: "1234152256"), delegate: self, islive: false)
        }
```

### * Note: Send 1 in paymentType if payment settlement is Real-Time and 2 if payment settlement is T+1 or T+n. *


## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CellPay Framework is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'MyFramework',:git => 'https://github.com/cellcom-nepal/cellpay-ios-sdk'
```

## Author

Rahul Karanjit, rahul.karanjit@cellcom.net.np

## License

CellPaySDK is available under the MIT license. See the LICENSE file for more info.
