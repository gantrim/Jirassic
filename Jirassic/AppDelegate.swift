//
//  AppDelegate.swift
//  Jira Logger
//
//  Created by Cristian Baluta on 24/03/15.
//  Copyright (c) 2015 Cristian Baluta. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	
	@IBOutlet var window: NSWindow?
    @IBOutlet var popover: NSPopover?
    private var sleep: SleepNotifications?
	private let menu = MenuBarController()
	
	override init() {
		
		super.init()
		
		InitParse()
		
		self.menu.onMouseDown = {
			if (self.menu.iconView?.isSelected == true) {
				self.show()
			} else {
				self.hide()
			}
        }
        sleep = SleepNotifications()
        sleep?.computerWentToSleep = {
			
        }
        sleep?.computerWakeUp = {
			let existingTasks = sharedData.tasksForDayOfDate(NSDate())
			var scrumExists = false
			for task in existingTasks {
				if task.task_type == TaskType.Scrum.rawValue {
					scrumExists = true
					break
				}
			}
			if !scrumExists {
				let task = Tasks.taskFromDate(self.sleep?.lastSleepDate, dateEnd: NSDate(), type: TaskType.Scrum)
				task.saveToParseWhenPossible()
				NSNotificationCenter.defaultCenter().postNotificationName("newTaskWasAdded", object: task)
			}
        }
	}
	
	func show() {
		let icon = self.menu.iconView!
		let edge = NSRectEdge.MinY
		let rect = icon.frame
		self.popover?.showRelativeToRect(rect, ofView: icon, preferredEdge: edge);
	}
	
	func hide() {
		self.popover?.close()
	}
	
    func applicationDidFinishLaunching(aNotification: NSNotification) {
		let icon = self.menu.iconView!
		icon.mouseDown(NSEvent())
    }
	
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
}

