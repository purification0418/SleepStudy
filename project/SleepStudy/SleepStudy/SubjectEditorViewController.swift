//
//  addSubjectViewController.swift
//  SleepStudy
//
//  Created by cscoi010 on 2017. 2. 13..
//  Copyright © 2017년 KKUMA. All rights reserved.
//

import UIKit
import CoreData
import Foundation

public class SubjectEditorViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var context: NSManagedObjectContext!
    var subjects: [AllSubject]!
    
    public override func viewDidLoad() {
        self.subjects = fetchAllSubject()
    }
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var prof: UITextField!
    @IBOutlet weak var place: UITextField!
    
    @IBAction func saveSubject(_ sender: Any) {
        
        let newSubject = NSEntityDescription.insertNewObject(forEntityName: "Subject", into: context) as! AllSubject
        
        if let nameText = name.text {
            newSubject.name = nameText
        }
        
        if let profText = prof.text {
            newSubject.prof = profText
        }
        
        if let placeText = place.text {
            newSubject.place = placeText
        }
        
        do {
            try context.save()
            
        } catch {}
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func fetchAllSubject() -> [AllSubject] {
        let fetchRequest = NSFetchRequest<AllSubject>(entityName: "Subject")
        
        do {
            let subject = try context.fetch(fetchRequest)
            return subject
        } catch {}
        
        return []
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjects.count
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



