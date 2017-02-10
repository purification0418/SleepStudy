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

class ViewController: UIViewController {
    var AllSubject: [NSManagedObject] = []
    
    @IBOutlet weak var tableview: UITableView!
    @IBAction func addSubject(_ sender: AnyObject) {
        let alert = UIAlertController(title: "New Subject",
                                      message: "Add a new subject",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
                                        [unowned self] action in
                                        
                                        guard let textField = alert.textFields?.first, let nameToSave = textField.text else {
                                                return
                                        }
                                        
                                        self.name.append(nameToSave)
                                        self.tableview.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
        }
    
    var name: [String] = []
    
    func save(name: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Subject", in: managedContext)!
        
        let allsubject = NSManagedObject(entity: entity,insertInto: managedContext)
        
        // 3
       
        allsubject.setValue(name, forKeyPath: "name")
        
        // 4
        do {
            try managedContext.save()
            AllSubject.append(allsubject)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        curClass = AllSubject[0]
        super.viewDidLoad()

        title = "The List"
        tableview.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        //3
        do {
            AllSubject = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    
    }
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return AllSubject.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let allsubject = AllSubject[indexPath.row]
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "Cell",
                                              for: indexPath)
            cell.textLabel?.text = allsubject.value(forKeyPath:"name") as? String
            return cell
           
            cell.textLabel?.text =
                allsubject.value(forKeyPath: "name") as? String

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


