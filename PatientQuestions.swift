//
//  PatientQuestions.swift
//  jay-working-v2
//
//  Created by Jay Patel on 2/22/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation
import ResearchKit

public var PatientQuestions: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    //Intructions step
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Instructions"
    instructionStep.text = "Please answer these questions to the best of your ability. By beginning, you understand that data will be shared with authorized hospital personnel."
    steps += [instructionStep]
    
    
   
    //Question name
    let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
    nameAnswerFormat.multipleLines = false
    //    nameAnswerFormat.isOptional = false
    let nameQuestionStepTitle = "Name of the Patient"
    let nameQuestionStep = ORKQuestionStep(identifier: "NameStep", title: nameQuestionStepTitle, answer: nameAnswerFormat)
    nameQuestionStep.isOptional = false
    steps += [nameQuestionStep]
    
    
    //gender
    let genderQuestionTitle = "Gender"
    let gendertextChoices = [ ORKTextChoice(text: "Male", value: "Male" as NSString),
                              ORKTextChoice(text: "Female", value: "Female" as NSString) ]
    let genderAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: gendertextChoices)
    let genderQuestionStep = ORKQuestionStep(identifier: "Gender", title: genderQuestionTitle, answer: genderAnswerFormat)
    genderQuestionStep.isOptional = false
    steps += [genderQuestionStep]
    
    
    //Date of birth
    let dateOfBirthFormat : ORKDateAnswerFormat = ORKDateAnswerFormat.dateAnswerFormat()
    let dateOfBirthStepTitle = "Date of Birth"
    let dateOfBirthStep = ORKQuestionStep(identifier: "DOBStep", title: dateOfBirthStepTitle, answer: dateOfBirthFormat)
    dateOfBirthStep.isOptional = false
    steps += [dateOfBirthStep]
    
    
    //height
    let heightQuestionTitle = "Patient's Height"
    let heightFormat = ORKHeightAnswerFormat()
    let heightQuestionStep = ORKQuestionStep(identifier: "Height", title:
        heightQuestionTitle, text: "If not sure choose to your best knowledge", answer: heightFormat)
    heightQuestionStep.isOptional = false
    steps += [heightQuestionStep]
    
    
    //Weight
    let weightAnswerFormat = ORKNumericAnswerFormat(style: ORKNumericAnswerStyle.integer, unit: "Pounds", minimum: 0, maximum: 500)
    let weightQuestionStepTitle = "Patients Weight (lbs)"
    let weightQuestionStep = ORKQuestionStep(identifier: "Weight", title: weightQuestionStepTitle, answer: weightAnswerFormat)
    weightQuestionStep.isOptional = false
    steps += [weightQuestionStep]
    
    //reason to Visit
    let visitStepTitle1 = "Select the reason for you visit"
    let visitChoices = [
        ORKTextChoice(text: "Radiologic Imaging (MRI/CT/Nuclear Medicine Scan or Other)", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Surgery or other procedure (ex. Renal Biopsy or Joint Injection)", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Child has cancer and needs Lumbar Puncture (LP) or Bone Marrow biopsy/aspiration", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Other", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
        
    ]
    let visitAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: visitChoices)
    let visitStep = ORKQuestionStep(identifier: "Visit", title: visitStepTitle1, answer: visitAnswerFormat)
    visitStep.text = "Select all that apply"
    visitStep.isOptional = false
    steps += [visitStep]
    
    //MRI
    let mriQuestionTitle = "If MRI does your child have any metal in the body or orthodontic appliances in the mouth?"
    let mritextChoices = [ ORKTextChoice(text: "Yes", value: "Yes" as NSString),
                           ORKTextChoice(text: "No", value: "No" as NSString),
                           ORKTextChoice(text: "Not applicable", value: "Not-Applicable" as NSString) ]
    let mriAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: mritextChoices)
    let mriQuestionStep = ORKQuestionStep(identifier: "MRI", title: mriQuestionTitle, answer: mriAnswerFormat)
    mriQuestionStep.isOptional = false
    steps += [mriQuestionStep]
    
    
    //question8
    let q8StepTitle1 = "Which of the following apply to your child"
    let q8Choices = [
        ORKTextChoice(text: "Has undergone sedation in the past", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Needed general anesthesia in the past", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Never had sedation/anesthesia", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Any family history of complications with anesthesia", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "I don't know", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "None", value: 5 as NSCoding & NSCopying & NSObjectProtocol)
        
        ]
    let q8AnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: q8Choices)
    let q8Step = ORKQuestionStep(identifier: "Q8", title: q8StepTitle1, answer: q8AnswerFormat)
    q8Step.text = "Select all that apply"
    q8Step.isOptional = false
    steps += [q8Step]
    
    
    //breathing
    let breathingStepTitle1 = "How is your child's breathing"
    let breathingChoices = [
        ORKTextChoice(text: "Recent history or current stridor", value: "0" as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Recent history or current wheezing", value: "1" as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Recent evidence of lower respiratory tract infection (Pneumonia, Bronchilolitis)", value: "2" as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Recent respiratory infection last 4 weeks < age 1 year", value: "3" as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Recent respiratory infection last 2 weeks > age 1 year", value: "4" as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Evidence of recent purulent rhinitis or sinusitis", value: "5" as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Airway Malacia (Laryngomalacia, Tracheamalacia or Bronchomalacia)", value: "6" as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Has severe scoliosis compromising breathing", value: "7" as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Home oxygen use", value: "8" as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "H/o cystic fibrosis", value: "9" as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "H/o asthma", value: "A" as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Chronic cough", value: "B" as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Chronic lung disease (CLD)", value: "C" as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "None", value: "D" as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let breathingAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: breathingChoices)
    let breathingStep = ORKQuestionStep(identifier: "breathing", title: breathingStepTitle1, answer: breathingAnswerFormat)
    breathingStep.text = "Select all that apply"
    breathingStep.isOptional = false
    steps += [breathingStep]
    
    
  
    
    //cardiac condition
    let heartConditionTitle = "Cardiac History"
    let heartConditionChoices = [
        ORKTextChoice(text: "History of any cardiac disease", value: 0 as
            NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Congestive heart failure", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Myocarditis/Cardiomyopathy", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "History of arrhythmias or on therapy for arrhythmia", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Has history of REPAIRED congenital heart disease", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Has history of UNREPAIRED congenital heart disease", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "History of pulmonary hypertension", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "History of vascular ring", value: 7 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "History of heart disease and his/her recent health status in deteriorating", value: 8 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "None", value: 9 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let heartConditionAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: heartConditionChoices)
    let heartConditionStep = ORKQuestionStep(identifier: "CardiacConditions", title: heartConditionTitle, answer: heartConditionAnswerFormat)
    heartConditionStep.text = "Select all that apply"
    heartConditionStep.isOptional = false
    steps += [heartConditionStep]
    
    //neurology
    let neurologyConditionTitle = "Neurology"
    let neurologyConditionChoices = [
        ORKTextChoice(text: "Child has been diagnosed with an Autism Spectrum disorder", value: 0 as
            NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Inability to control secretions", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Not allowed to feed by mouth due to aspiration risk", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Weakness or hypotonia", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Difficulty swallowing", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "None", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        
        ]
    let neurologyConditionAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: neurologyConditionChoices)
    let neurologyConditionStep = ORKQuestionStep(identifier: "Neurology", title: neurologyConditionTitle, answer: neurologyConditionAnswerFormat)
    neurologyConditionStep.text = "Select all that apply"
    neurologyConditionStep.isOptional = false
    steps += [neurologyConditionStep]
    
    //neurology continued
    let neurologyCConditionTitle = "Neurology continued"
    let neurologyCConditionChoices = [
        ORKTextChoice(text: "Able to sit up without support", value: 0 as NSCoding &
            NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Able to hold head up", value: 1 as NSCoding & NSCopying
            & NSObjectProtocol),
        ORKTextChoice(text: "Able to crawl", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Able to stand", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Able to walk", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Not applicable", value: 5 as NSCoding & NSCopying & NSObjectProtocol)
        
        ]
    let neurologyCConditionAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: neurologyCConditionChoices)
    let neurologyCConditionStep = ORKQuestionStep(identifier: "NeurologyC", title: neurologyCConditionTitle, answer: neurologyCConditionAnswerFormat)
    neurologyCConditionStep.text = " If your child is under 4 years old"
    neurologyCConditionStep.isOptional = false
    steps += [neurologyCConditionStep]
    
    
    //sleep apnea
    let sleepStepTitle1 = "How is your child sleeping?"
    let sleepChoices = [
        ORKTextChoice(text: "Recent sleep study positive for obstructive sleep apnea (OSA)", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Wakes up to breathe or has respiratory pauses during sleep", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Snores loudy OR if infant has noisy breathing during sleep", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Assumes bizarre positions during sleep (example neck hyperextension)", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "I have an appointment for sleep study", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "None", value: 5 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let sleepAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: sleepChoices)
    let sleepStep = ORKQuestionStep(identifier: "SleepStep", title: sleepStepTitle1, answer: sleepAnswerFormat)
    sleepStep.text = "Select all that apply"
    sleepStep.isOptional = false
    steps += [sleepStep]
    
    //question about genetic condition history, multiple
    let geneticQuestionTitle = "Has your child been diagnosed with any of the following"
    let geneticChoices = [
        ORKTextChoice(text: "Down Syndrome", value: "0" as NSCoding & NSCopying &
            NSObjectProtocol),
        ORKTextChoice(text: "Pierre Robin", value: "1" as NSCoding & NSCopying &
            NSObjectProtocol),
        ORKTextChoice(text: "Mitochondrial disorder", value: "2" as NSCoding &
            NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Beckwith Wiedman", value: "3" as NSCoding & NSCopying
            & NSObjectProtocol),
        ORKTextChoice(text: "Goldenhars", value: "4" as NSCoding & NSCopying &
            NSObjectProtocol),
        ORKTextChoice(text: "Apert", value: "5" as NSCoding & NSCopying &
            NSObjectProtocol),
        ORKTextChoice(text: "Mucopolysaccharidosis", value: "6" as NSCoding &
            NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Treacher Collins", value: "7" as NSCoding & NSCopying &
            NSObjectProtocol),
        ORKTextChoice(text: "Achondroplasia", value: "8" as NSCoding & NSCopying &
            NSObjectProtocol),
        ORKTextChoice(text: "Williams Syndrome", value: "9" as NSCoding & NSCopying
            & NSObjectProtocol),
        ORKTextChoice(text: "Duchenne Muscular Dystropy", value: "A" as NSCoding & NSCopying & NSObjectProtocol  ),
        ORKTextChoice(text: "None", value: "B" as NSCoding & NSCopying & NSObjectProtocol )
    ]
    let geneticAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: geneticChoices)
    let geneticStep = ORKQuestionStep(identifier: "Genetic", title: geneticQuestionTitle, answer: geneticAnswerFormat)
    geneticStep.text = "Select all that apply"
    geneticStep.isOptional = false
    steps += [geneticStep]
    
    //birthHistory
    let birthHistoryTitle = "Regarding your child's birth history"
    let birthHistoryChoices = [
        ORKTextChoice(text: "Premature birth (born <37 weeks gestational age)", value: 0 as NSCoding &
            NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Born at 32-37 weeks gestation", value: 1 as NSCoding &
            NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Born at 28-32 weeks gestation", value: 2 as NSCoding & NSCopying &
            NSObjectProtocol),
        ORKTextChoice(text: "Born < 28 weeks gestation", value: 3 as NSCoding & NSCopying &
            NSObjectProtocol),
        ORKTextChoice(text: "My child's post-conceptual age is less than 60 weeks", value: 4 as NSCoding & NSCopying &
            NSObjectProtocol),
        ORKTextChoice(text: "My child was intubated and mechanically ventilated in the NICU", value: 5 as NSCoding & NSCopying &
            NSObjectProtocol),
        ORKTextChoice(text: "My child was on oxygen after birth", value: 6 as NSCoding & NSCopying &
            NSObjectProtocol),
        ORKTextChoice(text: "None", value: 7 as NSCoding & NSCopying &
            NSObjectProtocol)
    
    ]
    let birthHistoryAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: birthHistoryChoices)
    let birthHistoryStep = ORKQuestionStep(identifier: "birthHistory", title: birthHistoryTitle, answer: birthHistoryAnswerFormat)
    birthHistoryStep.text = "Select all that apply"
    birthHistoryStep.isOptional = false
    steps += [birthHistoryStep]

    //weight
    let weightHistoryTitle = "Regarding my child's weight"
    let weightHistoryChoices = [
        ORKTextChoice(text: "History of recent weight gain", value: 0 as NSCoding &
            NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "History of steroid use for a long time", value: 1 as NSCoding &
            NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "My child's anesthesia/sedation has been difficult in the past due to body weight", value: 2 as NSCoding & NSCopying &
            NSObjectProtocol),
        ORKTextChoice(text: "Obtaining intravenous access (IV) has been difficult in the past due to body weight", value: 3 as NSCoding & NSCopying &
            NSObjectProtocol),
        ORKTextChoice(text: "None", value: 4 as NSCoding & NSCopying &
            NSObjectProtocol)
    ]
    let weightHistoryAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: weightHistoryChoices)
    let weightHistoryStep = ORKQuestionStep(identifier: "weightHistory", title: weightHistoryTitle, answer: weightHistoryAnswerFormat)
    weightHistoryStep.text = "Select all that apply"
    weightHistoryStep.isOptional = false
    steps += [weightHistoryStep]
    
    //recentActivity
    let recentQuestionTitle = "My child was recently:"
    let recenttextChoices = [
        ORKTextChoice(text: "Admitted to the hospital", value:0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Had a visit to the Emergency department in past 48 hours", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Not applicable", value: 2 as NSCoding & NSCopying &
                                NSObjectProtocol)
    ]
    let recentAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: recenttextChoices)
    let recentQuestionStep = ORKQuestionStep(identifier: "recentHistory", title: recentQuestionTitle, answer: recentAnswerFormat)
    recentQuestionStep.isOptional = false
    steps += [recentQuestionStep]
    
    
    //prescriptions
    let medsAnswerFormat = ORKTextAnswerFormat(maximumLength: 500)
    medsAnswerFormat.multipleLines = true
    //    nameAnswerFormat.isOptional = false
    let medsQuestionStepTitle = "What prescriptions if any is the child taking"
    let medsQuestionStep = ORKQuestionStep(identifier: "medsStep", title: medsQuestionStepTitle, answer: medsAnswerFormat)
    medsQuestionStep.text = "type \"None\" otherwise "
    medsQuestionStep.isOptional = false
    steps += [medsQuestionStep]
    
    
    
    
    //Completion
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Information Recorded"
    summaryStep.text = "Please finish the remaining steps. Press Done to Continue"
    steps += [summaryStep]
    
    //-----------------------------------------------------------------------
    
    return ORKOrderedTask(identifier: "PatientInformation", steps: steps)
    
}
