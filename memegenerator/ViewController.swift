//
//  ViewController.swift
//  memegenerator
//
//  Created by Maciej Serwicki on 7/20/16.
//  Copyright © 2016 Maciej Serwicki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var doneStack: UIStackView!
    
    @IBOutlet weak var memeStack: UIStackView!
    @IBOutlet weak var photoStack: UIStackView!
    
    @IBOutlet weak var cancelMemeButtonOutlet: UIButton!
    @IBOutlet weak var memeImageOutlet: MemeView!
    
    @IBOutlet weak var addMemeButtonOutlet: UIButton!
    
    @IBAction func addMemeButtonAction(sender: UIButton) {
    photoStack.hidden = !photoStack
        .hidden

    }
    
    @IBAction func cancelMemeButtonAction(sender: UIButton) {
        displayAlert(title: "Reset Meme?", message: "Are you sure you would like to start over?")
    }
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        cancelMemeButtonOutlet.hidden = true
        
            photoStack.hidden = true
            memeStack.hidden = true
            doneStack.hidden = true
        
    }

    
    func presentImagePicker() {
        self.presentViewController(imagePicker, animated: true, completion: nil)
        imagePicker.allowsEditing = false
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImageOutlet.contentMode = .ScaleAspectFit
            memeImageOutlet.image = pickedImage
            switchButtons()
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerFromCamera() {
        imagePicker.sourceType = .Camera
        presentImagePicker()
    }
    
    func imagePickerFromAlbum() {
        imagePicker.sourceType = .PhotoLibrary
        presentImagePicker()
    }
    
    func switchButtons() {
        addMemeButtonOutlet.hidden = !addMemeButtonOutlet.hidden
        cancelMemeButtonOutlet.hidden = !cancelMemeButtonOutlet.hidden
        memeStack.hidden = !memeStack.hidden
        doneStack.hidden = !doneStack.hidden
        photoStack.hidden = true
    }
    
    func revertAll() {
        doneStack.hidden = true
        memeStack.hidden = true
        addMemeButtonOutlet.hidden = false
        cancelMemeButtonOutlet.hidden = true
        photoStack.hidden = true

    }

    @IBAction func browsePhotos(sender: UIButton) {
        imagePickerFromAlbum()
    }

    @IBAction func cameraPhoto(sender: UIButton) {
        imagePickerFromCamera()
    }
    
    @IBAction func doneButtonPressed(sender: UIButton) {
        //TODO: Share/Download Meme
    }

    
    func displayAlert(title title: String, message: String) -> Void {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
      
            
            alert.addAction((UIAlertAction(title: "Reset", style: .Default, handler: { (action) -> Void in
                self.revertAll()
                self.dismissViewControllerAnimated(true, completion: {
                })
        
        })))
        
        
        alert.addAction((UIAlertAction(title: "Don't Reset", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
        
    }

    
    
}



