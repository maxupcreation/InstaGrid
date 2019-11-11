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
    @IBOutlet weak var ButtonPicture2: UIButton!
    @IBOutlet weak var ButtonPicture3: UIButton!
    @IBOutlet weak var ButtonPicture4: UIButton!
    
    @IBAction func addPicture(_ sender: AnyObject) {
           let image = UIImagePickerController()
           image.delegate = self
           image.sourceType = UIImagePickerController.SourceType.photoLibrary
           image.allowsEditing = true
           self.present (image,animated: true )

       
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ButtonLayout2(_ sender: Any) {
        ButtonPicture3.isHidden = true
          ButtonPicture2.isHidden = false
    }
    @IBAction func ButtonLayout3(_ sender: Any) {
        ButtonPicture2.isHidden = true
        ButtonPicture3.isHidden = false
    }
    @IBAction func ButtonLayout1(_ sender: Any) {
       ButtonPicture2.isHidden = false
        ButtonPicture3.isHidden = false
    }
    
   
}

