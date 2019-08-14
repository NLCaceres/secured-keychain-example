//
//  NewPinVC.swift
//  SecuredKaychain
//
//  Created by Administrator on 10/12/16.
//  Copyright © 2016 USC. All rights reserved.
//

import UIKit

class NewPinVC: UIViewController {
	
	
	@IBOutlet weak var enterPinTF: UITextField!
	@IBOutlet weak var reenterPinTF: UITextField!
	@IBOutlet weak var errorLabel: UILabel!
	
	

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func submitButtonTouched(_ sender: AnyObject) {
	
		
		if(enterPinTF.text != reenterPinTF.text){
			errorLabel.text = "Pins don't match!"
			return
		}
		
		let keychainItem : KeychainItemWrapper = KeychainItemWrapper(identifier: pinKey, accessGroup: nil)
		
		keychainItem.setObject(kSecAttrAccessibleWhenUnlocked, forKey: kSecAttrAccessible)
		
		keychainItem.setObject(enterPinTF.text, forKey: kSecValueData as String)
		
		pinCheckVc = nil
		
		dismiss(animated: true, completion: nil)
		
	}


}
