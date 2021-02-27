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
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 50)!,
        NSAttributedString.Key.strokeWidth: -3.0
    ]
}
