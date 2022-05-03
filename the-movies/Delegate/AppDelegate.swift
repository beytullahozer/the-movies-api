//
//  AppDelegate.swift
//  the-movies
//
//  Created by Beytullah Özer on 28.04.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        rememberUser()
        return true
    }
    
    // MARK: - Screen
    func configureWindow(destinationVC : UIViewController){
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        window?.rootViewController = destinationVC
        
    }
    
    //MARK: - Custom Remember Function
    func rememberUser(){
        
        configureWindow(destinationVC: MainVC())
        
        let user = uDefaults.object(forKey: "userFirst")
        
        if user != nil {
            
            print("User not equal nil.", user!)
            
            window?.rootViewController =  MainVC()
            
        }
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "the_movies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

