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

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 50)!,
        NSAttributedString.Key.strokeWidth: -3.0
    ]
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        //     super.viewDidLoad()
        imagePicker.delegate = self
        top.text = "Top"
        top.textAlignment = .center
        top.defaultTextAttributes = memeTextAttributes
        bottom.text = "bottom"
        bottom.textAlignment = .center
        bottom.defaultTextAttributes = memeTextAttributes
        // self.view.bringSubviewToFront(top)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // imagePickerView.contentMode = .scaleAspectFill
            imagePickerView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func pickAnImageAlbum(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        print("aqi album")
        
    }
    
    @IBAction func pickAnImageCamera(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        // dismiss(animated: true, completion: nil)
        print("aqi camera")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        //subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //          compartilhar.isEnabled = UIBarButtonItem()
        //  unsubscribeFromKeyboardNotifications()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // picker.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
        print("aqi 2")
    }
    
    @IBAction func textFieldBeginEditingTop(_ sender: UITextField) {
        top.text = ""
    }
    
    @IBAction func textFieldDidBeginEditingBottom(_ sender: UITextField) {
        bottom.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("TextField deve retornar")
        
        return true
    }
    
    //        @objc func keyboardWillShow(_ notification:Notification) {
    //            view.frame.origin.y -= getKeyboardHeight(notification)
    //            print("aqui show")
    //        }
    //
    //        @objc func keyboardWillHide(_ notification:Notification) {
    //            view.frame.origin.y += getKeyboardHeight(notification)
    //            print("aqui hide")
    //
    //        }
    //
    //        func getKeyboardHeight(_ notication:Notification) -> CGFloat {
    //            let userInfo = notication.userInfo
    //            let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
    //            return keyboardSize.cgRectValue.height
    //        }
    //
    //        func subscribeToKeyboardNotifications() {
    //            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    //            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    //            print("aqui subscribe")
    //
    //        }
    //
    //        func unsubscribeFromKeyboardNotifications() {
    //            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    //            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    //            print("aqui unsu")
    //
    //        }
    
    
    @IBAction func compartilhar(_ sender: Any) {
        imagePicker.allowsEditing = false
        //     generateMemedImage()
        
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
        let meme = Meme(top: top.text!, bottom: bottom.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        
        //        let items = [generateMemedImage()]
        //        let memedImage = UIActivityViewController(activityItems: items, applicationActivities: nil)
        //        //  present(memedImage, animated: true, completion: nil)
        //
        //        memedImage.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, arrayReturnedItems: [Any]?, error: NSError?) in
        //            if completed {
        //                print("deu certo")
        //                return
        //            } else {
        //                print("cancel")
        //            }
        //            if let shareError = error {
        //                print("error while sharing: \(shareError.localizesDescription)")
        //            }
        //        }
        //
        //        present(memedImage, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        imagePickerView.image = nil
    }
}
