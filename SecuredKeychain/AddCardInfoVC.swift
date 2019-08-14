//
//  AddCardInfoVC.swift
//  SecuredKaychain
//
//  Created by Nicholas L Caceres on 10/23/16.
//  Copyright © 2016 USC. All rights reserved.
//

import UIKit

typealias AddCCInfoCompletionHandler = (String?, String?, String?, String?, String?) -> ()

class AddCardInfoVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cardNickNameTF: UITextField!
    
    @IBOutlet weak var cardHolderNameTF: UITextField!
    
    @IBOutlet weak var CCNumberTF: UITextField!
    
    @IBOutlet weak var expirationDateTF: UITextField!
    
    @IBOutlet weak var securityCodeTF: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var addCCInfoCH : AddCCInfoCompletionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardNickNameTF.becomeFirstResponder()

        // Do any additional setup after loading the view.
        // var CCWrapper : KeychainItemWrapper = KeychainItemWrapper(identifier: keychainItemkey, accessGroup: nil)
        // CCWrapper.setObject(kSecAttrAccessibleWhenUnlocked, forKey: kSecAttrAccessible)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        
        if let addCCICH = addCCInfoCH {
             addCCICH(cardNickNameTF.text!, cardHolderNameTF.text!, CCNumberTF.text!, expirationDateTF.text!, securityCodeTF.text!)
        }
        
        cardNickNameTF.text = nil
        cardHolderNameTF.text = nil
        CCNumberTF.text = nil
        expirationDateTF.text = nil
        securityCodeTF.text = nil
        
    }
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        
        if let addCCICH = addCCInfoCH {
            addCCICH(nil, nil, nil, nil, nil)
        }
        
        cardNickNameTF.text = nil
        cardHolderNameTF.text = nil
        CCNumberTF.text = nil
        expirationDateTF.text = nil
        securityCodeTF.text = nil

        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        print("This is the text in textfield: \(textField.text)")
        if let addCCICH = addCCInfoCH {
            addCCICH(cardNickNameTF.text!, cardHolderNameTF.text!, CCNumberTF.text!, expirationDateTF.text!, securityCodeTF.text!)
        }
        
        cardNickNameTF.text = nil
        cardHolderNameTF.text = nil
        CCNumberTF.text = nil
        expirationDateTF.text = nil
        securityCodeTF.text = nil
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let changedString : String = (textField.text! as String) + string
        print(changedString)
        if cardNickNameTF.text!.isEmpty || cardHolderNameTF.text!.isEmpty || CCNumberTF.text!.isEmpty || expirationDateTF.text!.isEmpty || securityCodeTF.text!.isEmpty {
            saveButton.isEnabled = false
        }
        else {
          saveButton.isEnabled = true
        }
        
        return true 

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
