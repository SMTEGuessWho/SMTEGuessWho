//
//  StartViewController.swift
//  SimpleTableView
//
//  Created by fhict on 17/04/15.
//  Copyright (c) 2015 Andrei Puni. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var tableView: UITableView!
    var data: NSArray = []
    
    var gebruiker :String = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gebruiker = logeduser()
        getJson()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "GCell")
    }
    
    func logeduser() -> String
    {
        var username:String = "none"
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn == 1) {
            username =  prefs.valueForKey("USERNAME") as NSString
        }
        
        return username
    }
    
    func getJson()
    {
        data = dataOfJson("http://athena.fhict.nl/users/i306956/matches1.php")
        print(data)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "GCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    @IBAction func backhome(sender: AnyObject) {
                self.performSegueWithIdentifier("backto_home", sender: self)
    }
    
    func dataOfJson(Url: String) -> NSArray {
        var get = "?id=\(logeduser())"
        var url = Url
        url = url + get
        print(url)
        var data = NSData(contentsOfURL: NSURL(string: url)!)
        return (NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSArray)
    }
    
    
    @IBAction func newgame(sender: AnyObject) {
        
        var username : String = gebruiker
        
        var alertController:UIAlertController?
        alertController = UIAlertController(title: "New Game",
            message: "Enter the Username below :",
            preferredStyle: .Alert)
        
        alertController!.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                textField.placeholder = "username"
        })
        username = gebruiker
        let action = UIAlertAction(title: "Challenge",
            style: UIAlertActionStyle.Default,
            handler: {[weak self]
                (paramAction:UIAlertAction!) in
                if let textFields = alertController?.textFields{
                    let theTextFields = textFields as [UITextField]
                    let enteredText = theTextFields[0].text
                        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    if(enteredText == "")
                    {
                        
                    }
                    else
                    {
                    var get = "?id='\(username)'&id2='\(enteredText)'"
                        var url = "http://athena.fhict.nl/users/i306956/newmatch.php"
                        url = url + get
                        print(url)
                        var data = NSData(contentsOfURL: NSURL(string: url)!)
                    }
                }
        })
        
        
        alertController?.addAction(action)
        self.presentViewController(alertController!,
            animated: true,
            completion: nil)

    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("GCell") as UITableViewCell
        
        var maindata = (data[indexPath.row] as NSDictionary)
        var test: String = maindata["Player1"] as String
        if(gebruiker == test)
        {
            var enemy: String = maindata["Player2"] as String
            var matchid: String = maindata["MatchId"] as String
            cell.textLabel?.text = "\(enemy), \(matchid)"
        }
        else
        {
            var enemy: String = maindata["Player1"] as String
            var matchid: String = maindata["MatchId"] as String
            cell.textLabel?.text = "\(enemy), \(matchid)"
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        var cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        var maindata = (data[indexPath.row] as NSDictionary)
        var mid = maindata["MatchId"] as String
        var enem = " "
        if(gebruiker == maindata["Player1"] as String)
        {
        enem = maindata["Player2"] as String
        }
        else
        {
        enem = maindata["Player1"] as String
        }
        
        var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        prefs.setObject(gebruiker, forKey: "USERNAME")
        prefs.setInteger(1, forKey: "ISLOGGEDIN")
        prefs.setObject(mid, forKey: "MATCHID")
        prefs.setObject(enem, forKey: "ENEMY")
        prefs.synchronize()
        
        
        self.performSegueWithIdentifier("goto_gam", sender: self)
        println("You selected cell #\(mid)!")

        
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
