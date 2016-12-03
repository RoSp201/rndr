//
//  CreateViewController.swift
//  RndrApp
//
//  Created by William Smith on 11/12/16.
//  Modified by Robert Spark 11/28/16.
//  Copyright © 2016 William Smith and Robert Spark. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    // MARK: Properties
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTextField: UITextView!
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var contentSegmentController: UISegmentedControl!
    
    var imagePicker = UIImagePickerController()
    var edits = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        postTextField.delegate = self
        registerForKeyboardNotifications()
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(CreateViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        self.contentSegmentController.setTitle("Camera Roll", forSegmentAt: 0)
        self.contentSegmentController.setTitle("GIF", forSegmentAt: 1)
        self.contentSegmentController.setTitle("Object", forSegmentAt: 2)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //registerForKeyboardNotifications()
    }
    
    // MARK: Keyboard handler
    func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        edits = true
        print("\nKeyboard was shown.\n")
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let delta = keyboardSize!.height - 150
        let oframe = self.stackview.frame
        self.stackview.frame = CGRect(x: oframe.minX, y: oframe.minY - delta, width: oframe.width, height: oframe.height)
    }
    
    func keyboardWillBeHidden(_ notification: NSNotification){
        //Once keyboard disappears, restore original positions
        print("Hide keyboard now.")
        self.view.endEditing(true)
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let delta = keyboardSize!.height - 150
        let oframe = self.stackview.frame
        self.stackview.frame = CGRect(x: oframe.minX, y: oframe.minY + delta, width: oframe.width, height: oframe.height)
    }
    
    func didTapView(){
        if edits == true {
            self.view.endEditing(true)
            print("clicked out of keyboard")
            edits = false
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        postTextField = textView
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"  // Recognizes enter key in keyboard
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print(textView.text)
        print("textViewDidEndEditing")
    }
    
    // MARK: Actions
    
    @IBAction func postButtonPressed(_ sender: Any) {
        //let dataManager = DataManager()
        //dataManager.changeMetadataAsync(newMetadata: "1")
        print("Post button pushed. This is for debugging.")
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        //let dataManager = DataManager()
        //dataManager.changeMetadataAsync(newMetadata: "0")
        print("Cancel button pressed. This is for debugging.")
    }
    
    @IBAction func letdataManagerDataManagerpostButtonPressed(_ sender: Any) {
    }
    
    @IBAction func importPhotoButtonPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    // MARK: Image Picker
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        postImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
        print((info))
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
