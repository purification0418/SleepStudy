//
//  ViewController.swift
//  SleepStudy
//
//  Created by cscoi011 on 2017. 1. 18..
//  Copyright © 2017년 KKUMA. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UIActionSheetDelegate {
    
    open var context: NSManagedObjectContext!
    var fetchedResultsController: NSFetchedResultsController<AllSubject>!
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
       //curClass = AllSubject[0]
        super.viewDidLoad()

        title = "All Subject"
        tableview.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
               
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("An error occurred")
            
        }
    }
  
    func configureFetchedResultsController() {
        let subjectFetchRequest = NSFetchRequest<AllSubject>(entityName: "Subject")
        let primarySortDescriptor = NSSortDescriptor(key: "prof", ascending: true)
        let secondarySortDescriptor = NSSortDescriptor(key: "place", ascending: true)
        subjectFetchRequest.sortDescriptors = [primarySortDescriptor, secondarySortDescriptor]
        
        self.fetchedResultsController = NSFetchedResultsController<AllSubject>(
            fetchRequest: subjectFetchRequest,
            managedObjectContext: self.context,
            sectionNameKeyPath: "subject.order",
            cacheName: nil)
        self.fetchedResultsController.delegate = self
        
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        return 0
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section]
            return currentSection.numberOfObjects
            
        }
        return 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indextPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indextPath)
        let subject = fetchedResultsController.object(at: indextPath)
        
        cell.textLabel?.text = subject.name
        cell.detailTextLabel?.text = subject.prof
        
        return cell
        
    }

    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let subject = fetchedResultsController.object(at: indexPath)
            confirmDeleteForSubject(subject)
        }
        
    }
    
    var subjectToDelete: AllSubject?
    
    func confirmDeleteForSubject(_ subject: AllSubject) {
        self.subjectToDelete = subject
        let confirmDeleteActionSheet = UIActionSheet(title: "Are you sure you want to permanently delete \(subject.name)?", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: "Delete")
        confirmDeleteActionSheet.show(in: self.view)
    }
    
    public func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 0 {
            deleteSubject()
        } else {

        }
    }
    
    func deleteSubject() {
        if let verseToDelete = self.subjectToDelete {
            self.context.delete(verseToDelete)
            do {
                try self.context.save()
            } catch {
            }
            
        self.subjectToDelete = nil
    }

}
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableview.beginUpdates()
    }
    
   public func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any,
        at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?) {
       
        switch type {
        case NSFetchedResultsChangeType.insert:
            if let insertIndexPath = newIndexPath {
                self.tableview.insertRows(at: [insertIndexPath], with: UITableViewRowAnimation.fade)
            }
        case NSFetchedResultsChangeType.delete:
            if let deleteIndexPath = indexPath {
                self.tableview.deleteRows(at: [deleteIndexPath], with: UITableViewRowAnimation.fade)
            }
        case NSFetchedResultsChangeType.update:
            if let updateIndexPath = indexPath {
                let cell = self.tableview.cellForRow(at: updateIndexPath)
                let subject = self.fetchedResultsController.object(at: updateIndexPath)
                
                cell?.textLabel?.text = subject.name
                cell?.detailTextLabel?.text = subject.place
            }
        case NSFetchedResultsChangeType.move:
            if let deleteIndexPath = indexPath {
                self.tableview.deleteRows(at: [deleteIndexPath], with: UITableViewRowAnimation.fade)
            }
            
            if let insertIndexPath = newIndexPath {
                self.tableview.insertRows(at: [insertIndexPath], with: UITableViewRowAnimation.fade)
            }
        }
    }
    
    public func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange sectionInfo: NSFetchedResultsSectionInfo,
        atSectionIndex sectionIndex: Int,
        for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            let sectionIndexSet = IndexSet(integer: sectionIndex)
            self.tableview.insertSections(sectionIndexSet, with: UITableViewRowAnimation.fade)
        case .delete:
            let sectionIndexSet = IndexSet(integer: sectionIndex)
            self.tableview.deleteSections(sectionIndexSet, with: UITableViewRowAnimation.fade)
        default:
            break
        }
    }
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableview.endUpdates()
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.SubjectEditorSegue.rawValue {
            let destination = segue.destination as! SubjectEditorViewController
            destination.context = self.context
        }
    }
    
}


extension Character {
    func unicodeScalarCodePoint() -> UInt32
    {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        
        return scalars[scalars.startIndex].value
    }
}

class Subject {
    
    var name:String = ""
    var id:String
    var prof:String = ""
    var place:String = ""
    
    var time:[(day:Int,startTime:Int,endTime:Int)]
    var records:Array<Record> = []
    
    init(name: String, prof: String, place: String, time:[(day:Int,startTime:Int,endTime:Int)]){
        self.name = name
        self.id = ""
        self.prof = prof
        self.place = place
        self.time = time
    }
}


class Memo{
    var content:String
    var type:String
    let time:Int
    
    init(content: String, type:String, time:Int){
        self.content = content
        self.type = type
        self.time = time
    }
}

class Capture{
    var path:String
    let time:Int
    
    init(path:String, time:Int){
        self.path = path
        self.time = time
    }
}

class Record{
    
    var path:URL
    var memos:Array<Memo>
    var captures:Array<Capture>
    let date:String
    let length:String
    var playednum: Int
    
    init(path:URL, date:String, length:String){
        self.path = path
        self.date = date
        self.memos = []
        self.captures = []
        self.length = length
        self.playednum = 0
        
    }
}

class Setting{
    
    var password:Data
    var theme:String
    var memotypes:Array<String>
    
    init(){
        password = Data()
        theme = ""
        memotypes = []
    }
    
}


