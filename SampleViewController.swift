//
//  SampleViewController.swift
//  jay-working-v2
//
//  Created by Jay Patel on 2/26/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {

    var currentPatientData: PatientData?
    weak var resultsDelegate: ResultsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let destination = segue.destination as? FirstPicViewController
        {
            destination.currentPatientData = currentPatientData
            destination.resultsDelegate = resultsDelegate
        }
    }
}
