//
//  ViewController.swift
//  Camera
//
//  Created by Jay Patel on 3/21/17.
//  Copyright © 2017 Brian Lee. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    var currentPatientData: PatientData?
    weak var resultsDelegate: ResultsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let destination = segue.destination as? SampleViewController
        {
            destination.currentPatientData = currentPatientData
            destination.resultsDelegate = resultsDelegate
        }
        
        if let destination = segue.destination as? FirstPicViewController
        {
            destination.currentPatientData = currentPatientData
            destination.resultsDelegate = resultsDelegate
        }
    }
}

