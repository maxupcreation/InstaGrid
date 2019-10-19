//
//  ViewController.swift
//  InstaGrid
//
//  Created by Maxime on 16/10/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    

    @IBOutlet weak var buttonPicture1: UIImageView!
    @IBOutlet weak var buttonPicture2: UIImageView!
    @IBOutlet weak var buttonPicture3: UIImageView!
    @IBOutlet weak var buttonPicture4: UIImageView!
    
    @IBAction func addPicture(_ sender: AnyObject) {
           let image = UIImagePickerController()
           image.delegate = self
           image.sourceType = .photoLibrary
           image.allowsEditing = true
           self.present (image,animated: true )
           }
    
    func imagePickerController(_ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
      buttonPicture1.image = info [.editedImage] as? UIImage
       dismiss(animated : true, completion : nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ButtonLayout3(_ sender: Any) {
           buttonPicture2.isHidden = true
           buttonPicture3.isHidden = false
    }
   
    @IBAction func ButtonLayout2(_ sender: Any) {
        buttonPicture3.isHidden = true
          buttonPicture2.isHidden = false
    }
   
    
    @IBAction func ButtonLayout1(_ sender: Any) {
       buttonPicture2.isHidden = false
        buttonPicture3.isHidden = false
    }
    
   
}

