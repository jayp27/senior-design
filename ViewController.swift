//
//  ViewController.swift
//  jay-working-v2
//
//  Created by Jay Patel on 2/22/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import ResearchKit

class ViewController: UIViewController {

    @IBOutlet var patientInfo: UIButton!
    @IBOutlet var takePhotoB: UIButton!
    
    fileprivate var currentPatientData = PatientData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUIAvailability()
        
        //patientInfo.layer.borderWidth = 1
        patientInfo.layer.cornerRadius = 8
        
    //takePhotoB.layer.borderWidth = 1
        takePhotoB.layer.cornerRadius = 8
        //takePhotoB.layer.borderColor = UIColor(red: 238/255, green: 49/255, blue: 36/255, alpha: 1).cgColor
        
        patientInfo.layer.masksToBounds = false
        patientInfo.layer.shadowColor = UIColor.black.cgColor
        //UIColor(red: 204/255, green: 207/255, blue: 209/255, alpha: 1).cgColor
        patientInfo.layer.shadowOpacity = 0.4
        patientInfo.layer.shadowRadius = 8
        patientInfo.layer.shadowOffset = CGSize(width: 0, height: 5)
    //    patientInfo.layer.shadowPath = UIBezierPath(rect: patientInfo.bounds).cgPath
        patientInfo.layer.shouldRasterize = true
        
        
        takePhotoB.layer.masksToBounds = false
        takePhotoB.layer.shadowColor = UIColor.black.cgColor
        //UIColor(red: 204/255, green: 207/255, blue: 209/255, alpha: 1).cgColor
        takePhotoB.layer.shadowOpacity = 0.4
        takePhotoB.layer.shadowRadius = 8
        takePhotoB.layer.shadowOffset = CGSize(width: 0, height: 5)
     //   takePhotoB.layer.shadowPath = UIBezierPath(rect: patientInfo.bounds).cgPath
        takePhotoB.layer.shouldRasterize = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func PatientInformation(_ sender: AnyObject) {
        let taskViewController = ORKTaskViewController(task: PatientQuestions, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    fileprivate func updateUIAvailability()
    {
        if currentPatientData.imageName == nil
        {
            patientInfo.isHidden = false
            takePhotoB.isHidden = true
        }
        else
        {
            patientInfo.isHidden = true
            takePhotoB.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let nav = segue.destination as? UINavigationController, let destination = nav.viewControllers.first as? ViewController2
        {
            destination.currentPatientData = currentPatientData
            destination.resultsDelegate = self
        }
    }
}

extension ViewController: ResultsViewControllerDelegate {
    
    func resultsControllerDidFinishQuiz(results: ResultsViewController) {
        currentPatientData = PatientData() // Reset this
        updateUIAvailability()
    }
}

extension String{
    func removingWhitespace() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
}


extension ViewController: ORKTaskViewControllerDelegate {
    
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?){
        
        var visitChoices: String = ""
        var q8: String = ""
        var breathingChoices: String = ""
        var cardiacChoices: String = ""
        var neuroChoices: String = ""
        var neuroContinued: String = ""
        var sleepChoices: String = ""
        var geneticChoices: String = ""
        var birthChoices: String = ""
        var weightChoices: String = ""
        var recentChoices: String = ""
        var prescriptions: String = ""
        var name: String = ""
        var gender: String = ""
        var dob: NSDate? = nil
        var age: NSInteger = 1
        var year: NSInteger = 1
        var month: NSInteger = 1
        var day: NSInteger = 1
        var height = 0.0
        var weight = 0.0
        var mri = ""
        //BMI
        var heightInMeters = 0.0
        var weightInKg = 0.0
        var BMI = 0.0
        
        //
        
        switch (reason) {
        case .failed:
            print("Failed")
            break;
            
        case .discarded:
            print("Discarded")
            break;
            
        case .saved:
            print("Saved")
            break;
            
        case .completed:
            
            let taskResult = taskViewController.result.results
            for stepResults in taskResult! as! [ORKStepResult]
            {
                print("---")
                for result in stepResults.results!
                {
                    if result.identifier == "NameStep"
                    {
                        let nameResult = result as! ORKTextQuestionResult
                        name = nameResult.answer! as! String
                        print("Name: ",name)
                        currentPatientData.name = name
                        
                        
                    }
                    else if result.identifier == "Gender"
                    {
                        let genderResult = result as! ORKQuestionResult
                        let genderStr = genderResult.answer!
                        let str = genderStr as? [String]
                        for g in str!
                        {
                            gender = g
                            print("Gender: ",  g)
                        }
                        currentPatientData.gender = gender
                        
                        
                    }
                    else if result.identifier == "DOBStep"
                    {
                        let dobResult = result as! ORKDateQuestionResult
                        dob = dobResult.answer! as? NSDate
                        print("Date of birth: ",dob!)
                        
                        let now = NSDate()
                        let calendar: NSCalendar = NSCalendar.current as NSCalendar
                        let ageComponent = calendar.components(.year, from: dob as! Date, to: now as Date, options: [])
                        let ageC = ageComponent.year!
                        age = Int(ageC)
                        print(age)
                        
                        currentPatientData.age = age
                        
                        // let calendar = Calendar.current
                        year = calendar.component(.year, from: dob as! Date)
                        month = calendar.component(.month, from: dob as! Date)
                        day = calendar.component(.day, from: dob as! Date)
                        
                        currentPatientData.dobFinal = "\(month)\(day)\(year)"
                        
                        currentPatientData.year = year
                        currentPatientData.day = day
                        currentPatientData.month = month
                    }
                    else if result.identifier == "Height"
                    {
                        let heightResult = result as! ORKQuestionResult
                        height = heightResult.answer! as! Double
                        heightInMeters = height/100;
                        heightInMeters = heightInMeters*heightInMeters
                        print("Height: ",height)
                        print(type(of: height))
                        
                    }
                    else if result.identifier == "Weight"
                    {
                        let weightResult = result as! ORKQuestionResult
                        weight = weightResult.answer! as! Double
                        weightInKg = weight*0.45;
                        print("Weight: ", weight)
                        print(type(of: weight))
                    }
                    else if result.identifier == "breathing"
                    {
                        let breathingResult = result as! ORKChoiceQuestionResult
                        let breathing = breathingResult.answer!
                        
                        let str = breathing as? [String]
                        for i in str!
                        {
                            print("Breathing: ", i)
                            print(type(of: i))
                            breathingChoices += "\(i)"
                        }
                        // print(choices)
                    }
                    else if result.identifier == "SleepStep"
                    {
                        let sleepResult = result as! ORKChoiceQuestionResult
                        let sleep = sleepResult.answer!
                        let str = sleep as? [Int]
                        for i in str!
                        {
                            print("Sleep: ", i)
                            sleepChoices += "\(i)"
                        }
                    }
                    else if result.identifier == "Visit"
                    {
                        let healthResult = result as! ORKChoiceQuestionResult
                        let health = healthResult.answer!
                        let str = health as? [Int]
                        for i in str!
                        {
                            print("Visit: ", i)
                            visitChoices += "\(i)"
                        }
                    }
                    else if result.identifier == "Q8"
                    {
                        let healthResult = result as! ORKChoiceQuestionResult
                        let health = healthResult.answer!
                        let str = health as? [Int]
                        for i in str!
                        {
                            print("Q8: ", i)
                            q8 += "\(i)"
                        }
                    }
                    else if result.identifier == "CardiacConditions"
                    {
                        let healthResult = result as! ORKChoiceQuestionResult
                        let health = healthResult.answer!
                        let str = health as? [Int]
                        for i in str!
                        {
                            print("Cardiac: ", i)
                            cardiacChoices += "\(i)"
                        }
                    }
                    else if result.identifier == "Genetic"
                    {
                        let geneticResult = result as! ORKChoiceQuestionResult
                        let genetic = geneticResult.answer!
                        let str = genetic as? [String]
                        for i in str!
                        {
                            print("Genetic: ", i)
                            geneticChoices += "\(i)"
                        }
                    }
                    else if result.identifier == "Neurology"
                    {
                        let otherCResult = result as! ORKChoiceQuestionResult
                        let otherC = otherCResult.answer!
                        let str = otherC as? [Int]
                        for i in str!
                        {
                            print("Neuro: ", i)
                            neuroChoices += "\(i)"
                        }
                    }
                    else if result.identifier == "NeurologyC"
                    {
                        let otherCResult = result as! ORKChoiceQuestionResult
                        let otherC = otherCResult.answer!
                        let str = otherC as? [Int]
                        for i in str!
                        {
                            print("Neuro Continued: ", i)
                            neuroContinued += "\(i)"
                        }
                    }
                        
                    else if result.identifier == "birthHistory"
                    {
                        let familyHistoryResult = result as! ORKChoiceQuestionResult
                        let familyHistory = familyHistoryResult.answer!
                        let str = familyHistory as? [Int]
                        for i in str!
                        {
                            print("birthHistory: ", i)
                            birthChoices += "\(i)"
                        }
                    }
                    else if result.identifier == "weightHistory"
                    {
                        let physicalConditionResult = result as! ORKChoiceQuestionResult
                        let physicalCondition = physicalConditionResult.answer!
                        let str = physicalCondition as? [Int]
                        for i in str!
                        {
                            print("weight history: ", i)
                            weightChoices += "\(i)"
                        }
                        //  print(physicalChoices)
                    }
                    else if result.identifier == "recentHistory"
                    {
                        let physicalConditionResult = result as! ORKChoiceQuestionResult
                        let physicalCondition = physicalConditionResult.answer!
                        let str = physicalCondition as? [Int]
                        for i in str!
                        {
                            print("recent history: ", i)
                            recentChoices += "\(i)"
                        }
                        //  print(physicalChoices)
                    }
                    else if result.identifier == "MRI"
                    {
                        let mriResult = result as! ORKQuestionResult
                        let mriStr = mriResult.answer!
                        let str = mriStr as? [String]
                        for mriA in str!
                        {
                            print("MRI: ",  mriA)
                            mri = mriA
                        }
                        currentPatientData.mri = mri

                    }
                    else if result.identifier == "medsStep"
                    {
                        let medsResult = result as! ORKTextQuestionResult
                        prescriptions = medsResult.answer! as! String
                        print("Prescriptions: ",prescriptions)
                        currentPatientData.prescriptions = prescriptions
                    
                    }
                    
                }
            }
            BMI = weightInKg/heightInMeters
            
            var nameImage = name.removingWhitespace()
            let nameImageFinal = "\(nameImage.lowercased())\(year)\(month)\(day)"
            
            currentPatientData.imageName = nameImageFinal
            currentPatientData.nameFinal = nameImageFinal
            
            
            currentPatientData.height = height
            currentPatientData.weight = weight
            currentPatientData.breathingChoices = breathingChoices
            currentPatientData.sleepChoices = sleepChoices
            currentPatientData.geneticChoices = geneticChoices
            currentPatientData.BMI = BMI
            currentPatientData.visitChoices = visitChoices
            currentPatientData.q8 = q8
            currentPatientData.cardiacChoices = cardiacChoices
            currentPatientData.neuroChoices = neuroChoices
            currentPatientData.neuroContinued = neuroContinued
            currentPatientData.birthChoices = birthChoices
            currentPatientData.weightChoices = weightChoices
            currentPatientData.recentChoices = recentChoices
            currentPatientData.prescriptions = prescriptions
                        
            
            updateUIAvailability()
            break;
        }
        
        taskViewController.dismiss(animated: true, completion:nil)
    }
}

