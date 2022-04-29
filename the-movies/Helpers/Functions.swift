import Foundation
import UIKit
import Lottie


func showCustomAlert(title: String, message: String,  viewController : UIViewController){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
    viewController.present(alert, animated: true, completion: nil)
    
}

func vibrate(style : UIImpactFeedbackGenerator.FeedbackStyle){
    
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.impactOccurred()
    
}


func getCurrentDateAsString() -> String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.setLocalizedDateFormatFromTemplate("yyyyMMdd")
    return dateFormatter.string(from: Date())
}

func getCurrentDateAsMinimalString() -> String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    return dateFormatter.string(from: Date())
}

func getNextWeekDateAsString() -> String{
    
    var dayComponent    = DateComponents()
    dayComponent.day    = 7 // For removing one day (yesterday): -1
    let theCalendar     = Calendar.current
    let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date())!
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.setLocalizedDateFormatFromTemplate("yyyyMMdd")
    return dateFormatter.string(from: nextDate)
}



func create_loading_view(view : UIView) -> UIView{
    
    let view_loading = UIView()
    view_loading.frame = view.bounds
    
    let view_background = UIView()
    view_background.frame = view_loading.bounds
    view_background.backgroundColor = .black
    view_background.alpha = 0.6
    view_loading.addSubview(view_background)
    
    let anim_loading = AnimationView(name: "loading")
    anim_loading.frame = CGRect(x: 0.25 * screenWidth, y: 0.25 * screenHeight, width: 0.5  * screenWidth, height: 0.5 * screenHeight)
    anim_loading.backgroundColor = .clear
    anim_loading.loopMode = .loop
    anim_loading.animationSpeed = 1
    anim_loading.backgroundBehavior = .pauseAndRestore
    view_loading.addSubview(anim_loading)
    anim_loading.play()
    
    return view_loading
    
}

func unwrapToString(variable : Any) -> String{
    
    if let unwrapped = variable as? String{
        return unwrapped
    }else{
        return ""
    }
}

func unwrapToDouble(variable : Any) -> Double{
    
    if let unwrapped = variable as? Double{
        return unwrapped
    }else{
        return 0.0
    }
}

func unwrapToInt(variable : Any) -> Int{
    
    if let unwrapped = variable as? Int{
        return unwrapped
    }else{
        return 0
    }
}



