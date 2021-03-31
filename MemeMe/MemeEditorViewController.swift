//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Fabiana Petrovick on 20/02/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import Foundation
import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {
    
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
    var savedMemedImage: UIImageView!
    
    let customImagePickerDelegate = CustomImagePickerDelegate()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customImagePickerDelegate.setupTextField(top, text: "TOP")
        customImagePickerDelegate.setupTextField(bottom, text: "BOTTOM")
        
        pickImageToolbar.accessibilityIdentifier = AcessibilityIdentifier.pickerImage
        cameraButton.accessibilityIdentifier = AcessibilityIdentifier.cameraButton
        
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
    
    // MARK: - IBActions
    @IBAction func getImage(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType =
            sender.accessibilityIdentifier == AcessibilityIdentifier.pickerImage ? .photoLibrary
            : .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func textFieldDidBeginEditing(_ sender: UITextField) {
        TextBeingChangedfield = sender.accessibilityIdentifier!
        sender.text = ""
    }
    
    @IBAction func share(_ sender: Any) {
        var memes: [Meme]! {
            let object = UIApplication.shared.delegate
            let appDegate = object as! AppDelegate
            return appDegate.memes
        }
        imagePicker.allowsEditing = false
        
        let items = [generateMemedImage()]
        let memedImage = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        memedImage.completionWithItemsHandler = {
            (activity, completed, items, error) in
            if completed {
                self.save()
            }
        }
        self.savedMemedImage = UIImageView(image: items[0])
        present(memedImage, animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func save() {
        let meme = Meme(top: top.text!, bottom: bottom.text!, originalImage: imagePickerView.image!, memedImage: savedMemedImage, memedUIImage: (savedMemedImage?.image)!)
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
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
    
    func hideUnhideToolbar(_ toolbar: UIToolbar) {
        toolbar.isHidden = !toolbar.isHidden
    }
    
    func generateMemedImage() -> UIImage {
        
        hideUnhideToolbar(bottomToolbar)
        hideUnhideToolbar(upperToolbar)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideUnhideToolbar(bottomToolbar)
        hideUnhideToolbar(upperToolbar)
        
        return memedImage
    }
    
    // MARK: -- Keyboard methods
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottom.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification) * (+1)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
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
