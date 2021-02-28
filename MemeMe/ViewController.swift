//
//  ViewController.swift
//  MemeMe
//
//  Created by Fabiana Petrovick on 20/02/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var share: UIBarButtonItem!
    @IBOutlet weak var top: UITextField!
    @IBOutlet weak var bottom: UITextField!
    @IBOutlet weak var memedImage: UIImageView!
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var upperToolbar: UIToolbar!
    @IBOutlet weak var pickImageToolbar: UIBarButtonItem!
    
    // MARK: - Atributos
    var TextBeingChangedfield: String = ""
    let imagePicker = UIImagePickerController()
    var completionWithItemsHandler: UIActivityViewController.CompletionWithItemsHandler?
    
    let customImagePickerDelegate = CustomImagePickerDelegate()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customImagePickerDelegate.setupTextField(top, text: customImagePickerDelegate.initialTopText)
        customImagePickerDelegate.setupTextField(bottom, text: customImagePickerDelegate.initialBottomText)
        
        top.defaultTextAttributes = customImagePickerDelegate.memeTextAttributes
        top.textAlignment = .center
        
        bottom.defaultTextAttributes = customImagePickerDelegate.memeTextAttributes
        bottom.textAlignment = .center
        
        pickImageToolbar.accessibilityIdentifier = "PickerImage"
        cameraButton.accessibilityIdentifier = "CameraButton"
        
        self.top.delegate = self
        self.bottom.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func presentPickerViewController(source: UIImagePickerController.SourceType) {
        imagePicker.allowsEditing = false
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    @IBAction func getImage(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType =
            sender.accessibilityIdentifier == "PickerImage" ? .photoLibrary
            : .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func textFieldDidBeginEditing(_ sender: UITextField) {
        TextBeingChangedfield = sender.accessibilityIdentifier!
        sender.text = ""
    }
    
    @IBAction func share(_ sender: Any) {        
        imagePicker.allowsEditing = false
        
        let items = [generateMemedImage()]
        let memedImage = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        memedImage.completionWithItemsHandler = {
            (activity, completed, items, error) in
            if completed {
                self.save()
            }
        }
        present(memedImage, animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        imagePickerView.image = nil
        customImagePickerDelegate.setupTextField(top, text: customImagePickerDelegate.initialTopText)
        customImagePickerDelegate.setupTextField(bottom, text: customImagePickerDelegate.initialBottomText)
    }
    
    func save() {
        _ = Meme(top: top.text!, bottom: bottom.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.contentMode = .scaleAspectFit
            imagePickerView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        TextBeingChangedfield = ""
        return false
    }
    
    func generateMemedImage() -> UIImage {
        
        bottomToolbar.isHidden = true
        upperToolbar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        bottomToolbar.isHidden = false
        upperToolbar.isHidden = false
        
        return memedImage
    }
    
    // MARK: -- Keyboard methods
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
}
