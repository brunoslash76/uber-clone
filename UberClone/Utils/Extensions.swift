import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
    }
    
    static let backgroundColor = UIColor.rgb(red: 25, green: 25, blue: 25)
    static let mainBlueTint = UIColor.rgb(red: 17, green: 154, blue: 237)
}

extension UIView {
    
    static func inputContainerView(
        image: UIImage? = nil ,
        height: CGFloat,
        textField: UITextField? = nil,
        segmentedControl: UISegmentedControl? = nil
    ) -> UIView {
        
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.alpha = 0.87
        view.addSubview(imageView)
                
        if let textField = textField {
            imageView.centerY(inView: view)
            imageView.anchor(
                left: view.leftAnchor,
                paddingLeft: 8,
                width: 24,
                height: 24
            )
            view.addSubview(textField)
            textField.anchor(
                left: imageView.rightAnchor,
                bottom: view.bottomAnchor,
                right: view.rightAnchor,
                paddingLeft: 8,
                paddingBottom: 8
            )
            textField.centerY(inView: view)
            
            let separatorView = UIView()
            separatorView.backgroundColor = .lightGray
            view.addSubview(separatorView)
            separatorView.anchor(
                left: view.leftAnchor,
                bottom: view.bottomAnchor,
                right: view.rightAnchor,
                paddingLeft: 8,
                paddingRight: 8,
                height: 0.75
            )
        }
        
        if let sc = segmentedControl {
            view.addSubview(sc)
            sc.anchor(
                left: view.leftAnchor,
                right: view.rightAnchor,
                paddingLeft: 8,
                paddingRight: 8
            )
            sc.centerY(inView: view, constant: 8)
        }

        return view
    }
    
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        paddingTop: CGFloat = 0,
        paddingLeft: CGFloat = 0,
        paddingBottom: CGFloat = 0,
        paddingRight: CGFloat = 0,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerX(inView view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView, constant: CGFloat = 0) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }
}

extension UITextField {
    static func textField(withPlaceholder placeholder: String, isSecure entry: Bool? = false, isLowerCased: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.autocapitalizationType = isLowerCased ? UITextAutocapitalizationType.none : UITextAutocapitalizationType.sentences
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .white
        textField.keyboardAppearance = .dark
        if let  isSecure = entry {
            textField.isSecureTextEntry = isSecure
        }
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray]
        )
        return textField
    }
}
