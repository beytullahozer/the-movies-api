import Foundation
import UIKit


var screenHeight = CGFloat()
var screenWidth = CGFloat()
var stringMultiplier = CGFloat()
var ScreenWidth_To_ScreenHeight_Converter = CGFloat()
var ScreenHeight_To_ScreenWidth_Converter = CGFloat()
var lastObjectFrane = CGRect()
var screen_ratio = CGFloat()

func setDefaultSize(view : UIView){
    
    screenHeight = view.frame.size.height
    screenWidth = view.frame.size.width
    stringMultiplier = 0.00115 * screenHeight
    ScreenWidth_To_ScreenHeight_Converter = 1 / screenWidth * screenHeight / 2.1642
    ScreenHeight_To_ScreenWidth_Converter = 1 / screenHeight * screenWidth / 0.4620
    
}

// Default Color

var backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00)
var clr_blue = UIColor(red: 0.12, green: 0.42, blue: 1.00, alpha: 1.00)
var clr_seperator = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.00)
var clr_placeholder = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 1.00)
var clr_highlightedBtn = UIColor(red: 0.79, green: 0.80, blue: 0.83, alpha: 1.00)
var clr_alert = UIColor(red: 1.00, green: 0.19, blue: 0.19, alpha: 1.00)
var clr_unselectedTabbarTitle = UIColor(red: 0.67, green: 0.72, blue: 0.78, alpha: 1.00)


// Default Font

func font_WorkSansBold(size : CGFloat) -> UIFont{
    
    return UIFont(name: "WorkSans-Bold", size: size * stringMultiplier)!
    
}

func font_WorkSansRegular(size : CGFloat) -> UIFont{
    
    return UIFont(name: "WorkSans-Regular", size: size * stringMultiplier)!
    
}

func font_WorkSansSemiBold(size : CGFloat) -> UIFont{
    
    return UIFont(name: "WorkSans-Semibold", size: size * stringMultiplier)!
    
}

func font_WorkSansMedium(size : CGFloat) -> UIFont{
    
    return UIFont(name: "WorkSans-Medium", size: size * stringMultiplier)!
    
}

func font_DmSansBold(size : CGFloat) -> UIFont{
    
    return UIFont(name: "DMSans-Bold", size: size * stringMultiplier)!
    
}

func font_DmSansMedium(size : CGFloat) -> UIFont{
    
    return UIFont(name: "DMSans-Medium", size: size * stringMultiplier)!
    
}

func font_DmSansRegular(size : CGFloat) -> UIFont{
    
    return UIFont(name: "DMSans-Regular", size: size * stringMultiplier)!
    
}

func setGradientBackground() {
    
    let colorTop =  UIColor(red: 0.78, green: 0.47, blue: 0.98, alpha: 1.00).cgColor
    let colorBottom = UIColor(red: 0.64, green: 0.82, blue: 0.99, alpha: 1.00).cgColor
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [colorTop, colorBottom]
    gradientLayer.locations = [0.0, 1.0]
    //    gradientLayer.frame = self.view.bounds
    //    self.view.layer.insertSublayer(gradientLayer, at:0)
    
}


// User Default

let uDefaults = UserDefaults.standard


