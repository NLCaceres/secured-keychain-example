//
//  ViewController.swift
//  SecuredKaychain
//
//  Created by Demo on 3/1/16.
//  Copyright © 2016 USC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //let MyKeychainWrapper = KeychainWrapper()
    
    let keychainItemKey = "com.ITP344.SecuredKeychain.ccInfo"
    let kCardNickName = "com.ITP344.SecuredKeyChain.kCardNickName"
    let kCardHolderName = "com.ITP344.SecuredKeyChain.kCardHolderName"
    let kCCNumber = "com.ITP344.SecuredKeyChain.kCCNumber"
    let kExpirationDate = "com.ITP344.SecuredKeyChain.kExpirationDate"
    let kSecurityCode = "com.ITP344.SecuredKeyChain.kSecurityCode"
    
    var CCList : [CreditCardInfo] = []
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        CCList = []
        tableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
        let keychainItem : KeychainItemWrapper = KeychainItemWrapper(identifier: keychainItemKey, accessGroup: nil)
        if let keyChainValue = keychainItem.object(forKey: kSecValueData as String) as? String {
            CCList = convertJsonStringToArray(text: keyChainValue)
            tableView.reloadData()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CCList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    let cellId = "cellId1"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil) {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellId)
        }
        
        let cardInfo = CCList[(indexPath as IndexPath).row]
        let cardNickname = cardInfo.cardNickName
        cell?.textLabel?.text = cardNickname
        let cardLast4 = String(cardInfo.cardNumber.suffix(4))
        print("This is the last 4 digits: \(cardLast4)")
        cell?.detailTextLabel?.text = cardLast4
        print("This is in the detail text label: \(cell?.detailTextLabel?.text)")
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            CCList.remove(at: (indexPath as IndexPath).row)
            
            var CCDictList : [Dictionary<String, String>] = []
            for creditCard in self.CCList {
                let creditCardDict : Dictionary<String, String> = [self.kCardNickName: creditCard.cardNickName, self.kCardHolderName: creditCard.cardHolderName, self.kCCNumber: creditCard.cardNumber, self.kExpirationDate: creditCard.expirationDate, self.kSecurityCode: creditCard.securityCode]
                CCDictList.append(creditCardDict)
            }
            
            let keychainedString : NSString? = self.convertDataToString(inputData: self.convertDictToJsonData(inputArray: CCDictList)!)
            
            let keychainItem : KeychainItemWrapper = KeychainItemWrapper(identifier: self.keychainItemKey, accessGroup: nil)
            keychainItem.setObject("com.securedKeyChain.kSecAttrService", forKey: kSecAttrService)
            keychainItem.setObject(kSecAttrAccessibleWhenUnlocked, forKey: kSecAttrAccessible)
            keychainItem.setObject(keychainedString, forKey: kSecValueData as String)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    @IBAction func resetButtonTouched(_ sender: AnyObject) {
		
		let pinKeychainItem : KeychainItemWrapper = KeychainItemWrapper(identifier: pinKey, accessGroup: nil)
		
		pinKeychainItem.resetKeychainItem()
		
		
        let keychainItem : KeychainItemWrapper = KeychainItemWrapper(identifier: keychainItemKey, accessGroup: nil)
        
        keychainItem.resetKeychainItem()
        CCList = []
        tableView.reloadData()
        print("Reset pin and cards")
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var addCardInfoVC : AddCardInfoVC = AddCardInfoVC()
        addCardInfoVC = segue.destination as! AddCardInfoVC
        addCardInfoVC.addCCInfoCH = { cardNickName, cardHolderName, cardNumber, expirationDate, securityCode in
            
            if let CardNickName = cardNickName {
                self.CCList.append(CreditCardInfo(cardNickName: CardNickName, cardHolderName: cardHolderName!, cardNumber: cardNumber!, expirationDate: expirationDate!, securityCode: securityCode!)!)
                self.tableView.reloadData()
                var CCDictList : [Dictionary<String, String>] = []
                for creditCard in self.CCList {
                    let creditCardDict : Dictionary<String, String> = [self.kCardNickName: creditCard.cardNickName, self.kCardHolderName: creditCard.cardHolderName, self.kCCNumber: creditCard.cardNumber, self.kExpirationDate: creditCard.expirationDate, self.kSecurityCode: creditCard.securityCode]
                    CCDictList.append(creditCardDict)
                }
                
                let keychainedString : NSString? = self.convertDataToString(inputData: self.convertDictToJsonData(inputArray: CCDictList)!)
                
                let keychainItem : KeychainItemWrapper = KeychainItemWrapper(identifier: self.keychainItemKey, accessGroup: nil)
                keychainItem.setObject("com.securedKeyChain.kSecAttrService", forKey: kSecAttrService)
                keychainItem.setObject(kSecAttrAccessibleWhenUnlocked, forKey: kSecAttrAccessible)
                keychainItem.setObject(keychainedString, forKey: kSecValueData as String)
            }
            self .dismiss(animated: true, completion: nil)
            self.tableView.reloadData()
        }
        
        
    }
    
    func convertJsonStringToArray(text: String) -> [CreditCardInfo] {
        
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                let CCDictList = try JSONSerialization.jsonObject(with: data, options: []) as? Array<Dictionary<String, String>>
                CCList.removeAll()
                for dict in CCDictList! {
                    
                    let cardNickName = dict[kCardNickName]
                    let cardHolderName = dict[kCardHolderName]
                    let CCNumber = dict[kCCNumber]
                    let expirationDate = dict[kExpirationDate]
                    let securityCode = dict[kSecurityCode]
                    
                    CCList.append(CreditCardInfo(cardNickName: cardNickName!, cardHolderName: cardHolderName!, cardNumber: CCNumber!, expirationDate: expirationDate!, securityCode: securityCode!)!)
                    
                }
            } catch let error as NSError {
                print(error)
            }
        }
        return CCList
    }
    
    func convertDictToJsonData(inputArray: Array<Dictionary<String, String>>) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: inputArray, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func convertDataToString(inputData: Data) -> NSString? {
        
        let returnString = String(data: inputData, encoding: String.Encoding.utf8)
        return returnString as NSString?
    }
    

}

