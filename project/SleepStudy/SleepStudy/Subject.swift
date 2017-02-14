//
//  Subject.swift
//  SleepStudy
//
//  Created by cscoi010 on 2017. 2. 13..
//  Copyright © 2017년 KKUMA. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class AllSubjects: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var prof: String
    @NSManaged var place: String
    
}
