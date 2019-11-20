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
    
    var statusbarOrientation : UIInterfaceOrientation? {
        get {
            if #available(iOS 13,*) {
                guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else {
                    #if DEBUG
                    fatalError("error")
                    #else
                    return nil
                    #endif
                }
                return orientation
            }
            return nil
        }
        
    }
    
    @IBOutlet weak var txtSwipeToShare: UILabel!
    @IBOutlet var buttonPicture: [UIButton]!
    @IBOutlet weak var squarrePictureLayout: UIView!
    @IBOutlet var buttonLayout: [UIButton]!
    
    /// Permet d'ajouter des photos via la library
    @IBAction private func didTapAddPicture(_ sender: UIButton) {
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
    
    ///Change l'image des buttons avec l'image choisi et l'ajoute à photo array.
    func imagePickerController(_ picker: UIImagePickerController,  didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            currentButton!.setImage(image, for: .normal)
            //ne deforme pas l'image et s'adapte à l'espace
            currentButton!.imageView?.contentMode = .scaleAspectFill
            photosArray.append(image)
        }
    }
    
    /// initialisation de la Gesture pour viewDidload
    func initalisationSwipeGesture() {
        let topSwipeGesture = UISwipeGestureRecognizer(target: self, action:#selector(SwipeActionUp(_:)))
        topSwipeGesture.direction = .up
        self.view.addGestureRecognizer(topSwipeGesture)
        
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action:#selector(SwipeActionLeft(_:)))
        leftSwipeGesture.direction = .left
        self.view.addGestureRecognizer(leftSwipeGesture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalisationSwipeGesture()
        
    }
    
    /// Petite animation (fondu) des buttons Layout lorsqu'on clique dessus
    func animateButtonLayOut(_ sender : UIButton) {
        currentButtonLayOut = sender
        self.currentButtonLayOut?.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.currentButtonLayOut?.alpha = 1
        }
    }
    
    /// changement en fonction du button layout selectionné
    func changeImageButtonLayoutIfSelected (_ sender : UIButton) {
        let tagButtonLayout = currentButtonLayOut?.tag
        switch tagButtonLayout {
        case 1: buttonLayout[0].setImage(#imageLiteral(resourceName: "Selected.png") , for: .normal)
        buttonLayout[2].setImage(nil, for: .normal)
        buttonLayout[1].setImage(nil, for: .normal)
        buttonPicture[0].isHidden = true
        buttonPicture[3].isHidden = false
        case 2: buttonLayout[1].setImage(#imageLiteral(resourceName: "Selected.png") , for: .normal)
        buttonLayout[0].setImage(nil, for: .normal)
        buttonLayout[2].setImage(nil, for: .normal)
        buttonPicture[0].isHidden = false
        buttonPicture[3].isHidden = true
        case 3: buttonLayout[2].setImage(#imageLiteral(resourceName: "Selected.png") , for: .normal)
        buttonLayout[0].setImage(nil, for: .normal)
        buttonLayout[1].setImage(nil, for: .normal)
        buttonPicture[0].isHidden = false
        buttonPicture[3].isHidden = false
            
        default : break
            
        }
    }
    
    ///Action lorsqu'on clique sur un button Layout
    @IBAction func buttonLayOut(_ sender: UIButton) {
        animateButtonLayOut(sender)
        changeImageButtonLayoutIfSelected(sender)
        
    }
    
    /// On partage les images transformées.
    func sharePhoto(image : UIImage){
        let share = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(share, animated: true, completion: nil)
        // Permet de faire l'animation inverse à la fermeture de la fenêtre de partage
        share.completionWithItemsHandler = {  activity, success, items, error in
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
        return false
    }
    
    /// Si l'orientation est en mode portrait on execute la suite : Si il y a au moins une image dans le tableau, on partage,  sinon on affiche un message d'erreur avec une petite animation.
    @IBAction func SwipeActionUp(_ sender: UISwipeGestureRecognizer) {
        guard let portrait = statusbarOrientation?.isPortrait else {return}
        if portrait {
            if controlImageButton() == true {
                animateSwipeAndShare()
            } else {
                UIView.animate(withDuration: 0.2){
                    self.txtSwipeToShare.text = "Vous n'avez pas choisi \n d'image à partager ! "
                    self.txtSwipeToShare.transform =
                        CGAffineTransform(translationX: 0 , y:-15)
                }
                UIView.animate(withDuration: 0.4){
                    self.txtSwipeToShare.transform = .identity
                }
            }
        }
    }
    
    /// Si l'orientation est en mode paysage on execute la suite : Si il y a au moins une image dans le tableau, on partage, sinon on affiche un message d'erreur avec une petite animation.
    @IBAction func SwipeActionLeft(_ sender: UISwipeGestureRecognizer) {
        guard let landscape = statusbarOrientation?.isLandscape else {return}
        if landscape {
            if controlImageButton() == true  {
                animateSwipeAndShare()
            } else {
                UIView.animate(withDuration: 0.2){ 
                    self.txtSwipeToShare.text = "Vous n'avez pas choisi \n d'image à partager ! "
                    self.txtSwipeToShare.transform =
                        CGAffineTransform(translationX:-15, y:0)
                }
                UIView.animate(withDuration: 0.4){
                    self.txtSwipeToShare.transform = .identity
                }
            }
        }
        
    }
    /// Animation lors du swipe et partage.
    func animateSwipeAndShare () {
        guard let image = squarrePictureLayout?.asImage() else {return}
        guard let portrait = statusbarOrientation?.isPortrait else {return}
        if portrait {
            UIView.animate(withDuration: 1) {
                
                self.squarrePictureLayout.transform = CGAffineTransform(translationX: 0, y: -200)
                self.squarrePictureLayout.alpha = 0
            }
        } else {
            UIView.animate(withDuration: 1){
                self.squarrePictureLayout.transform = CGAffineTransform(translationX: -200, y: 0)
                self.squarrePictureLayout.alpha = 0
                
            }
        }
        self.sharePhoto(image : image)
    }
}
///Transformation de la vue en image
extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds:bounds)
        return renderer.image { rendererContext in layer.render(in: rendererContext.cgContext)}
    }
    
}
