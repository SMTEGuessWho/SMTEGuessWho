//
//  StatsViewController.swift
//  GuessWho
//
//  Created by fhict on 20/04/15.
//  Copyright (c) 2015 SMTE32. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var tableView: UITableView!
    var data: NSArray = []
    
    var gebruiker :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gebruiker = logeduser()
        Playername.text = "\(gebruiker) stats"
        getJson()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "GCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn == 1) {
            gebruiker =  prefs.valueForKey("USERNAME") as NSString
        }
    }
    
    @IBAction func statstart(sender: AnyObject) {
        self.performSegueWithIdentifier("statstart", sender: self)
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
        data = dataOfJson("http://athena.fhict.nl/users/i306956/PlayerStats1.php")
        print(data)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "GCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func dataOfJson(Url: String) -> NSArray {
        var get = "?id='\(gebruiker)'"
        var url = Url
        url = url + get
        print(url)
        var data = NSData(contentsOfURL: NSURL(string: url)!)
        return (NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSArray)
    }
    
    @IBAction func statsett(sender: AnyObject) {
        self.performSegueWithIdentifier("statsett", sender: self)
        
    }
    
    
    
    var games: String = "em"
    var rank: String = "em"
    var won: String = "em"
    var lost: String = "em"
    
    @IBOutlet var Playername: UILabel!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("GCell") as UITableViewCell
        
        var maindata = (data[0] as NSDictionary)
        if(rank == "em")
        {
            rank = maindata["rank"] as String
            cell.textLabel?.text =  "Player Rank : \(rank)"
        }
        else
        {
            if(games == "em")
            {
                games = maindata["games"] as String
                cell.textLabel?.text =  "Games Played : \(games)"
            }
            else
            {
                if(won == "em")
                {
                    won = maindata["won"] as String
                    cell.textLabel?.text =  "Games Won: \(won)"
                }
                else
                {
                    if(lost == "em")
                    {
                        lost = maindata["lost"] as String
                        cell.textLabel?.text =  "Games Lost : \(lost)"
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #")

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
