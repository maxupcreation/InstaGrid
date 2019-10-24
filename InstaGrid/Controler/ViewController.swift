//
//  ViewController.swift
//  InstaGrid
//
//  Created by Maxime on 16/10/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var currentButton : UIButton?
    
    @IBOutlet var buttonPicture: [UIButton]!
    @IBOutlet weak var SquarrePictureLayout: UIView!
    
    @IBAction func addPicture(_ sender: UIButton) {
        currentButton = sender
           let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           imagePicker.sourceType = .photoLibrary
           imagePicker.allowsEditing = false
           present (imagePicker,animated: true, completion: nil )
           }

    
    func imagePickerController(_ picker: UIImagePickerController,  didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        picker.dismiss(animated: true, completion: nil)
    if let image = info[.originalImage] as? UIImage {
        currentButton!.setImage(image, for: .normal)
        currentButton!.imageView?.contentMode = .scaleAspectFill
    
        
            
        }
    }
    

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
  
    
    @IBAction func buttonLayOut(_ sender: Any) {
        buttonPicture[1].isHidden = true
         buttonPicture[3].isHidden = false
   
        
    }
    
    @IBAction func buttonLayOut2(_ sender: Any) {
         buttonPicture[3].isHidden = true
        buttonPicture[1].isHidden = false
    }
    
    @IBAction func buttonLayout3(_ sender: Any) {
         buttonPicture[1].isHidden = false
        buttonPicture[3].isHidden = false
    }
    
    @IBAction func swipeForShare(sender: UISwipeGestureRecognizer) {
      
          
        }
        
    }
    

    

