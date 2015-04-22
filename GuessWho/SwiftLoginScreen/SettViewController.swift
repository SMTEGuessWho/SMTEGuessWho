//
//  SettViewController.swift
//  GuessWho
//
//  Created by fhict on 22/04/15.
//  Copyright (c) 2015 SMTE32. All rights reserved.
//

import UIKit

class SettViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(sender: AnyObject) {
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        
        self.performSegueWithIdentifier("goto_login", sender: self)
    }

    @IBAction func settgames(sender: AnyObject) {
                self.performSegueWithIdentifier("settgames", sender: self)
    }
    
    
    @IBAction func settplayer(sender: AnyObject) {
                self.performSegueWithIdentifier("settstats", sender: self)
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
