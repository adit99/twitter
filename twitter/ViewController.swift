//
//  ViewController.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/17/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import Social
import Accounts

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        /*var accountStore = ACAccountStore()
        var act = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        var acc  = ACAccount(accountType: act)
        accountStore.requestAccessToAccountsWithType(act, options: nil,  completion: <#ACAccountStoreRequestAccessCompletionHandler!##(Bool, NSError!) -> Void#>)
        println(acc)
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        CodePathTwitterClient.Instance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                //perform segway
            } else {
                //handle login error
            }
        }
    }
   
}

