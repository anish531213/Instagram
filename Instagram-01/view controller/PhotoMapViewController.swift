//
//  PhotoMapViewController.swift
//  Instagram-01
//
//  Created by Anish Adhikari on 2/23/18.
//  Copyright © 2018 Anish Adhikari. All rights reserved.
//

import UIKit
import Parse

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var postImageView: UIImageView!    
    @IBOutlet weak var captionField: UITextField!
    
    var postImage: UIImage! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentImagePickerController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentImagePickerController() {
        // Do any additional setup after loading the view.
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func clearView() {
        postImageView.image = UIImage(named: "tap_image")
        captionField.text = ""
        postImage = nil
    }
    
    @IBAction func postNewImage(_ sender: Any) {
        print ("presentImagePickerController")
        presentImagePickerController()
    }
    
    @IBAction func cancelPost(_ sender: Any) {
        clearView()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        self.postImage = editedImage
        // Do something with the images (based on your use case)
        
        postImageView.image = editedImage
        
        print ("image dismissed")
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

    @IBAction func postImageToParse(_ sender: Any) {
        if postImage == nil {
            presentAlert(msg: "Image Not Selected", description: "Sorry, you need to select an image to Post to Instagram")
        } else {
            //post image to parse
            print("post Image to parse")
//            let post_image = postImage
            Post.postUserImage(image: postImage, withCaption: captionField.text, withCompletion: { (success: Bool, error: Error?) in
                if success {
                    print("Successfully posted Image")
                } else {
                    print("error while posting image")
                }
            })
            clearView()
        }
    }
    
    func presentAlert(msg: String, description: String) {
        let alertController = UIAlertController(title: msg, message: description, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
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
