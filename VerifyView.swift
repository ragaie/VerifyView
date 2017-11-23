//
//  VerifyView.swift
//  VerificationCode
//
//  Created by Ragaie alfy on 11/22/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit

@IBDesignable open class VerifyView: UIView {

    public var ID : String!
    public var delegate : VerifyViewDelegate!
    private var allText : [UITextField]! = []
    public var verifyText : String! = ""
    
    
    @IBInspectable public var itemNumber: NSInteger = 10{
        didSet {
            
            addTextField()
        }
    }
    @IBInspectable public var underLineHight: NSInteger = 3{
        didSet {
            
            addTextField()
        }
    }
    @IBInspectable public var fontColor: UIColor = UIColor.black {
        didSet {
            
            addTextField()

        }
    }
    
    @IBInspectable public var underLineColor: UIColor = UIColor.lightGray {
        didSet {
            
            addTextField()

        }
    }
    @IBInspectable public var firstResponse: Bool = true
    
    
    
    //MARK: Initializers
    override public init(frame : CGRect) {
        super.init(frame : frame)
        initSubviews()
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
        initActionAndDelegete()
        
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        addTextField()

    }
    
    func initSubviews() {
        
        let bundle = Bundle(for: type(of: self))
        
        
        
        
        let view =  UIView.init()
       // view.backgroundColor = UIColor.red
        
        // to make view fit view in design you welcome.
        view.frame = self.bounds
        
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        // nib.contentView.frame = bounds
        
        addSubview(view)
        
    //    checkedImage = UIImage(named: "check" , in: bundle,compatibleWith: nil)!
        
      //  unCheckedImage = UIImage(named: "unCheck", in: bundle,compatibleWith: nil)!
        
        
    }
    
    func initActionAndDelegete()  {
        
        
        
       // checkBoxButton.addTarget(self, action: #selector(CheckBox.ChangeStatus(_:)), for: .touchUpInside)
        
    }
    
    
    func addTextField(){
        
        
        if allText.count > 0 {
            
            for i in  0...(allText.count - 1){
                allText[i].removeFromSuperview()
            }
            allText.removeAll()
        }
        
        var spacing : CGFloat! = 10.0
        var width = (self.frame.width - (CGFloat(itemNumber + 1) * spacing)) / CGFloat(itemNumber)
        var hight = (self.frame.height - (spacing ))
        
        for i in 0...itemNumber - 1{
            
            var startX = width * CGFloat(i) + (spacing * CGFloat(i + 1))
            var startY = (self.frame.height -  hight ) / 2
            
            
            var textField = UITextField.init(frame: CGRect.init(x: startX, y: startY, width: width, height: hight))
            
            
            
            if firstResponse == true && i == 0{
                
                textField.becomeFirstResponder()
                
                
            }
            
            textField.textColor = fontColor
            
            textField.keyboardType = .numberPad
            textField.placeholder = "0"
            textField.font = UIFont.boldSystemFont(ofSize: ((hight + width ) / 2))
            textField.textAlignment = .center
            
            textField.backgroundColor = UIColor.white
            textField.addTarget(self, action: #selector(VerifyView.textFieldDidChange(_:)), for: .editingChanged)
            textField.delegate = self
            textField.tag = i
            
            // add layer for under line
            let border = CALayer()
            let width = CGFloat(underLineHight)
            border.borderColor = underLineColor.cgColor
            border.frame = CGRect(x: 0, y: textField.frame.height - width, width:  textField.frame.width, height: textField.frame.height + width)
            border.borderWidth = width
            textField.layer.addSublayer(border)
            textField.layer.masksToBounds = true
            
            allText.append(textField)
            self.addSubview(textField)
            
        }
        
        
        self.setNeedsDisplay()

        
    }
    
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
      //  print("text changed")
        // self.myView.confirmCodeText.becomeFirstResponder()
//
        
        
        if delegate != nil{
            
            delegate.verifyView(self, textEndEditing: textField)
            
        }
        if textField.text == ""{
        
            if textField.tag > 0{
                allText[textField.tag - 1 ].becomeFirstResponder()
                verifyText.removeLast()
                // remove text
            }
            else if textField.tag == 0{
                verifyText.removeLast()

                return
                
            }
        
        }
  
        
       else if textField.tag < allText.count - 1 {
                allText[textField.tag + 1].becomeFirstResponder()
            
            verifyText.append(textField.text!)
            /// append text
        }
        else if textField.tag == allText.count - 1{
            verifyText.append(textField.text!)

            if delegate != nil{
                
                delegate.verifyView(self, finisheditWithText: verifyText)
                
            }
            return

        }
                //ConfirmCode.append((text1.text?.characters.first!)!)
                //index = 1
         
            }
  
}



extension VerifyView : UITextFieldDelegate{
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 1
        let currentString: NSString = textField.text as! NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
}
