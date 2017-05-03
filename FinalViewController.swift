//
//  FinalViewController.swift
//  Camera
//
//  Created by Petrus Reyes on 2/21/17.
//  Copyright © 2017 Brian Lee. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    
    @IBOutlet weak var firstImg: UIImageView!
    @IBOutlet weak var secondImg: UIImageView!
    
    var currentPatientData: PatientData? {
        didSet {
            self.loadViewIfNeeded()
            
            firstImg.image = currentPatientData?.imageOne
            secondImg.image = currentPatientData?.imageTwo
        }
    }
    
    weak var resultsDelegate: ResultsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func NextButton(_ sender: Any) {
        submitInformation()
    }
    
    fileprivate func shownextScreen(){

        self.performSegue(withIdentifier: "FinalVCToSubmissionComplete", sender: nil)
    }
    
    fileprivate func submitInformation(){
        
        var request = URLRequest(url: URL(string: "http://choa.engr.uga.edu/uploadInfo/patientInfo.php?")!)
        request.httpMethod = "POST"
        let testString = "name=\(currentPatientData!.name)&gender=\(currentPatientData!.gender)&age=\(currentPatientData!.age)&year=\(currentPatientData!.year)&month=\(currentPatientData!.month)&day=\(currentPatientData!.day)&height=\(currentPatientData!.height)&weight=\(currentPatientData!.weight)&bmi=\(currentPatientData!.BMI)&bC=\(currentPatientData!.breathingChoices)&sC=\(currentPatientData!.sleepChoices)&vC=\(currentPatientData!.visitChoices)&gC=\(currentPatientData!.geneticChoices)&q8=\(currentPatientData!.q8)&cC=\(currentPatientData!.cardiacChoices)&nC=\(currentPatientData!.neuroChoices)&mri=\(currentPatientData!.mri)&nCC=\(currentPatientData!.neuroContinued)&biC=\(currentPatientData!.birthChoices)&wC=\(currentPatientData!.weightChoices)&rC=\(currentPatientData!.recentChoices)&mC=\(currentPatientData!.prescriptions)"
        
        request.httpBody = testString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in guard let data = data, error == nil else{
            print("error=\(error)")
            return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response\(response)")
            }
            let responseString = String(data:data, encoding: .utf8)
            print("responseString = \(responseString)")
            
        }
        task.resume()
        
        submitPic1()
    }

    fileprivate func submitPic1(){
        
        
        
        guard var finalImg = currentPatientData?.imageOne else {
            
            self.showAlert(title: NSLocalizedString("An error occurred while trying to submit your first photo.", comment: "An error occurred while trying to submit your first photo."))
            return
        }
        let finalImage = finalImg.fixedOrientation()
        var r  = URLRequest(url: URL(string: "http://choa.engr.uga.edu/imagesTest/testImage.php")!)
        r.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        r.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        r.httpBody = createBody(boundary: boundary,
                                data: UIImageJPEGRepresentation(finalImage, 0.7)!,
                                mimeType: "image/jpg",
                                filename: "\(currentPatientData!.nameFinal)front.jpg")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: r as URLRequest) {
            (
            data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response , error
                == nil else {
                    print("error")
                    return
            }
            
            let dataString = String(data: data!, encoding:
                String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            print(dataString)
            
        }
        
        task.resume()
        

        print("image1 called")
        submitPic2()
        
    }
    
    fileprivate func submitPic2(){
        
        guard var finalImg = currentPatientData?.imageTwo else {
            
            self.showAlert(title: NSLocalizedString("An error occurred while trying to submit your first photo.", comment: "An error occurred while trying to submit your first photo."))
            return
        }
        let finalImage = finalImg.fixedOrientation()
        var r  = URLRequest(url: URL(string: "http://choa.engr.uga.edu/imagesTest/testImage.php")!)
        r.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        r.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        r.httpBody = createBody(boundary: boundary,
                                data: UIImageJPEGRepresentation(finalImage, 0.7)!,
                                mimeType: "image/jpg",
                                filename: "\(currentPatientData!.nameFinal)side.jpg")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: r as URLRequest) {
            (
            data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response , error
                == nil else {
                    print("error")
                    return
            }
            
            let dataString = String(data: data!, encoding:
                String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            print(dataString)
            
        }
        
        task.resume()
        
        
        print("image2 called")
        shownextScreen()
    }
    
    func createBody(boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let destination = segue.destination as? ResultsViewController
        {
            destination.currentPatientData = currentPatientData
            destination.resultsDelegate = resultsDelegate
        }
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}

///UUID 
// filename in newtwork request - should not have final name when sending.
// UUID and get parametes for network request
// JSON to send UUID back, 
