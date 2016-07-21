//
//  ViewController.swift
//  memegenerator
//
//  Created by Maciej Serwicki on 7/20/16.
//  Copyright © 2016 Maciej Serwicki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var memeStack: UIStackView!
    @IBOutlet weak var photoStack: UIStackView!
    
    @IBOutlet weak var cancelMemeButtonOutlet: UIButton!
    @IBOutlet weak var memeImageOutlet: MemeView!
    
    @IBOutlet weak var addMemeButtonOutlet: UIButton!
    
    @IBAction func addMemeButtonAction(sender: UIButton) {
    photoStack.hidden = !photoStack
        .hidden
    
    memeStack.hidden = !memeStack.hidden
    }
    
    @IBAction func cancelMemeButtonAction(sender: UIButton) {
        revertAll()
        switchButtons()
    }
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        cancelMemeButtonOutlet.hidden = true
        
            photoStack.hidden = true
            memeStack.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        photoStack.hidden = true
    }
    
    func revertAll() {
        //TODO: Clear text, and image
        memeImageOutlet.image = nil
        
            memeStack.hidden = true
    }

    @IBAction func browsePhotos(sender: UIButton) {
        imagePickerFromAlbum()
        photoStack.hidden = true
    }

    @IBAction func cameraPhoto(sender: UIButton) {
        imagePickerFromCamera()
        photoStack.hidden = true
      

    }

}



