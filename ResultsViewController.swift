//
//  ResultsViewController.swift
//  jay-working-v2
//
//  Created by Jay Patel on 2/26/17.
//  Copyright © 2017 Jay. All rights reserved.
//
//  oprhaned data


// delagate  - callback - whenever something happens notify other object


import UIKit

protocol ResultsViewControllerDelegate: class {
    
    func resultsControllerDidFinishQuiz(results: ResultsViewController)
}

class ResultsViewController: UIViewController {
    
    var currentPatientData: PatientData?
    weak var resultsDelegate: ResultsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnToMainPagePressed(_ sender: Any) {
        sleep(3)
        resultsDelegate?.resultsControllerDidFinishQuiz(results: self)
        self.dismiss(animated: true, completion: nil)
        
    }
}

//package json
//data blod of json
//JSONsirlation- swift 
//dictionary- hashmap , creation shortcuts
//assign object to 
//http body 
//dic to data using json -> directly put in request httpbody

