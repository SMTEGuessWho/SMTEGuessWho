//
//  StartViewController.swift
//  GuessWho
//
//  Created by fhict on 17/04/15.
//  Copyright (c) 2015 fhict. All rights reserved.
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
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "GCell")
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegueWithIdentifier("goto_login", sender: self)
        } else {
            gebruiker = logeduser()
            getJson()
            tableView.reloadData()
        }
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
    
    @IBAction func settings(sender: AnyObject) {
        self.performSegueWithIdentifier("startsetting", sender: self)
    }
    

    
    @IBAction func stats(sender: AnyObject) {
        var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        prefs.setObject(gebruiker, forKey: "USERNAME")
        prefs.setInteger(1, forKey: "ISLOGGEDIN")
        prefs.synchronize()
        self.performSegueWithIdentifier("goto_stats", sender: self)
    }
    
    func getJson()
    {
        data = dataOfJson("http://athena.fhict.nl/users/i306956/matches1.php")
        print(data)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "GCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func dataOfJson(Url: String) -> NSArray {
        var get = "?id=\(gebruiker)"
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
                        if(enteredText == username)
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
                }
        })
        
        let action2 = UIAlertAction(title: "Random",
            style: UIAlertActionStyle.Default,
            handler: {[weak self]
                (paramAction:UIAlertAction!) in
                if let textFields = alertController?.textFields{
                    let theTextFields = textFields as [UITextField]
                    let enteredText = theTextFields[0].text
                    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()

                    
                    var rada : NSArray = []
                    var get = "?id=\(username)"
                    var url = "http://athena.fhict.nl/users/i306956/random1.php"
                    url = url + get
                    print(url)
                    var data : NSData = NSData(contentsOfURL: NSURL(string: url)!)!
                    
                    // Create another error optional
                    var jsonerror:NSError?
                    // We don't know the type of object we'll receive back so use AnyObject
                    let swiftObject:AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error:&jsonerror)!
                    // JSONObjectWithData returns AnyObject so the first thing to do is to downcast this to a known type
                    if let nsDictionaryObject = swiftObject as? NSDictionary {
                        if let swiftDictionary = nsDictionaryObject as Dictionary? {
                            var enemy : String = swiftDictionary["username"] as String
                            var get = "?id='\(username)'&id2='\(enemy)'"
                            var url = "http://athena.fhict.nl/users/i306956/newmatch.php"
                            url = url + get
                            print(url)
                            var data = NSData(contentsOfURL: NSURL(string: url)!)
                        }
                    }
                    else if let nsArrayObject = swiftObject as? NSArray {
                        if let swiftArray = nsArrayObject as Array? {
                            println(swiftArray)
                        }
                    }
                    
                }
        })
        
        
        alertController?.addAction(action)
        alertController?.addAction(action2)
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
            cell.textLabel?.text = "\(enemy)"
        }
        else
        {
            var enemy: String = maindata["Player1"] as String
            var matchid: String = maindata["MatchId"] as String
            cell.textLabel?.text = "\(enemy)"
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
