import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var mainWindow: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.mainWindow = UIWindow(frame: UIScreen.main.bounds)
        self.mainWindow?.rootViewController = UINavigationController(rootViewController: GalacticRestorationLoadingViewController())
        self.mainWindow?.makeKeyAndVisible()
        
        
        if UserDefaults.standard.object(forKey: "sound") == nil {
            UserDefaults.standard.set(true, forKey: "sound")
        }
        if UserDefaults.standard.object(forKey: "vibro") == nil {
            UserDefaults.standard.set(true, forKey: "vibro")
        }
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        return .portrait
    }


}


