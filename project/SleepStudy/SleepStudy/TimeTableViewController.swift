//
//  TimeTableViewController.swift
//  SleepStudy
//
//  Created by cscoi011 on 2017. 1. 24..
//  Copyright © 2017년 KKUMA. All rights reserved.
//

import UIKit

var curClass:Subject?

class TimeTableViewController: UITableViewController {

    //var subjects = Subject(name: "과목명", prof: "교수이름", place: "장소", time:[(day:0,startTime:0,endTime:0)])
    
    let subjects:[Subject] = [Subject(name: "조직행동론",prof: "전재욱",place: "LP 504호",time:[(0,840,915),(2,840,915)]),
                              Subject(name: "네트워크",prof: "민성기",place: "정보관 202호",time:[(1,540,615),(3,540,615)]),
                              Subject(name: "교직실무",prof: "김재덕",place: "교욱관 203호",time:[(0,600,730),(4,600,730)])]
    

    override func viewDidLoad() {
        curClass = subjects[0]
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //여기에 추가
        /*
       
        subjects[0].records += [Record(path: "/rec/file1.mov",date: "3월 2일",length: "01:23:45"),
                                Record(path: "/rec/file2.mov",date: "3월 4일", length: "01:23:45"),
                                Record(path: "/rec/file3.mov",date: "3월 9일", length: "01:23:45")]
        
        subjects[1].records += [Record(path: "/rec/file4.mov",date: "3월 3일", length: "01:23:45"),
                                Record(path: "/rec/file5.mov",date: "3월 5일", length: "01:23:45"),
                                Record(path: "/rec/file6.mov",date: "3월 10일", length: "01:23:45")]
        
        subjects[2].records += [Record(path: "/rec/file7.mov",date: "3월 2일", length: "01:23:45"),
                                Record(path: "/rec/file8.mov",date: "3월 6일", length: "01:23:45"),
                                Record(path: "/rec/file9.mov",date: "3월 9일", length: "01:23:45")]
*/
        //==========================================================================
        subjects[0].records[0].memos += [Memo(content: "서프라이즈 퀴즈 존재, 예습 복습 철저히 할 것",type: "퀴즈", time:880)]
        subjects[0].records[0].memos += [Memo(content: "기말고사는 범위 누적",type: "시험", time:900)]
        subjects[0].records[0].memos += [Memo(content: "다음 시간 교재 가져오기",type: "수업", time:908)]
        
        subjects[0].records[1].memos += [Memo(content: "ch02까지 읽어오기",type: "수업", time:912)]
        subjects[0].records[1].memos += [Memo(content: "3/31알까지 team 멤버 정하기",type: "팀플", time:913)]
        
        subjects[0].records[2].memos += [Memo(content: "3/15일 수업 휴강",type: "수업", time:845)]
        
        
        subjects[0].records[0].captures += [Capture(path: "/recent/capture1.jpg", time:909)]
        
        subjects[0].records[2].captures += [Capture(path: "/recent/capture2.jpg", time:900)]
        
        //==========================================================================

        subjects[1].records[0].memos += [Memo(content: "시험은 오픈북",type: "일반 메모", time:372),
                                         Memo(content: "수업 ppt 진행",type: "일반 메모", time:416),
                                         Memo(content: "교재 구글 검색",type: "일반 메모", time:610)]
        subjects[1].records[1].memos += [Memo(content: "블랙보드에 올라온 기사 읽어보기",type: "과제", time:3781)]
        subjects[1].records[2].memos += [Memo(content: "다음시간에 쪽지시험",type: "시험", time:2554)]
        
        subjects[1].records[0].captures += [Capture(path: "/cap/pic1.png", time:1233)]
        subjects[1].records[1].captures += [Capture(path: "/cap/pic2.png", time:2665)]
        subjects[1].records[2].captures += [Capture(path: "/cap/pic3.png", time:154)]

        //==========================================================================
        
        
        subjects[2].records[0].memos += [Memo(content: "교사의 연봉은 5000만원이다.",type: "일반 메모", time:321),
                                         Memo(content: "너는",type: "일반 메모", time:426),
                                         Memo(content: "누구니",type: "일반 메모", time:610)]
        subjects[2].records[1].memos += [Memo(content: "사명감을",type: "팀플", time:3731)]
        subjects[2].records[2].memos += [Memo(content: "열공을",type: "시험", time:2554)]
        
        subjects[2].records[0].captures += [Capture(path: "/cap/pic1.png", time:121)]
        subjects[2].records[1].captures += [Capture(path: "/cap/pic2.png", time:245)]
        subjects[2].records[2].captures += [Capture(path: "/cap/pic3.png", time:1554)]
         
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
        
        
        //오늘이 무슨 요일인지?
        
        
        //월 : 0 화 : 1 수 : 2 목 : 3 금 : 4
        //subjects에 들어있는 항목 검사 -> 오늘 듣는 수업인지? 조건문
        
        
        //몇 개의 row를 사용할건지
        //월요일 -> 2를 return
        return subjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        // Configure the cell...
        
        //위에서 선택한 과목을 각각 출력하는 부분
        let num = indexPath.row
        cell.textLabel?.text = subjects[num].name
        cell.detailTextLabel?.text = subjects[num].place
        
        return cell
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destVC = segue.destination as! RecordTableViewController
        let selectedIndex = self.tableView.indexPathForSelectedRow?.row
        let selected = subjects[selectedIndex!]
        
        destVC.selectedSubject = selected
    }
}
 
