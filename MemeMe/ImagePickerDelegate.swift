//
//  ImagePickerDelegate.swift
//  MemeMe
//
//  Created by Fabiana Petrovick on 27/02/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.


import UIKit

protocol ImagePickerProtocolDelegate {
    func imagePickerFotoSelecionada(_ image:UIImage)
}

class CustomImagePickerDelegate: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    func setupTextField(_ tf: UITextField, text: String) {
        
        tf.defaultTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth : -4.0,
        ]
        tf.textColor = .white
        tf.tintColor = .white
        tf.textAlignment = .center
        tf.text = text
        tf.delegate = self
    }
}
