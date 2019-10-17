//
//  ViewController.swift
//  InstaGrid
//
//  Created by Maxime on 16/10/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var buttonPicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addPicture(_ sender: AnyObject) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present (image,animated: true )
        
        func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
            if  let image = info[.originalImage] as? UIImage {
                buttonPicture.image = image
            }
            self.dismiss(animated: true, completion: nil)
    }
    
}
}

