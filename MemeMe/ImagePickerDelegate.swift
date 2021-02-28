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
    
    let initialTopText = "TOP"
    let initialBottomText = "BOTTOM"
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 50)!,
        .strokeWidth: -3.0
    ]
    
    func setupTextField(_ textField: UITextField, text: String) {
        textField.text = text
    }
    
}
