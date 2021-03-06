//
//  RecordTableViewController.swift
//  SleepStudy
//
//  Created by cscoi011 on 2017. 1. 24..
//  Copyright © 2017년 KKUMA. All rights reserved.
//

import UIKit

class RecordTableViewController: UITableViewController {

    var selectedSubject:Subject?
    

    var cellOrder : [(Int,Int,Int)] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor.clear
        if let subject = selectedSubject{
            for i in 0..<subject.records.count{
                cellOrder.append((0,i,0))
                for j in 0..<subject.records[i].memos.count{
                    cellOrder.append((1,i,j))
                }
            }
        }
        print(cellOrder.count)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var count:Int = (selectedSubject?.records.count)!
        for i in (selectedSubject?.records)!{
            count+=i.memos.count
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let num = indexPath.row
        
        let output = cellOrder[num]
        
        switch output.0 {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "fileList", for: indexPath) as! ListTableViewCell
            
            
            // Configure the cell...
            
            cell.listenImage.image = UIImage(named: "143-512")
            cell.dateLabel.text = (selectedSubject?.records[output.1].date)! + " 수업"
            cell.recordLength.text = "(" + (selectedSubject?.records[output.1].length)! + ")"
            cell.selectedRecord = selectedSubject?.records[output.1]
            cell.playProgress.progress=0
            cell.nowTime.text="00:00:00"
            cell.endTime.text="00:00:00"
            
            
            return cell
        case 1:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "memoList", for: indexPath) as! ListTableViewCell
            cell2.memoLabel.text = selectedSubject?.records[output.1].memos[output.2].content
            
            return cell2
        
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoList", for: indexPath)
            
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let num = indexPath.row
        let output = cellOrder[num]
        
        switch output.0{
        case 0:
            return 170.0
        case 1:
            return 45.0
        default:
            return 45.0
        }
        //Choose your custom row height
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
