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
    var currentButtonLayOut : UIButton?
    var imageButton : UIImage?
    
    
    @IBOutlet var buttonPicture: [UIButton]!
    @IBOutlet weak var squarrePictureLayout: UIView!
    @IBOutlet var buttonLayout: [UIButton]!
    
    
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
        let swipeGesture = UISwipeGestureRecognizer(target: self, action:#selector(SwipeAction(_:)))
        swipeGesture.direction = .up
        self.view.addGestureRecognizer(swipeGesture)
    }
    
    
    
    
    @IBAction func buttonLayOut(_ sender: UIButton) {
  buttonLayout[2].setImage(#imageLiteral(resourceName: "select1.png"), for: .normal)
        buttonLayout[1].setImage(#imageLiteral(resourceName: "Layout 2.png"), for: .normal)
        buttonLayout[0].setImage(#imageLiteral(resourceName: "Layout 3.png"), for: .normal)

        
    
        buttonPicture[1].isHidden = true
        buttonPicture[3].isHidden = false
        }
    
    @IBAction func buttonLayOut2(_ sender: UIButton) {
         buttonLayout[1].setImage(#imageLiteral(resourceName: "select2.png"), for: .normal)
        
        buttonLayout[2].setImage(#imageLiteral(resourceName: "Layout 1.png"), for: .normal)
        buttonLayout[0].setImage(#imageLiteral(resourceName: "Layout 3.png"), for: .normal)
        
        buttonPicture[3].isHidden = true
        buttonPicture[1].isHidden = false
    }
    
    @IBAction func buttonLayout3(_ sender: UIButton) {
 
        buttonLayout[0].setImage(#imageLiteral(resourceName: "select3.png"), for: .normal)
        
        buttonLayout[1].setImage(#imageLiteral(resourceName: "Layout 2.png"), for: .normal)
        buttonLayout[2].setImage(#imageLiteral(resourceName: "Layout 1.png"), for: .normal)
       
        buttonPicture[1].isHidden = false
        buttonPicture[3].isHidden = false
    }
    
    
    
    
    func sharePhoto(){
        imageButton = currentButton?.currentImage
        let activityViewController = UIActivityViewController(activityItems:[imageButton!], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
        activityViewController.completionWithItemsHandler = {  activity, success, items, error in
            UIView.animate(withDuration: 0.5, animations: {
                self.squarrePictureLayout.transform = .identity
                self.squarrePictureLayout.alpha = 1
            }, completion: nil)
        }
    }
    
    
    @IBAction func SwipeAction(_ sender: UISwipeGestureRecognizer) {
        animateSwipe()
    }
    
    func animateSwipe () {
        UIView.animate(withDuration: 1) {
            
            self.squarrePictureLayout.transform = CGAffineTransform(translationX: 0, y: -200)
            self.squarrePictureLayout.alpha = 0
            self.sharePhoto()
        }
        
    }
    
    
}




