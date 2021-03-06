import UIKit
import Firebase

class SignUpController: UIViewController {
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "UBER"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView.inputContainerView(
            image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"),
            height: 50,
            textField: emailTextField
        )
        return view
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let view = UIView.inputContainerView(
            image: #imageLiteral(resourceName: "ic_person_outline_white_2x"),
            height: 50,
            textField: fullnameTextField
        )
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView.inputContainerView(
            image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"),
            height: 50,
            textField: passwordTextField
        )
        return view
    }()
    
    private lazy var accountTypeContainerView: UIView = {
        let view = UIView.inputContainerView(
            image: #imageLiteral(resourceName: "ic_account_box_white_2x"),
            height: 50,
            segmentedControl: accountTypeSegmentControl
        )
        return view
    }()
    
    private let emailTextField: UITextField = {
        return UITextField.textField(withPlaceholder: "Email", isLowerCased: true)
    }()
    
    private let fullnameTextField: UITextField = {
        return UITextField.textField(withPlaceholder: "Fullname")
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField.textField(withPlaceholder: "Password", isSecure: true)
    }()
    
    private let accountTypeSegmentControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Rider", "Driver"])
        sc.backgroundColor = .backgroundColor
        sc.tintColor = UIColor(white: 1, alpha: 0.87)
        sc.selectedSegmentIndex = 0
        sc.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor : UIColor.black
            ],
            for: .selected
        )
        sc.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor : UIColor.white
            ],
            for: .normal
        )
        return sc
    }()
    
    private let signUpButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(
            string: "Already have an account? ",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ]
        )
        
        attributedTitle.append(NSAttributedString(
            string: "Sign In",
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint
            ]
        ))
        button.addTarget(self, action: #selector(handleNavigateToLogin), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    // MARK: - Lifecyle
    override func viewDidLoad() {
        configUI()
    }
    
    // MARK: - Selectors
    @objc func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        let accountTypeIndex = accountTypeSegmentControl.selectedSegmentIndex
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Failed to register user with error \(error)")
                return
            }
            guard let uid = result?.user.uid else { return }
            
            let values = [
                "email": email,
                "fullname": fullname,
                "accountType": accountTypeIndex
            ] as [String: Any]
            
            Database.database().reference().child("users").child(uid).updateChildValues(values) { (error, ref) in
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleNavigateToLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    func configUI() {
        configNavigationBar()
        
        view.addSubview(titleLabel)
        view.backgroundColor = .backgroundColor
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        let stack = UIStackView(
            arrangedSubviews: [
                emailContainerView,
                fullnameContainerView,
                passwordContainerView,
                accountTypeContainerView,
                signUpButton
            ]
        )
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 24
        
        view.addSubview(stack)
        stack.anchor(
            top: titleLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 40,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            height: 32
        )
    }
    
    func configNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
    }
}
