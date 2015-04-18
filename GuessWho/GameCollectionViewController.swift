//
//  GameCollectionViewController.swift
//  SwiftLoginScreen
//
//  Created by fhict on 16/04/15.
//  Copyright (c) 2015 Dipin Krishna. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class GameCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var charimages: [String] = ["char1.png", "char2.png", "char3.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func charact1(sender: AnyObject) {
    }
    
    @IBAction func charact2(sender: AnyObject) {
    }
    
    @IBAction func charact3(sender: AnyObject) {
    }
    
    @IBAction func charact4(sender: AnyObject) {
    }
    
    @IBAction func charact5(sender: AnyObject) {
    }
    
    @IBAction func charact6(sender: AnyObject) {
    }
    
    @IBAction func charact7(sender: AnyObject) {
    }
    
    @IBAction func charact8(sender: AnyObject) {
    }
    
    @IBAction func charact9(sender: AnyObject) {
    }
    
    @IBAction func charact10(sender: AnyObject) {
    }
    
    @IBAction func charact11(sender: AnyObject) {
    }
    
    @IBAction func charact12(sender: AnyObject) {
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 0
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return charimages.count;
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as charcell
        cell.btnCell.setImage(UIImage(named: charimages[indexPath.row]), forState: UIControlState.Normal)
        
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
