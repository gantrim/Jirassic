//
//  NoTasksController.swift
//  Jirassic
//
//  Created by Baluta Cristian on 03/05/15.
//  Copyright (c) 2015 Cristian Baluta. All rights reserved.
//

import Foundation

class NoTasks: NSObject {
	
	func showStartState() -> String {
		return "Good morning! Ready for your first task?"
	}
	
	func showFirstTaskState() -> String {
		return "When you finish tasks press +\nTime will be calculated for you automatically"
	}
}
