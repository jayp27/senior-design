//
//  FirstPicViewController.swift
//  Camera
//
//  Created by  Jay Patel on 3/21/17.
//  Copyright © 2017 Brian Lee. All rights reserved.
//

import UIKit

class FirstPicViewController: UIViewController {
    
    @IBOutlet weak var photo1: UIImageView!
    
    var currentPatientData: PatientData?
    weak var resultsDelegate: ResultsViewControllerDelegate?
    
    fileprivate var hasPickedPhoto: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(FirstPicViewController.choosePictureAction(sender:)))
        imageTapGesture.numberOfTapsRequired = 1
        photo1.addGestureRecognizer(imageTapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        
        
        guard currentPatientData?.imageOne != nil else {
            
            self.showAlert(title: NSLocalizedString("Please select a photo before continuing.", comment: "Please select a photo before continuing."))
            return false
        }
        
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let destination = segue.destination as? SecondPicViewController
        {
            currentPatientData?.imageOne = photo1.image
            destination.currentPatientData = currentPatientData
            destination.resultsDelegate = resultsDelegate
        }
    }
}


extension FirstPicViewController: UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func choosePictureAction(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = false
        
        let alertController = UIAlertController(title: "Add a picture", message: "Choose From", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
            
        }
        let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            alertController.addAction(photosLibraryAction)
        }
        
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage]  as? UIImage{
            self.photo1.image = image
           
        }else if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.photo1.image = image
        }
        currentPatientData?.imageOne = photo1.image
        //put it in on datamodel. update segue
    
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
