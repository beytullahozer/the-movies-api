import Foundation
import UIKit


extension UIView{
    
    func addCornerRadious(){
        
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    
    func makeCircle(){
        
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
        
    }
    
}

extension UITextField {
    
    func setDatePickerAsInputViewFor(target:Any) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 200.0))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 40.0))
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tapCancel))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: nil, action: #selector(dateSelected))
        toolBar.setItems([cancel,flexibleSpace, done], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    
    @objc func dateSelected() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        if let datePicker = self.inputView as? UIDatePicker {
            self.text = dateFormatter.string(from: datePicker.date)
            self.resignFirstResponder()
            return
        }
        
        
    }
    
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}


extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }
}

extension String{
    
    func returnDate() -> Date{
        
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        
        // Set Date Format
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        // Convert String to Date
        
        if let date = dateFormatter.date(from: self){
            
            return date
            
        }else{
            
            return Date()
            
        }
        
    }
    
    func returnInt() -> Int{
        
        if let intValue  = Int(self){
            return intValue
        }else{
            return 0
        }
    }
    
    func returnDouble() -> Double{
        
        if let doubleValue = Double(self){
            return doubleValue
        }else{
            return 0.0
        }
    }
    
    
}


extension UITextField{
    
    
    func currencyField(delegateTextfield : UITextField){
        
        if delegateTextfield == self && !delegateTextfield.text!.contains("$"){
            
            self.text = "$\(self.text!)"
        }
    }
    
    func percentageField(delegateTextfield : UITextField){
        
        if delegateTextfield == self && !delegateTextfield.text!.contains("%"){
            
            self.text = "%\(self.text!)"
        }
    }
    
    
    func changeToPercent(){
        
        self.text = "\(self.text!.replacingOccurrences(of: "%", with: ""))"
        self.text = "\(self.text!.replacingOccurrences(of: "$", with: ""))"
        self.text = "%\(self.text!)"
    }
    
    func changeToCurrency(){
        
        self.text = "\(self.text!.replacingOccurrences(of: "%", with: ""))"
        self.text = "\(self.text!.replacingOccurrences(of: "$", with: ""))"
        self.text = "$\(self.text!)"
    }
    
    func removeAllSigns() -> String{
        
        var string = self.text!
        string = "\(string.replacingOccurrences(of: "%", with: ""))"
        string = "\(string.replacingOccurrences(of: "$", with: ""))"
        return string
        
    }
    
    
    
    
    
}
