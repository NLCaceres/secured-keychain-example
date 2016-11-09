//
//  CheckPinVC.swift
//  SecuredKaychain
//
//  Created by Administrator on 10/12/16.
//  Copyright © 2016 USC. All rights reserved.
//

import UIKit

class CheckPinVC: UIViewController {
	
	@IBOutlet weak var pinLabel: UITextField!
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
		
		let keychainItem : KeychainItemWrapper = KeychainItemWrapper(identifier: pinKey, accessGroup: nil)
		
		if let keyValue = keychainItem.object(forKey: kSecValueData as String) as? String{
			if(keyValue == pinLabel.text){
				dismiss(animated: true, completion: nil)
				pinCheckVc = nil
				return
			}
			
		}
		
		// if we got here then something went wrong
		errorLabel.text = "Re-enter Pin"
		
	}

	
	
}
