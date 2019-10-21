//
//  ViewController.swift
//  InstaGrid
//
//  Created by Maxime on 16/10/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
  
    
    @IBOutlet var buttonPicture: [UIButton]!
    
    @IBAction func addPicture(_ sender: UIButton) {
           let image = UIImagePickerController()
           image.delegate = self
           image.sourceType = .photoLibrary
           image.allowsEditing = true
           self.present (image,animated: true )
           }
    
    func imagePickerController(_ picker: UIImagePickerController,_ sender : UIButton ,  didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[.originalImage] as? UIImage {
            for button in buttonPicture {
                if button.tag == 0 {
                    buttonPicture[0].setImage(image, for: .normal)
            }
          else if button.tag == 1 {
                    buttonPicture[1].setImage(image, for: .normal)
                }
          else if button.tag == 2 {
                    buttonPicture[2].setImage(image, for: .normal)
        }
            else if button.tag == 3 {
                      buttonPicture[3].setImage(image, for: .normal)
                }
            }
        }
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
  
    
   
  
}
