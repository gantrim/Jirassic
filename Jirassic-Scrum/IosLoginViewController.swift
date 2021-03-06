//
//  LoginViewController.swift
//  Jirassic
//
//  Created by Baluta Cristian on 25/05/15.
//  Copyright (c) 2015 Cristian Baluta. All rights reserved.
//

import UIKit

class IosLoginViewController: UIViewController {
	
	@IBOutlet private var _activityIndicator: UIActivityIndicatorView?
	@IBOutlet private var _butLogin: UIButton?
	@IBOutlet private var _emailTextField: UITextField?
	@IBOutlet private var _passwordTextField: UITextField?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		if PFUser.currentUser() != nil {
			self.performSegueWithIdentifier("ShowDaysSegue", sender: nil)
		}
		_emailTextField?.text = NSUserDefaults.standardUserDefaults().stringForKey("email")
		self.title = "Login"
		self.navigationController!.navigationBar.translucent = true
		self.navigationController!.navigationBar.barTintColor = UIColor(red: 240.0/255, green: 40.0/255, blue: 40.0/255, alpha: 0.2)
		self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
		self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func handleLogin(sender: UIButton) {
		
		_activityIndicator?.startAnimating()
		
		PFUser.logInWithUsernameInBackground(_emailTextField!.text, password:_passwordTextField!.text) {
			[weak self](user: PFUser?, error: NSError?) -> Void in
			if user != nil {
				self!._activityIndicator?.stopAnimating()
				NSUserDefaults.standardUserDefaults().setValue(self!._emailTextField!.text, forKey: "email")
				NSUserDefaults.standardUserDefaults().synchronize()
				self!.performSegueWithIdentifier("ShowDaysSegue", sender: nil)
			}
			else if let error = error {
				let errorString = error.userInfo?["error"] as? NSString
				RCLogO(errorString)
			}
		}
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
