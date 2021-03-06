//
//  LoginViewController.swift
//  Jirassic
//
//  Created by Baluta Cristian on 07/05/15.
//  Copyright (c) 2015 Cristian Baluta. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {
	
	@IBOutlet private var _label: NSTextField?
	@IBOutlet private var _emailTextField: NSTextField?
	@IBOutlet private var _passwordTextField: NSTextField?
	@IBOutlet private var _butLogin: NSButton?
	@IBOutlet private var _butCancel: NSButton?
	@IBOutlet private var _progressIndicator: NSProgressIndicator?
	
	var onLoginSuccess: (() -> ())?
	var handleCancelLoginButton: (() -> ())?
	var credentials: LoginCredentials {
		get {
			return (email: self._emailTextField!.stringValue,
				password: self._passwordTextField!.stringValue)
		}
		set {
			self._emailTextField!.stringValue = newValue.email
			self._passwordTextField!.stringValue = newValue.password
		}
	}
	var isLoggedIn: Bool = false
	
	class func instanceFromStoryboard() -> LoginViewController {
		let storyboard = NSStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateControllerWithIdentifier("LoginViewController") as! LoginViewController
		return vc
	}
	
    override func viewDidLoad() {
		
        super.viewDidLoad()
		
		let user = JRUser.currentUser()
		if user!.isLoggedIn {
			_butLogin?.title = "Logout"
			_label?.stringValue = "You are already logged in."
			self.credentials = (email: user!.email!, password: "")
		} else {
			_butLogin?.title = "Login or Signup"
			_label?.stringValue = "You are currently using the app in annonymous mode. By logging in you ensure you never lose the data and you can sync with the phone. Preferably to register with your work e-mail"
		}
    }
	
	func removeFromSuperview() {
		self.view.removeFromSuperview()
	}
	
	func showLoadingIndicator(show: Bool) {
		if show {
			_progressIndicator?.startAnimation(nil)
		} else {
			_progressIndicator?.stopAnimation(nil)
		}
	}
	
	
	// MARK: Actions
	
	@IBAction func handleLoginButton(sender: NSButton) {
		let login = Login(credentials: self.credentials)
		login.onLoginSuccess = {
			self.onLoginSuccess!()
		}
		login.login()
	}
	
	@IBAction func handleCancelButton(sender: NSButton) {
		self.handleCancelLoginButton!()
	}
	
}
