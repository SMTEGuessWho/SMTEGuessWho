//
//  ChatViewController.swift
//  GuessWho
//
//  Created by fhict on 18/04/15.
//  Copyright (c) 2015 fhict. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var messages: Int = 2
    
    @IBOutlet weak var tableView: UITableView!
    
    var data: NSArray = []
    
    var gebruiker :String = " "
    
    var enemy : String = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var mid =  prefs.valueForKey("MATCHID") as NSString
        
        self.chatmessages("http://athena.fhict.nl/users/i306956/chatbox3.php", matchid: mid )
        
        
        var get = "?id=\(mid)"
        var url = "http://athena.fhict.nl/users/i306956/player1.php"
        url = url + get
        print(url)
        var player1 = NSData(contentsOfURL: NSURL(string: url)!)
        
        var datastring: String = NSString(data: player1!, encoding:NSUTF8StringEncoding)!
        

        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        
        gebruiker = logeduser()
        getJson()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "GCell")
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Right) {
            self.performSegueWithIdentifier("backtogame", sender: self)

        }
    }
    
    
    
    @IBOutlet weak var chattext: UITextField!
    
    
    func chatmessages(Url: String, matchid: String){
        var get = "?id=\(matchid)"
        var url = Url
        url = url + get
        print(url)
        var player1 = NSData(contentsOfURL: NSURL(string: url)!)
        
        var datastring: String = NSString(data: player1!, encoding:NSUTF8StringEncoding)!
        var username : String = "asror"
        
        if("{\"player\":\"\(username)\"}" == datastring)
        {
            messages = 1
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
    
    func getJson()
    {
        data = dataOfJson("http://athena.fhict.nl/users/i306956/chatbox1.php")
        print(data)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "GCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func dataOfJson(Url: String) -> NSArray {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var mid =  prefs.valueForKey("MATCHID") as NSString
        var get = "?id=\(mid)"
        var url = Url
        url = url + get
        print(url)
        var data = NSData(contentsOfURL: NSURL(string: url)!)
        return (NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSArray)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    
    @IBAction func backtogame(sender: AnyObject) {
        self.performSegueWithIdentifier("backtogame", sender: self)
    }
    
    
    @IBAction func sendmessage(sender: AnyObject) {
        
        if(messages > 0)
        {
            if(chattext.text == "")
            {
                let alert = UIAlertView()
                alert.title = "Fill"
                alert.message = "Message cant be empty"
                alert.addButtonWithTitle("OK")
                alert.show()
            
            }
            else
            {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var mid =  prefs.valueForKey("MATCHID") as NSString
        enemy =  prefs.valueForKey("ENEMY") as NSString
        var escapedString : String = chattext.text.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        var get = "?id=\(mid)&id2='\(gebruiker)\'&id3='\(escapedString)'"
        var url = "http://athena.fhict.nl/users/i306956/chatbox2.php"
        url = url + get
        print(url)
                //let newString = escapedString.stringByReplacingOccurrencesOfString("%20", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
                
                
        var data = NSData(contentsOfURL: NSURL(string: url)!)

                
            if(messages == 1)
            {
                var get = "?id='\(enemy)'&id2=\(mid)"
                var url = "http://athena.fhict.nl/users/i306956/turn1.php"
                url = url + get
                print(url)
                var data = NSData(contentsOfURL: NSURL(string: url)!)
            }
            
        messages = messages - 1
                getJson()
            }
            
        }
        else
        {
            let alert = UIAlertView()
            alert.title = "No More"
            alert.message = "You used up your questions!"
            alert.addButtonWithTitle("OK")
            alert.show()
        }
        
        tableView.reloadData()
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("GCell") as UITableViewCell
        
        
        var maindata = (data[indexPath.row] as NSDictionary)
        var playerchat : String = maindata["player"] as String
        var meschat : String = maindata["message"] as String
        if (playerchat == gebruiker)
        {
            cell.textLabel?.textAlignment = NSTextAlignment.Right
            cell.textLabel?.text = "\(playerchat) : " + "\(meschat)"  
        }
        else
        {
            cell.textLabel?.text = "\(playerchat) : " + "\(meschat)"
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        var cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        var maindata = (data[indexPath.row] as NSDictionary)

        println("You selected cell #\(indexPath.row)!")
        
        
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
