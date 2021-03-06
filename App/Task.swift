//
//  Task.swift
//  Jira Logger
//
//  Created by Baluta Cristian on 25/03/15.
//  Copyright (c) 2015 Cristian Baluta. All rights reserved.
//

import Foundation

let kDateStartKey = "date_task_started"
let kDateFinishKey = "date_task_finished"
let kNotesKey = "notes"
let kIssueKey = "issue_type"
let kTypeKey = "task_type"
let kUserKey = "user"

public class Task: PFObject, PFSubclassing, TaskProtocol {
	
	dynamic public var date_task_started: NSDate? {
		get {
			if let value: AnyObject = objectForKey(kDateStartKey) {
				switch value {
				case _ as NSNull:
					return nil
				case let value as NSDate:
					return value
				default:
					fatalError("unexpected object")
				}
			}
			return nil
		}
		set {
			if let value = newValue {
				setObject(value, forKey: kDateStartKey)
			} else {
				setObject(NSNull(), forKey: kDateStartKey)
			}
		}
	}
	
    dynamic public var date_task_finished: NSDate? {
        get {
			if let value: AnyObject = objectForKey(kDateFinishKey) {
				switch value {
					case _ as NSNull:
						return nil
					case let value as NSDate:
						return value
					default:
						fatalError("unexpected object")
				}
			}
			return nil
        }
        set {
			if let value = newValue {
				setObject(value, forKey: kDateFinishKey)
			} else {
				setObject(NSNull(), forKey: kDateFinishKey)
			}
        }
    }
    
    dynamic public var notes: String? {
        get {
            return objectForKey(kNotesKey) as! String?
        }
        set {
            setObject(newValue!, forKey: kNotesKey)
        }
    }
	
	dynamic public var issue_type: String? {
		get {
			return objectForKey(kIssueKey) as! String?
		}
		set {
			setObject(newValue!, forKey: kIssueKey)
		}
	}
	
	dynamic public var task_type: NSNumber? {
		get {
			return objectForKey(kTypeKey) as! NSNumber?
		}
		set {
			setObject(newValue!, forKey: kTypeKey)
		}
	}
	
	var user: JRUser? {
		get {
			return objectForKey(kUserKey) as! JRUser?
		}
		set {
			setObject(newValue!, forKey: kUserKey)
		}
	}
	
	public class func parseClassName() -> String {
		return "Task"
	}
	
	
	// Helpers
	
	func saveToParseWhenPossible() {
		self.saveEventually { (success, error) -> Void in
			RCLogO(success)
		}
	}
}
