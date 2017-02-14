//
//  DataHelper.swift
//  SleepStudy
//
//  Created by cscoi010 on 2017. 2. 14..
//  Copyright © 2017년 KKUMA. All rights reserved.
//

import Foundation
import CoreData

public class DataHelper {
    let context: NSManagedObjectContext
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    public func seedSubjects() {
        let subjects = [(name: "조직행동론",prof: "전재욱",place: "LP 504호"),
                        (name: "네트워크",prof: "민성기",place: "정보관 202호"),
                        (name: "교직실무",prof: "김재덕",place: "교욱관 203호")]
        
        for subject in subjects {
            let newSubject = NSEntityDescription.insertNewObject(forEntityName: "Subject", into: context) as! AllSubjects
            newSubject.name = subject.name
            newSubject.prof = subject.prof
            newSubject.place = subject.prof
        }
        
        do {
            try context.save()
        } catch _ {
        }
        
    }
    
    public func printAllSubject() {
        let subjectFetchRequest = NSFetchRequest<AllSubjects>(entityName: "Subject")
        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        subjectFetchRequest.sortDescriptors = [primarySortDescriptor]
        
        let allSubjects = try! context.fetch(subjectFetchRequest)
        
        for subject in allSubjects {
            print("Subject Name: \(subject.name)\nPlace: \(subject.place) \n-------\n", terminator: "")
        }
    }
    
  }

  
