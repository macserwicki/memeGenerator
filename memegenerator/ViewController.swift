//
//  ViewController.swift
//  memegenerator
//
//  Created by Maciej Serwicki on 7/20/16.
//  Copyright © 2016 Maciej Serwicki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imgViewTest: UIImageView!

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var doneStack: UIStackView!
    
    @IBOutlet weak var photoStack: UIStackView!
    
    @IBOutlet weak var cancelMemeButtonOutlet: UIButton!
    @IBOutlet weak var memeImageOutlet: UIImageView!
    
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
        
        //Set Delegates
        imagePicker.delegate = self
        
        //UI Starting Point
        cancelMemeButtonOutlet.hidden = true
        addMemeButtonOutlet.hidden = false
        photoStack.hidden = true
        hideMemeStack()
        doneStack.hidden = true
        
        //Set IMPACT Font
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = NSTextAlignment.Center
        topTextField.textAlignment = NSTextAlignment.Center
    }

    
    func presentImagePicker() {
        self.presentViewController(imagePicker, animated: true, completion: nil)
        imagePicker.allowsEditing = false
        
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
          
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
        switchMemeStack()
        doneStack.hidden = !doneStack.hidden
        photoStack.hidden = true
    }
    
    func revertAll() {
        doneStack.hidden = true
        hideMemeStack()
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
            saveMeme()

            revertAll()
            memeImageOutlet.hidden = false
            memeImageOutlet.image = UIImage(named: "background_character")
       
        
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

    func hideMemeStack() {
        topTextField.hidden = true
        bottomTextField.hidden = true
        memeImageOutlet.hidden = true
    }
    
    func unHideMemeStack() {
        topTextField.hidden = !true
        bottomTextField.hidden = !true
        memeImageOutlet.hidden = !true
    }
    
    func switchMemeStack() {
            topTextField.hidden = !topTextField.hidden
            bottomTextField.hidden = !bottomTextField.hidden
            memeImageOutlet.hidden = !memeImageOutlet.hidden
    }
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -5.0
    ]
    
 
    func saveMeme() -> UIImage? {
        // make new meme
        if (topTextField.text != nil) && (bottomTextField.text != nil) && (memeImageOutlet.image != nil) {
            
             let meme = MemeObject(topText: topTextField.text!, bottomText: bottomTextField.text!, image: memeImageOutlet.image!)
            
            memeImageOutlet.addSubview(bottomTextField)
            memeImageOutlet.addSubview(topTextField)
           let meme2 = UIImage(view: memeImageOutlet)
           self.view.addSubview(bottomTextField)
            self.view.addSubview(topTextField)

            
           UIImageWriteToSavedPhotosAlbum(meme2, nil, nil, nil)
            
            return meme2
    }
        return nil
    }
    
}



