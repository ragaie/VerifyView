//
//  VerifyViewDelegate.swift
//  VerificationCode
//
//  Created by Ragaie alfy on 11/22/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit


    public protocol VerifyViewDelegate {
        
        
        func verifyView(_ verifyView: VerifyView,finisheditWithText : String)
        func verifyView(_ verifyView: VerifyView,textEndEditing : UITextField)
    }
    

