//
//  AutorizationVC.swift
//  SwiftChat
//
//  Created by MacBook on 06.06.2022.
//

import UIKit
import SwiftPhoneNumberFormatter
import M13Checkbox
import SafariServices
import NVActivityIndicatorView



class AutorizationVC: UIViewController, UITextFieldDelegate, SFSafariViewControllerDelegate {
    
    let screen = UIScreen.main.bounds
    var activityIndicator: NVActivityIndicatorView!
    var step: Int = 1
    
    func startLoading() {
          //  view.isUserInteractionEnabled = false
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
        
        func finishLoading() {
            view.isUserInteractionEnabled = true
            activityIndicator.stopAnimating()
        }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: view.frame.width / 2 - 14, y: view.frame.height / 2 - 14, width: 28, height: 28),type: .circleStrokeSpin, color: .darkPink, padding: 0)
        
        view.addSubview(backGroundImageView)
        view.addSubview(containerView)
        view.addSubview(containerView2)
        containerView2.addSubview(phoneTf)
        view.addSubview(loginButton)
        view.addSubview(smsConfirmationView)
        
        
        containerView2.addSubview(topView)
        view.addSubview(checkbox)
        view.addSubview(checkButton)
        topView.addSubview(topTitleLabel)
        
        view.addSubview(userAgreementLabel)
        view.addSubview(userAgreementButton)
        view.addSubview(confirmationView)
        view.addSubview(activityIndicator)
        
        smsConfirmationView.addSubview(bgView1)
        smsConfirmationView.addSubview(bgView2)
        smsConfirmationView.addSubview(bgView3)
        smsConfirmationView.addSubview(bgView4)
        
        
        smsConfirmationView.addSubview(codeLabel1)
        smsConfirmationView.addSubview(codeLabel2)
        smsConfirmationView.addSubview(codeLabel3)
        smsConfirmationView.addSubview(codeLabel4)
        
        smsConfirmationView.addSubview(descriptionLabel)
        smsConfirmationView.addSubview(codeTextField)
        smsConfirmationView.addSubview(attrebutedLabel)
        smsConfirmationView.addSubview(goBackButton)
        
        
        confirmationView.addSubview(submitButton)
        
        
        
        
        NotificationCenter.default.addObserver (
                    self,
                    selector: #selector(keyboardWillShow),
                    name: UIResponder.keyboardWillShowNotification,
                    object: nil
                )
                
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(keyboardWillHide),
                    name: UIResponder.keyboardWillHideNotification,
                    object: nil
                )
   
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
        
    }

  @objc func keyboardWillShow(_ notification: Notification) {
      if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                  let keyboardRectangle = keyboardFrame.cgRectValue
                  let keyboardHeight = keyboardRectangle.height
          
          self.finishLoading()
          self.activityIndicator.removeFromSuperview()
          
          
          if step == 1 {
                  
                  UIView.animate(withDuration: 0.3) {
                      
                      let transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + 10)
                      self.submitButton.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + 10)
                      self.containerView.transform = transform
                      self.userAgreementLabel.transform = transform
                      self.userAgreementButton.transform = transform
                      self.checkbox.transform = transform
                      self.checkButton.transform = transform
                      self.loginButton.transform = transform
                      self.submitButton.transform = transform
                      
                  }
          } else {
              UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut) {
                  let transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + 10)
                  self.confirmationView.transform = transform
              }
          }
  }
  }
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = .identity
            self.userAgreementLabel.transform = .identity
            self.userAgreementButton.transform = .identity
            self.checkbox.transform = .identity
            self.checkButton.transform = .identity
            self.loginButton.transform = .identity
            self.submitButton.transform = .identity
            self.confirmationView.transform = .identity
                }
            }
    
    
    lazy var backGroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.view.bounds
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.frame = CGRect(x: 0, y: screen.height - 270, width: screen.width, height: 260)
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true

        return view
    }()
    
    lazy var userAgreementLabel: UILabel = {
            let userAgreementLabel = UILabel()
        userAgreementLabel.backgroundColor = .clear
        userAgreementLabel.textAlignment = .left
        userAgreementLabel.textColor = .black
        userAgreementLabel.numberOfLines = 2
        userAgreementLabel.frame = CGRect(x: screen.width - 360, y: screen.height - 200, width: 290, height: 60)
        userAgreementLabel.font = .systemFont(ofSize: 13)
        userAgreementLabel.attributedText = agreementString(color: .black)
        userAgreementLabel.alpha = 0.75
            return userAgreementLabel
        }()
        
        func agreementString(color: UIColor) -> NSAttributedString {
            let firstAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, .foregroundColor: color ]

            let firstString = NSMutableAttributedString(string: "Я принимаю условия соглашения и разрешаю обработку персональных данных", attributes: firstAttributes)

            return firstString
        }
    
    lazy var checkbox: M13Checkbox = {
        let checkbox = M13Checkbox(frame: CGRect(x: Int(screen.width - 60), y: Int(screen.height - 177),
        width: 24, height: Int(27.0)))
            checkbox.stateChangeAnimation = .bounce(.fill)
            checkbox.checkedValue = 1.0
            checkbox.uncheckedValue = 0.0
            checkbox.backgroundColor = .cloud
            checkbox.tintColor = .cloud
            checkbox.secondaryTintColor = UIColor(red: 180/255, green: 193/255, blue: 200/255, alpha: 1.0)
            checkbox.secondaryCheckmarkTintColor = .pink
            checkbox.markType = .checkmark
            checkbox.checkmarkLineWidth = 3.0
            checkbox.boxLineWidth = 1.0
            checkbox.cornerRadius = 2.0
            checkbox.boxType = .square
            return checkbox
        }()

        lazy var checkButton: UIButton = {
            let checkButton = UIButton()
            checkButton.setBackgroundColor(UIColor.white.withAlphaComponent(0.1), for: .normal)
            checkButton.frame = CGRect(x: Int(screen.width - 60), y: Int(screen.height - 177),
            width: 24, height: Int(27.0))
            checkButton.addTarget(self, action: #selector(check), for: .touchUpInside)
            return checkButton
        }()
    
        @objc func check() {
            // move to controller
            if checkbox.checkState == .checked {
                checkbox.toggleCheckState(false)
                userAgreementLabel.alpha = 0.75
            } else {
                checkbox.toggleCheckState(true)
                userAgreementLabel.alpha = 1.0

                if let phone = phoneTf.phoneNumber() {
                    if phone.count == 10 {
                        loginButton.isEnabled = true
                    }
                }
            }
        }

lazy var loginButton: UIButton = {
    let button = UIButton()
    
    button.frame = CGRect(x: (screen.width / 2) - 170, y: screen.height - 115, width: screen.width - 50, height: 70)
    button.setBackgroundColor(.pink, for: .normal)
    button.setBackgroundColor(.salat, for: .highlighted)
    button.setTitle("Login", for: .normal)
    button.addTarget(self, action: #selector(login), for: .touchUpInside)
    button.layer.shadowColor = UIColor.black.withAlphaComponent(0.9).cgColor
    button.layer.shadowOpacity = 1
    button.layer.shadowOffset = .zero
    button.layer.shadowRadius = 20
    button.layer.cornerRadius = 30
    button.layer.masksToBounds = true
    button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    return button
}()
    
    func getPhoneNumber() -> String {
        print(phoneTf.phoneNumber)
        
        if let phoneNumber = phoneTf.phoneNumber() {
            return phoneNumber
        } else {
            return "erorr"
        }
    }

@objc func login() {
    app.requestSMSCode(phone: getPhoneNumber()) {
        self.step = 2
    }
    self.view.endEditing(true)
    
    confirmationView.transform = .identity
  
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut) {
            self.smsConfirmationView.transform = .identity
            self.smsConfirmationView.isUserInteractionEnabled = true
            self.confirmationView.transform = .identity
            self.submitButton.transform = .identity
//self.confirmationView.isUserInteractionEnabled = false
            self.loginButton.isHidden = true
            self.containerView.isHidden = true
            self.checkButton.isHidden = true
            self.checkbox.isHidden = true
            self.userAgreementLabel.isHidden = true
            self.userAgreementButton.isHidden = true
            
            
        } completion:{ _ in
            self.startLoading()
            self.codeTextField.becomeFirstResponder()
            
    }
}

    
    lazy var smsConfirmationView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: screen.width, height: 250)
        view.backgroundColor = .black
        view.layer.borderWidth = 5
        view.layer.borderColor = .init(red: 183/255, green: 101/255, blue: 177/255, alpha: 50)
        view.layer.cornerRadius = 50
        view.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var confirmationView: UIView = {
        let view = UIView()
         view.frame = CGRect(x: 0, y: screen.height - 270, width: screen.width, height: 260)
         view.backgroundColor = .black
         view.layer.cornerRadius = 50
         view.layer.masksToBounds = true
    view.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    view.isUserInteractionEnabled = true
        view.layer.borderWidth = 5
        view.layer.borderColor = .init(red: 183/255, green: 101/255, blue: 177/255, alpha: 50)
        view.addSubview(submitButton)

         return view
    }()
   
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: (screen.width / 2) - 170, y: 150, width: screen.width - 50, height: 72)
        button.setBackgroundColor(.pink, for: .normal)
        button.setBackgroundColor(.salat, for: .highlighted)
        button.setTitle("Submit", for: .normal)
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.9).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 20
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    
        return button
    }()
    
    @objc func submit() {
        
        let navigationController = UINavigationController(rootViewController: TabBar())
        navigationController.modalPresentationStyle = .fullScreen
        
//        let vc = ChatVC()
//        vc.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true) {
            print("presented ChatVC")
        }
    }
    
    
    
    lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: screen.width / 6, y: screen.height/2 - 380, width: screen.width - 150, height: 50)
        lbl.backgroundColor = .clear
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 16)
        lbl.numberOfLines = 2
        lbl.attributedText = descriptionString(color: .white)
        return lbl
    }()
    
    func descriptionString(color: UIColor) -> NSAttributedString {
        let firstAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, .foregroundColor: color ]

        let firstString = NSMutableAttributedString(string: "На номер \(app.phone) была отправлена SMS с кодом ", attributes: firstAttributes)
        
        return firstString
    }
    
    lazy var codeTextField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 120, width: screen.width, height: 100)
        textField.font = .systemFont(ofSize: 70, weight: .bold)
        textField.textColor = .clear
        textField.tintColor = .clear
        textField.backgroundColor = .clear
        textField.textContentType = .oneTimeCode
        textField.text = ""
        textField.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern: 40])
        textField.delegate = self
        textField.keyboardType = .numberPad
        textField.keyboardAppearance = .dark
        
        return textField
    }()
    
    
    lazy var attrebutedLabel: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        lbl.backgroundColor = .white
        lbl.text = "повторная отправка возможна через \(countDown) секунд"
        return lbl
    }()
    
    lazy var bgView1: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 35, y: 120, width: 60, height: 100)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.layer.cornerRadius = 25
        
        return view
    }()
    
    lazy var bgView2: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 115, y: 120, width: 60, height: 100)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.layer.cornerRadius = 25
        return view
    }()
    lazy var bgView3: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 195, y: 120, width: 60, height: 100)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.layer.cornerRadius = 25
        return view
    }()
    lazy var bgView4: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 275, y: 120, width: 60, height: 100)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.layer.cornerRadius = 25
        return view
    }()
    
    lazy var codeLabel1: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: 35, y: 120, width: 60, height: 100)
        lbl.backgroundColor = .clear
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 70, weight: .bold)
        lbl.textAlignment = .center
        lbl.text = " "
        return lbl
    }()
    
    lazy var codeLabel2: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: 115, y: 120, width: 60, height: 100)
        lbl.backgroundColor = .clear
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 70, weight: .bold)
        lbl.textAlignment = .center
        lbl.text = " "
        return lbl
    }()
    
    lazy var codeLabel3: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: 195, y: 120, width: 60, height: 100)
        lbl.backgroundColor = .clear
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 70, weight: .bold)
        lbl.textAlignment = .center
        lbl.text = " "
        return lbl
    }()
    
    lazy var codeLabel4: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: 275, y: 120, width: 60, height: 100)
        lbl.backgroundColor = .clear
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 70, weight: .bold)
        lbl.textAlignment = .center
        lbl.text = " "
        return lbl
    }()
    
    
    var countDown = 59 {
        didSet{
            attrebutedLabel.text = "повторная отправка возможна через \(countDown) секунд"
        }
    }
    
    func createTimer() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
    
            self.countDown -= 1
            
            if self.countDown == 0 {
                
            }
        }
    }
    
    

    lazy var userAgreementButton: UIButton = {
            let userAgreementButton = UIButton()
        userAgreementButton.layer.cornerRadius = 10
        userAgreementButton.layer.masksToBounds = true
        userAgreementButton.frame = CGRect(x: screen.width - 360, y: screen.height - 200, width: 290, height: 60)
        userAgreementButton.addTarget(self, action: #selector(animateTouchDown2), for: .touchDown)
        userAgreementButton.addTarget(self, action: #selector(animateRelease2), for: [.touchDragExit, .touchUpInside, .touchCancel])
        userAgreementButton.addTarget(self, action: #selector(showUserAgreement), for: .touchDown)
            return userAgreementButton
        }()
        
        @objc func animateTouchDown2(sender: UIButton) {
            UIView.transition(with: self.userAgreementLabel, duration: 0.3, options: [.transitionCrossDissolve], animations: {
                self.userAgreementLabel.attributedText = self.agreementString(color: .pink)
            }, completion: nil)
            
        }
        
        @objc func animateRelease2(sender: UIButton) {
            UIView.transition(with: self.userAgreementLabel, duration: 0.3, options: [.transitionCrossDissolve], animations: {
                self.userAgreementLabel.attributedText = self.agreementString(color: .gray)
            }, completion: nil)
        }
        
    @objc func showUserAgreement() {
            let safariViewController = SFSafariViewController(url: URL(string: "https://www.apple.com/legal/sla/docs/ipod.pdf")!)
        safariViewController.delegate = self
            safariViewController.modalPresentationStyle = .automatic
            present(safariViewController, animated: true) {
                print("didPresentSafari")
            }
        }

    
    
    // TOP CONTAINER VIEW
    
    lazy var containerView2: UIView = {
       let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: screen.width, height: 250)
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true

        return view
    }()
    
    lazy var topView: UIImageView = {
       let imageView = UIImageView()
        imageView.frame = CGRect(x: 24, y: 65, width: screen.width - 50, height: 70)
        imageView.backgroundColor = .pink
        imageView.layer.cornerRadius = 30
        imageView.tintColor = .white
        
        return imageView
        
    }()
    
    lazy var topTitleLabel: UILabel = {
        let topTitleLabel = UILabel()
        topTitleLabel.frame = CGRect(x: 0, y: 0, width: screen.width - 50, height: 70)
        topTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        topTitleLabel.text = "Meet the new way of communication"
        topTitleLabel.textAlignment = .center
        topTitleLabel.numberOfLines = 2
        
        return topTitleLabel
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneTf.endEditing(true)
        codeTextField.endEditing(true)
        view.endEditing(true)
    }
    
    lazy var phoneTf: PaddedPhoneTextField = {
       let phoneTf = PaddedPhoneTextField()
        phoneTf.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "(###) ###-##-##")
        phoneTf.prefix = "+7 "
        phoneTf.frame = CGRect(x: 24, y: 150, width: screen.width - 50, height: 70)
        phoneTf.backgroundColor = .gray
        phoneTf.layer.cornerRadius = 30
        phoneTf.keyboardAppearance = .dark
        phoneTf.keyboardType = .numberPad
        phoneTf.delegate = self
        phoneTf.tintColor = .white
        phoneTf.textColor = .white
        phoneTf.font = .systemFont(ofSize: 30, weight: .bold)
        
        return phoneTf
    }()
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("didBeginEditing")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        phoneTf.endEditing(true)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text {
            if let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                
                print(text)
                print(textRange)
                print(updatedText)
                
                let charMax = 4
                if updatedText.count <= charMax {
                    
                    UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut) {
                        
                        switch updatedText.count {
                            
                    case 0:
                            self.bgView1.backgroundColor = .gray
                            self.bgView2.backgroundColor = .gray
                            self.bgView3.backgroundColor = .gray
                            self.bgView4.backgroundColor = .gray
                            
                            self.codeLabel1.text = ""
                            self.codeLabel2.text = ""
                            self.codeLabel3.text = ""
                            self.codeLabel4.text = ""
                    case 1:
                            self.bgView1.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
                            self.bgView2.backgroundColor = .gray
                            self.bgView3.backgroundColor = .gray
                            self.bgView4.backgroundColor = .gray
                            
                            self.codeLabel1.text = updatedText[0]
                            self.codeLabel2.text = ""
                            self.codeLabel3.text = ""
                            self.codeLabel4.text = ""
                           
                            
                    case 2:
                            self.bgView1.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
                            self.bgView2.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
                            self.bgView3.backgroundColor = .gray
                            self.bgView4.backgroundColor = .gray
                            
                            self.codeLabel2.text = updatedText[1]
                            self.codeLabel3.text = ""
                            self.codeLabel4.text = ""
                            
                    case 3:
                            self.bgView1.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
                            self.bgView2.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
                            self.bgView3.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
                            self.bgView4.backgroundColor = .gray
                            
                            self.codeLabel3.text = updatedText[2]
                            self.codeLabel4.text = ""
                    case 4:
                            self.bgView1.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
                            self.bgView2.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
                            self.bgView3.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
                            self.bgView4.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
                            
                            self.codeLabel4.text = updatedText[3]
                            
                            app.sendSMSCode(code: updatedText) {
                                if let sentCode = Int(updatedText) {
                                    if app.randomCode == sentCode {
                                    print("Авторизация прошла успешно")
                                } else {
                                    print("Неверный код")
                                }
                            }
                            }
                            
                    default:
                            break
                        }
                    }
                } else {
                return false
            }
                
            }
            }
        return true
    }

    var goBackButton: UIButton {
    let button = UIButton()
    button.frame = CGRect(x: 16, y: screen.height/2 - 370, width: 32, height: 32)
    button.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.tintColor = .white
    button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }

    @objc func goBack() {
        dismiss(animated: true) {
            
        }
    }
}
