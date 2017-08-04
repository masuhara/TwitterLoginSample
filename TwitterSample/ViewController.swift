//
//  ViewController.swift
//  TwitterSample
//
//  Created by Masuhara on 2017/08/04.
//  Copyright © 2017年 net.masuhara. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginWithTwitter() {
        Twitter.sharedInstance().logIn(completion: { (session, error) in
            if session != nil {
                print("signed in as \(session!.userName), \(session!.userID)");
                
                let client = TWTRAPIClient(userID: session!.userID)
                client.requestEmail { email, error in
                    if email != nil {
                        print("signed in as \(session!.userName)");
                    } else {
                        print("error: \(error!.localizedDescription)");
                    }
                }
            } else {
                print("error: \(error!.localizedDescription)");
            }
        })
    }
    
    @IBAction func logout() {
        let store = Twitter.sharedInstance().sessionStore
        if let userID = store.session()?.userID {
            store.logOutUserID(userID)
        }
    }


}

