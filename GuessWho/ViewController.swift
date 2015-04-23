//
//  ViewController.swift
//  GuessWho
//
//  Created by fhict on 28/03/15.
//  Copyright (c) 2015 fhict. All rights reserved.
//

import UIKit
import MultipeerConnectivity


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var currentPlayer:String!
    
    var appDelegate:AppDelegate!

    
    var player1: NSArray = []
    
    var gebruiker: String = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gebruiker = logeduser()
        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Left) {
                    self.performSegueWithIdentifier("goto_chat", sender: self)
                 }
        
        if (sender.direction == .Right) {
            self.performSegueWithIdentifier("backtostart", sender: self)
               }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var mid =  prefs.valueForKey("MATCHID") as NSString
        var enem =  prefs.valueForKey("ENEMY") as NSString
        var get = "?id=\(mid)"
        var url = "http://athena.fhict.nl/users/i306956/winner2.php"
        url = url + get
        var player1 = NSData(contentsOfURL: NSURL(string: url)!)
        var datastring: String = NSString(data: player1!, encoding:NSUTF8StringEncoding)!
        var test = "[{\"winner\":\"\(gebruiker)\"}]"
        if(datastring == test)
        {
            let alert = UIAlertView()
            alert.title = "Win !"
            alert.message = "Your enemy guessed wrong !"
            alert.addButtonWithTitle("OK")
            alert.show()
            
            var gettt = "?id='\(gebruiker)'"
            var urltt = "http://athena.fhict.nl/users/i306956/winner3.php"
            urltt = urltt + gettt
            var datat = NSData(contentsOfURL: NSURL(string: urltt)!)
            
            
            var gett = "?id='NONE'&id2=\(mid)"
            var urlt = "http://athena.fhict.nl/users/i306956/turn1.php"
            urlt = urlt + gett
            var data = NSData(contentsOfURL: NSURL(string: urlt)!)
            self.performSegueWithIdentifier("backtostart", sender: self)
        }
        if(datastring == "[{\"winner\":\"\(enem)\"}]")
        {
            let alert = UIAlertView()
            alert.title = "Lose !"
            alert.message = "Your enemy guessed right !"
            alert.addButtonWithTitle("OK")
            alert.show()
            
            var gettt = "?id='\(gebruiker)'"
            var urltt = "http://athena.fhict.nl/users/i306956/lost1.php"
            urltt = urltt + gettt
            var datat = NSData(contentsOfURL: NSURL(string: urltt)!)
            
            
            var gett = "?id='NONE'&id2=\(mid)"
            var urlt = "http://athena.fhict.nl/users/i306956/turn1.php"
            urlt = urlt + gett
            var data = NSData(contentsOfURL: NSURL(string: urlt)!)
            self.performSegueWithIdentifier("backtostart", sender: self)
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
    
    @IBAction func StartGame(sender: AnyObject) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    var tableImages: [String] = ["char1.png", "char2.png", "char3.png", "char4.png", "char5.png", "char6.png", "char7.png", "char8.png", "char9.png", "char10.png", "char11.png", "char12.png",]
    var tableImagesel: [String] = ["char1el.png", "char2el.png", "char3el.png", "char4el.png", "char5el.png", "char6el.png", "char7el.png", "char8el.png", "char9el.png", "char10el.png", "char11el.png", "char12el.png",]
    

    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableImages.count
    }
    
    var data : NSArray = []
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: colvwCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as colvwCell
        cell.imgCell.image = UIImage(named: tableImages[indexPath.row])
        
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var mid =  prefs.valueForKey("MATCHID") as NSString
        var get = "?id=\(mid)"
        var url = "http://athena.fhict.nl/users/i306956/player1.php"
        url = url + get
        var data = NSData(contentsOfURL: NSURL(string: url)!)
        
        var datastring: String = NSString(data: data!, encoding:NSUTF8StringEncoding)!
        
        var username : String = gebruiker

        
        if("{\"player1\":\"\(username)\"}" == datastring)
        {
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            var mid =  prefs.valueForKey("MATCHID") as NSString
            var get = "?id=\(mid)"
            var url = "http://athena.fhict.nl/users/i306956/finalchar1.php"
            url = url + get
            var data = NSData(contentsOfURL: NSURL(string: url)!)
            
            var datastring: String = "";
            
            datastring = NSString(data: data!, encoding:NSUTF8StringEncoding)!
            charpick = datastring.substringWithRange(Range<String.Index>(start: advance(datastring.startIndex, 16), end: advance(datastring.endIndex, -2)))
            
        }
        else
        {
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            var mid =  prefs.valueForKey("MATCHID") as NSString
            var get = "?id=\(mid)"
            var url = "http://athena.fhict.nl/users/i306956/finalchar2.php"
            url = url + get
            var data = NSData(contentsOfURL: NSURL(string: url)!)
            
            var datastring: String = "";
            
            datastring = NSString(data: data!, encoding:NSUTF8StringEncoding)!
            charpick = datastring.substringWithRange(Range<String.Index>(start: advance(datastring.startIndex, 16), end: advance(datastring.endIndex, -2)))
            
        }
        
        if(charpick == "none" || charpick == "ul")
        {
        }
        else
        {
            if(String(indexPath.row) == charpick)
            {
                cell.backgroundColor = UIColor.greenColor()
            }
        }
    
        if(indexPath.row == tableImages.count - 1) {
            if(charpick == "none" || charpick == "ul")
            {
                let alert = UIAlertView()
                alert.title = "Hello"
                alert.message = "Please pick your character"
                alert.addButtonWithTitle("OK")
                alert.show()
            }
        }
        return cell
    }

    /*func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        if(indexPath.row == 0)
        {
            var size = CGSizeMake(320,92)
            return size
        }
        var size = CGSizeMake(74,92)
        return size
        
    }*/
    
    var charpick: String = "none"
    var final: Bool = false
    
    @IBAction func finalgues(sender: AnyObject) {
        if(charpick == "none" || charpick == "ul")
        {
            let alert = UIAlertView()
            alert.title = "Hello"
            alert.message = "Please pick your character"
            alert.addButtonWithTitle("OK")
            alert.show()
        }
        else
        {
        if(final == true)
        {
            let alert = UIAlertView()
            alert.title = "Final"
            alert.message = "Final guess canceled"
            alert.addButtonWithTitle("OK")
            alert.show()
            final = false
        }
        else
        {
            let alert = UIAlertView()
            alert.title = "Final"
            alert.message = "Guess your opponent"
            alert.addButtonWithTitle("OK")
            alert.show()
            final = true
        }
        }
        
    }
    
    func winner(name : String, mid : String)
    {
        var gett = "?id='\(name)'&id2=\(mid)"
        var urlt = "http://athena.fhict.nl/users/i306956/winner1.php"
        urlt = urlt + gett
        var data = NSData(contentsOfURL: NSURL(string: urlt)!)

    }
    
    
    func CharGuessCheck(Url: String, char: String, matchid: String){
    var get = "?id=\(matchid)"
    var url = Url
    url = url + get
    var player1 = NSData(contentsOfURL: NSURL(string: url)!)
    
    var datastring: String = NSString(data: player1!, encoding:NSUTF8StringEncoding)!
    
    var username : String = gebruiker

    if("{\"player1\":\"\(username)\"}" == datastring)
    {
        var get = "?id=\(matchid)"
        var url = "http://athena.fhict.nl/users/i306956/finalchar2.php"
        url = url + get
        var player1g = NSData(contentsOfURL: NSURL(string: url)!)
        var datastringg: String = NSString(data: player1g!, encoding:NSUTF8StringEncoding)!
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var mid =  prefs.valueForKey("MATCHID") as NSString
        var enemy =  prefs.valueForKey("ENEMY") as NSString
        var data = NSData(contentsOfURL: NSURL(string: url)!)

            
            if("{\"player2char\":\"\(char)\"}"	 == datastringg)
            {
                let alert = UIAlertView()
                alert.title = "Win !"
                alert.message = "You guessed right"
                alert.addButtonWithTitle("OK")
                alert.show()
                
                winner(gebruiker, mid: mid)
                var gett = "?id='\(gebruiker)'"
                var urlt = "http://athena.fhict.nl/users/i306956/winner3.php"
                urlt = urlt + gett
                print(urlt)
                var data = NSData(contentsOfURL: NSURL(string: urlt)!)
                
                
                var gettt = "?id='\(enemy)'&id2=\(mid)"
                var urltt = "http://athena.fhict.nl/users/i306956/turn1.php"
                urltt = urltt + gettt
                print(urltt)
                var datat = NSData(contentsOfURL: NSURL(string: urltt)!)
                
            }
        else
            {
                let alert = UIAlertView()
                alert.title = "Lose !"
                alert.message = "Your guess was wrong"
                alert.addButtonWithTitle("OK")
                alert.show()
                
                winner(gebruiker, mid: mid)
                var gettt = "?id='\(gebruiker)'"
                var urltt = "http://athena.fhict.nl/users/i306956/lost1.php"
                urltt = urltt + gettt
                var datat = NSData(contentsOfURL: NSURL(string: urltt)!)
                
                winner(enemy, mid: mid)
                var gett = "?id='\(enemy)'&id2=\(mid)"
                var urlt = "http://athena.fhict.nl/users/i306956/turn1.php"
                urlt = urlt + gett
                var data = NSData(contentsOfURL: NSURL(string: urlt)!)
            }
        self.performSegueWithIdentifier("backtostart", sender: self)
        
    }
    else
    {
        var get = "?id=\(matchid)"
        var url = "http://athena.fhict.nl/users/i306956/finalchar1.php"
        url = url + get
        var player1 = NSData(contentsOfURL: NSURL(string: url)!)
        var datastring: String = NSString(data: player1!, encoding:NSUTF8StringEncoding)!
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var mid =  prefs.valueForKey("MATCHID") as NSString
        var enemy =  prefs.valueForKey("ENEMY") as NSString
        var data = NSData(contentsOfURL: NSURL(string: url)!)
        
        
        if("{\"player2char\":\"\(char)\"}"	 == datastring)
        {
            let alert = UIAlertView()
            alert.title = "Win !"
            alert.message = "You guessed right"
            alert.addButtonWithTitle("OK")
            alert.show()
            
            winner(gebruiker, mid: mid)
            var gettt = "?id='\(gebruiker)'"
            var urltt = "http://athena.fhict.nl/users/i306956/winner3.php"
            urltt = urltt + gettt
            var datat = NSData(contentsOfURL: NSURL(string: urltt)!)
            
            var gett = "?id='\(enemy)'&id2=\(mid)"
            var urlt = "http://athena.fhict.nl/users/i306956/turn1.php"
            urlt = urlt + gett
            var data = NSData(contentsOfURL: NSURL(string: urlt)!)
            
            
        }
        else
        {
            let alert = UIAlertView()
            alert.title = "Lose !"
            alert.message = "Your guess was wrong"
            alert.addButtonWithTitle("OK")
            alert.show()
            
            winner(enemy, mid: mid)
            var gettt = "?id='\(gebruiker)'"
            var urltt = "http://athena.fhict.nl/users/i306956/lost1.php"
            urltt = urltt + gettt
            var datat = NSData(contentsOfURL: NSURL(string: urltt)!)
            
            var gett = "?id='\(enemy)'&id2=\(mid)"
            var urlt = "http://athena.fhict.nl/users/i306956/turn1.php"
            urlt = urlt + gett
            var data = NSData(contentsOfURL: NSURL(string: urlt)!)
            
        }
        self.performSegueWithIdentifier("backtostart", sender: self)
        
    }
    
    }

    
    func CharPick(Url: String, char: String, matchid: String){
        var get = "?id=\(matchid)"
        var url = Url
        url = url + get
        var player1 = NSData(contentsOfURL: NSURL(string: url)!)

        var datastring: String = NSString(data: player1!, encoding:NSUTF8StringEncoding)!
        var username : String = gebruiker
        
        if("{\"player1\":\"\(username)\"}" == datastring)
        {
            var get = "?id='\(username)'&id2=\(matchid)&id3=\(char)"
            var url = "http://athena.fhict.nl/users/i306956/charpick1.php"
            url = url + get
            var data = NSData(contentsOfURL: NSURL(string: url)!)
        }
        else
        {
  
            var get = "?id='\(username)'&id2=\(matchid)&id3=\(char)"
            var url = "http://athena.fhict.nl/users/i306956/charpick2.php"
            url = url + get
            var data = NSData(contentsOfURL: NSURL(string: url)!)
        }

    }
    
    
    
    @IBAction func chat(sender: AnyObject) {
        if(charpick == "none" || charpick == "ul")
        {
            let alert = UIAlertView()
            alert.title = "Hello"
            alert.message = "Please pick your character"
            alert.addButtonWithTitle("OK")
            alert.show()
        }
        else
        {
        self.performSegueWithIdentifier("goto_chat", sender: self)
        }
        
    }
    
    
    @IBAction func backstart(sender: AnyObject) {
        self.performSegueWithIdentifier("backtostart", sender: self)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
         var cell = collectionView.cellForItemAtIndexPath(indexPath) as colvwCell
        println("Cell \(indexPath.row) selected \(charpick)")
        
        
        if(final == true)
        {
            var refreshAlert = UIAlertController(title: "Final Guess", message: "Are you sure ?", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                
                let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                var mid =  prefs.valueForKey("MATCHID") as NSString
                
                self.CharGuessCheck("http://athena.fhict.nl/users/i306956/player1.php",char: String(indexPath.row), matchid: mid )
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
            
            final = false
        }
        else
        {
            
            if(charpick == "ul" || charpick == "none")
        {
            charpick = String(indexPath.row)
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            var mid =  prefs.valueForKey("MATCHID") as NSString
            
            CharPick("http://athena.fhict.nl/users/i306956/player1.php",char: String(indexPath.row), matchid: mid )
            cell.backgroundColor = UIColor.greenColor()
        }
            else
        {
        if(cell.imgCell.image == UIImage(named: tableImages[indexPath.row]))
        {
        cell.imgCell.image = UIImage(named: tableImagesel[indexPath.row])
        }
        else
        {
        cell.imgCell.image = UIImage(named: tableImages[indexPath.row])
        }
            
        }
        }

    }
    
    
    
    
}


