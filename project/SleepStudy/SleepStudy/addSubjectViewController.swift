//
//  addSubjectViewController.swift
//  SleepStudy
//
//  Created by cscoi010 on 2017. 2. 13..
//  Copyright © 2017년 KKUMA. All rights reserved.
//

import UIKit
import CoreData

class addSubjectViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var prof: UITextField!
    
    @IBOutlet weak var place: UITextField!
    
    @IBOutlet weak var status: UILabel!
    
    @IBAction func saveSubject(_ sender: Any) {
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "AllSubjects", in: managedObjectContext)
        let subject = AllSubject(entity: entityDescription!, insertInto: managedObjectContext)
        
        subject.name = name.text!
        subject.prof = prof.text!
        subject.place = place.text!
        
        do{
            try managedObjectContext.save()
            name.text = ""
            prof.text = ""
            place.text = ""
            status.text = "Subject Saved"
            
        } catch let error {
            status.text = error.localizedDescription
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
