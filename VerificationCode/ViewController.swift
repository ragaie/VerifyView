//
//  ViewController.swift
//  VerificationCode
//
//  Created by Ragaie alfy on 11/22/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,VerifyViewDelegate{
  

    
    @IBOutlet weak var verifyCode: VerifyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyCode.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func verifyView(_ verifyView: VerifyView, finisheditWithText: String) {
        print(finisheditWithText)
        view.endEditing(true)
    }
    
    func verifyView(_ verifyView: VerifyView, textEndEditing: UITextField) {
        print(textEndEditing.text)
        
        print(textEndEditing.tag)
    }
    
}

