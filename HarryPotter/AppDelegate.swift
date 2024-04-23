//
//  AppDelegate.swift
//  HarryPotter
//
//  Created by María Pérez  on 4/4/24.
//
import CoreData
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var persistentContainer: NSPersistentContainer!
    var harryPotterManager: HarryPotterManager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            configureCoreDataStack()
            
            harryPotterManager = HarryPotterManager(container: persistentContainer)
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = windowScene.windows.first {
                    if let rootViewController = window.rootViewController as? HarryPotterViewController {
                        rootViewController.harryPotterManager = harryPotterManager
                    }
                    
                    if let favoritosViewController = window.rootViewController as? FavoritosViewController {
                        favoritosViewController.harryPotterManager = harryPotterManager
                    }
                }
            }

            return true
        }
    
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func configureCoreDataStack() {
        // Inicializar el NSPersistentContainer con el nombre de tu archivo .xcdatamodeld
        persistentContainer = NSPersistentContainer(name: "HarryPotterDataModel")
        
        // Cargar los stores persistentes
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error al cargar el almacenamiento persistente de Core Data: \(error), \(error.userInfo)")
            }
        }
    }

}
