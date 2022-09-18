//
//  ChatVC.swift
//  SwiftChat
//


import UIKit

class ChatVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    let screen = UIScreen.main.bounds
    var messages = ["Hello", "Hi", "How are you today?"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupCollectionView()
        
        view.addSubview(keyboardView)
        keyboardView.addSubview(textField)
        keyboardView.addSubview(sendButton)
        keyboardView.addSubview(attachButton)
        
        let fontFamilyNames = UIFont.familyNames

        for familyName in fontFamilyNames {
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
        
        
        NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(keyboardDidHide),
                    name: UIResponder.keyboardWillHideNotification,
                    object: nil
                )
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(keyboardDidShow),
                    name: UIResponder.keyboardWillShowNotification,
                    object: nil
                )
        
        NotificationCenter.default.addObserver(self, selector: #selector(gotMessage), name: .gotMessage, object: nil)
          
    }
        @objc func keyboardDidHide() {
                UIView.animate(withDuration: 0.3) {
                    self.collectionView.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
                    
                }
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                self.keyboardView.transform = .identity
            }

            }

        @objc func gotMessage(_ notification: Notification) {
            if let userInfo = notification.userInfo as? [String: Any] {
                print("userInfo")
                
                DispatchQueue.main.async {
                    if let text = userInfo["text"] as? String {
                        self.messages.append(text)
                        self.collectionView.reloadData()
                    }
                }
            }
    }
    
                    
            @objc func keyboardDidShow(_ notification: Notification) {
                if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardRectangle = keyboardFrame.cgRectValue
                    let keyboardHeight = keyboardRectangle.height
                    
                collectionView.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: keyboardHeight, right: 0)
                    collectionView.scrollToItem(at: IndexPath(item: messages.count - 1, section: 0), at: .bottom, animated: true)
                    self.keyboardView.transform = CGAffineTransform(translationX: 10, y: -keyboardHeight - 30)
                }
            }
    
    
    
    
    
    lazy var sendButton: UIButton = {
       let btn = UIButton()
        btn.frame = CGRect(x: screen.width - 44, y: 0, width: 44, height: 44)
        btn.setBackgroundColor(.clear, for: .normal)
        btn.setBackgroundColor(.clear, for: .highlighted)
        btn.addTarget(self, action: #selector(send), for: .touchUpInside)
        btn.setImage(UIImage(named: "send")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 8, bottom: 8, right: 8)
        btn.imageView?.tintColor = .systemBlue
        return btn
    }()
    
    @objc func send() {
        if let text = textField.text {
            messages.append(text)
            collectionView.reloadData()
            textField.text = ""
            
        }
    }
    
    lazy var attachButton: UIButton = {
       let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn.setBackgroundColor(.clear, for: .normal)
        btn.setBackgroundColor(.clear, for: .highlighted)
        btn.addTarget(self, action: #selector(attach), for: .touchUpInside)
        btn.setImage(UIImage(named: "paperclip")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.imageView?.tintColor = .white
        btn.imageEdgeInsets = UIEdgeInsets(top: 15, left: 8, bottom: 8, right: 8)
        return btn
    }()
    
    @objc func attach() {
        
    }
    
    lazy var keyboardView: UIView = {
        let view = UIView(frame: CGRect(x: -10, y: screen.height - 44, width: screen.width, height: 85))
        view.backgroundColor = UIColor.darkGray
        return view
    }()
//
//    override var inputAccessoryView: UIView? {
//        return keyboardView
//    }
//
//    override var canBecomeFirstResponder: Bool {
//        return true
//    }

    
    lazy var textField: PaddedTextField = {
        let tf = PaddedTextField()
        tf.frame = CGRect(x: 44, y: 8, width: screen.width - 88, height: 40)
        tf.layer.cornerRadius = 12
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 2
        tf.attributedPlaceholder = NSAttributedString(string: "Write a message...", attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.2)])
        tf.backgroundColor = .black
//        tf.inputAccessoryView = keyboardView
        tf.keyboardAppearance = .dark
        tf.delegate = self
        return tf
    }()
 
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        becomeFirstResponder()becomeFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = .gray
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = .darkGray
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 14
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.alwaysBounceVertical = true
        cv.keyboardDismissMode = .interactive
        cv.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)

        return cv
        
    }()
    
    func setupCollectionView() {
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: "MessageCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        collectionView.addGestureRecognizer(tapGestureRecognizer)
    }
       @objc func hideKeyboard() {
        textField.resignFirstResponder()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MessageCell", for: indexPath) as! MessageCell
                
        if let font = app.font {
            let string = messages[indexPath.item]
            let textFrame = string.textFrame(font: app.font!)
            
            cell.containerView.frame = CGRect(x: -4, y: -4, width: textFrame.width + 8, height: textFrame.height + 8)
            
            cell.messageLabel.frame = CGRect(x: 4, y: 4, width: textFrame.width, height: textFrame.height)
            
            cell.containerView.frame = CGRect(x: screen.width - 40 - cell.containerView.frame.width, y: -4, width: textFrame.width + 8, height: textFrame.height + 8)

        }
        
        cell.messageLabel.text = messages[indexPath.item]
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let string = messages[indexPath.item]
        let textFrame = string.textFrame(font: app.font!)
       
        return CGSize(width: screen.width - 40, height: textFrame.height)
    }
}
