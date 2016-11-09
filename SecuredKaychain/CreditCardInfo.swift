//
//  CreditCardInfo.swift
//  SecuredKaychain
//
//  Created by Nicholas L Caceres on 10/26/16.
//  Copyright © 2016 USC. All rights reserved.
//

import UIKit

class CreditCardInfo: NSObject {
    
    var cardNickName : String
    
    var cardHolderName : String
    
    var cardNumber : String
    
    var expirationDate : String
    
    var securityCode : String
    
    
    /// MARK: Initialization
    
    init?(cardNickName: String, cardHolderName: String, cardNumber: String, expirationDate: String, securityCode: String) {
        
        self.cardNickName = cardNickName
        self.cardHolderName = cardHolderName
        self.cardNumber = cardNumber
        self.expirationDate = expirationDate
        self.securityCode = securityCode
        
        if cardNickName.isEmpty || cardHolderName.isEmpty || cardNumber.isEmpty || expirationDate.isEmpty || securityCode.isEmpty {
            return nil
        }
    }

}
