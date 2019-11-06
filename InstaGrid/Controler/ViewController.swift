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
    var photosArray = [UIImage]()
    
    @IBOutlet weak var txtSwipeToShare: UILabel!
    @IBOutlet var buttonPicture: [UIButton]!
    @IBOutlet weak var squarrePictureLayout: UIView!
    @IBOutlet var buttonLayout: [UIButton]!
    
    /// Permet d'ajouter des photos via la library
    @IBAction func addPicture(_ sender: UIButton) {
        currentButton = sender
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present (imagePicker,animated: true, completion: nil )
        //Animation et changement du texte à la fermture de la fenêtre de partage
        self.txtSwipeToShare.alpha = 0
        UIView.animate(withDuration: 0.5){
            self.txtSwipeToShare.text = "Swipe to share"
            self.txtSwipeToShare.alpha = 1
        }
    }
    
    
    ///Change l'image des buttons avec l'image choisi
    func imagePickerController(_ picker: UIImagePickerController,  didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            currentButton!.setImage(image, for: .normal)
            //ne deforme pas l'image et s'adapte à l'espace
            currentButton!.imageView?.contentMode = .scaleAspectFill
            photosArray.append(image)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeGesture = UISwipeGestureRecognizer(target: self, action:#selector(SwipeAction(_:)))
        swipeGesture.direction = .up
        self.view.addGestureRecognizer(swipeGesture)
    }
    
    /// Petite animation (fondu) des buttons Layout lorsqu'on clique dessus
    func animateButtonLayOut(_ sender : UIButton) {
        currentButtonLayOut = sender
        self.currentButtonLayOut?.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.currentButtonLayOut?.alpha = 1
        }
    }
    
    // Les 3 buttons Layout, on change l'image en fonction
    @IBAction func buttonLayOut(_ sender: UIButton) {
        animateButtonLayOut(sender); buttonLayout[2].setBackgroundImage(#imageLiteral(resourceName: "select1.png"), for: .normal)
        buttonPicture[1].isHidden = true
        buttonPicture[3].isHidden = false
    }
    @IBAction func buttonLayOut2(_ sender: UIButton) {
        animateButtonLayOut(sender);
        buttonLayout[1].setBackgroundImage(#imageLiteral(resourceName: "select2.png"), for: .normal)
        buttonPicture[3].isHidden = true
        buttonPicture[1].isHidden = false
    }
    @IBAction func buttonLayout3(_ sender: UIButton) {
        animateButtonLayOut(sender);
        buttonLayout[0].setBackgroundImage(#imageLiteral(resourceName: "select3.png"), for: .normal)
        buttonPicture[1].isHidden = false
        buttonPicture[3].isHidden = false
    }
    
    // On partage les images
    func sharePhoto(){
        imageButton = currentButton?.currentImage
        let activityViewController = UIActivityViewController(activityItems:[imageButton!], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
        
        // Permet de faire l'animation inverse à la fermeture de la fenêtre de partage
        activityViewController.completionWithItemsHandler = {  activity, success, items, error in
            UIView.animate(withDuration: 0.5, animations: {
                self.squarrePictureLayout.transform = .identity
                self.squarrePictureLayout.alpha = 1
            }, completion: nil)
        }
    }
    
    /// On controle s'il y a au moins une image dans le tableau pour partager
    func controlImageButton () -> Bool {
        if photosArray.count > 0 {
            return true
        }
        else {
            return false
        }
        return true
    }
    
    @IBAction func SwipeAction(_ sender: UISwipeGestureRecognizer) {
        if controlImageButton() == true  {
            animateSwipe()
        } else {
            UIView.animate(withDuration: 0.2){
                self.txtSwipeToShare.text = "Vous n'avez pas choisi d'image à partager ! "
                self.txtSwipeToShare.transform =
                    CGAffineTransform(translationX: 0 , y:-15)
            }
            UIView.animate(withDuration: 0.4){
                self.txtSwipeToShare.text = "Vous n'avez pas choisi d'image à partager ! "
                self.txtSwipeToShare.transform = .identity
            }
        }
    }
    /// Animation lors du swipe
    func animateSwipe () {
        UIView.animate(withDuration: 1) {
            
            self.squarrePictureLayout.transform = CGAffineTransform(translationX: 0, y: -200)
            self.squarrePictureLayout.alpha = 0
            self.sharePhoto()
        }
    }
}




