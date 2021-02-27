//
//  ViewController.swift
//  MemeMe
//
//  Created by Fabiana Petrovick on 20/02/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import Foundation
import UIKit

protocol ImagePickerDelegate {
    func imagePickerFotoSelecionada(_ image:UIImage)
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var compartilhar: UIBarButtonItem!
    @IBOutlet weak var top: UITextField!
    @IBOutlet weak var bottom: UITextField!
    @IBOutlet weak var memedImage: UIImageView!
    @IBOutlet weak var cancel: UIBarButtonItem!
    
    let imagePicker = UIImagePickerController()
    
    // MARK: - Atributos
    var TextBeingChangedfield: String = ""
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 50)!,
        NSAttributedString.Key.strokeWidth: -3.0
    ]
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  imagePicker.delegate = self
        top.text = "TOP"
        top.defaultTextAttributes = memeTextAttributes
        top.textAlignment = .center
        
        bottom.text = "BOTTOM"
        bottom.defaultTextAttributes = memeTextAttributes
        bottom.textAlignment = .center
        
        // self.view.bringSubviewToFront(top)
        self.top.delegate = self
        self.bottom.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        // compartilhar.isEnabled = UIBarButtonItem.isEqual(compartilhar)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //compartilhar.isEnabled = UIBarButtonItem.isEqual(compartilhar)
        unsubscribeFromKeyboardNotifications()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.contentMode = .scaleAspectFit
            imagePickerView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func pickAnImageAlbum(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageCamera(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    //funciona
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // picker.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
        print("aqi 2")
    }
    
    @IBAction func textFieldDidBeginEditing(_ sender: UITextField) {
        TextBeingChangedfield = sender.accessibilityIdentifier!
        print(TextBeingChangedfield)
        sender.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        TextBeingChangedfield = ""
        return false
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if(TextBeingChangedfield == "bottomLabel") {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if(TextBeingChangedfield == "bottomLabel") {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notication:Notification) -> CGFloat {
        let userInfo = notication.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @IBAction func compartilhar(_ sender: Any) {
        imagePicker.allowsEditing = false
        
        let items = [generateMemedImage()]
        let memedImage = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(memedImage, animated: true)
    }
    
    struct Meme {
        let top: String
        let bottom: String
        let originalImage: UIImage
        let memedImage: UIImageView
    }
    
    var completionWithItemsHandler: UIActivityViewController.CompletionWithItemsHandler?
    
    func save() {
        _ = Meme(top: top.text!, bottom: bottom.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
    }
    
    func generateMemedImage() -> UIImage {
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    @IBAction func cancel(_ sender: Any) {
        imagePickerView.image = nil
        top.text = ""
        bottom.text = ""
    }
}
