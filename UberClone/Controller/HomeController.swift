import UIKit
import Firebase
import MapKit
class HomeController: UIViewController {
    // MARK: - Properties
    
    private let mapView = MKMapView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        view.backgroundColor = .gray
        checkIfUserIsLogged()
        
    }

    // MARK: - API
    func checkIfUserIsLogged() {
        let uid = Auth.auth().currentUser?.uid
        if  uid == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configUI()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            
        }
    }
    
    // MARK: - Helpers
    
    func configUI() {
        view.addSubview(mapView)
        mapView.frame = view.frame
    }
    
}
