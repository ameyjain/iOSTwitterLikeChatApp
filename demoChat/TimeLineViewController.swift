//
//  TimeLineViewController.swift
//  
//
//  Created by Amey Jain on 5/29/15.
//
//

import UIKit

class TimeLineViewController: UITableViewController {

    var timelineData:NSMutableArray = NSMutableArray()
    
    @IBAction func loadData(){
        timelineData.removeAllObjects()
        
        var findTimeLineData:PFQuery = PFQuery(className: "Tweets")
        findTimeLineData.findObjectsInBackgroundWithBlock({
            (objects:[AnyObject]?,error:NSError?)->Void in
            
            if (error == nil) {
                if let myObjects = objects {
                    for object in myObjects {
                        self.timelineData.addObject(object)
                    }
                }
                
                let array:NSArray = self.timelineData.reverseObjectEnumerator().allObjects
                self.timelineData = array.mutableCopy() as! NSMutableArray
                self.tableView.reloadData()
            }
        })
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.loadData()

        if((PFUser.currentUser()) == nil){

    var loginAlert:UIAlertController = UIAlertController(title: "Sign Up / Login ", message: "Please Sign Up or Login", preferredStyle: UIAlertControllerStyle.Alert)
    
        loginAlert.addTextFieldWithConfigurationHandler({
            textfield in
            textfield.placeholder = "Your username"
            
        })
        
        loginAlert.addTextFieldWithConfigurationHandler({
            textfield in
            textfield.placeholder = "Your Password"
            textfield.secureTextEntry = true
            
        })
//--------------------------------------------------------------------------------------------------------------------------------
        loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
            alertAction in
            let textFields:NSArray = loginAlert.textFields as AnyObject! as! NSArray
            let usernameTextField:UITextField = textFields.objectAtIndex(0) as! UITextField
            let passwordTextField:UITextField = textFields.objectAtIndex(1) as! UITextField
            
            PFUser.logInWithUsernameInBackground("myname", password:"mypass") {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    print("login successful")
                } else {
                    print("login failed")// The login failed. Check error to see why.
                }
            }
            
            
            
        }))
//---------------------------------------------------------------------------------------------------------------------------------
        loginAlert.addAction(UIAlertAction(title: "Sign Up", style: UIAlertActionStyle.Default, handler: {
            alertAction in
            let textFields:NSArray = loginAlert.textFields as AnyObject! as! NSArray
            let usernameTextField:UITextField = textFields.objectAtIndex(0) as! UITextField
            let passwordTextField:UITextField = textFields.objectAtIndex(1) as! UITextField
            
            var sweeter:PFUser = PFUser()
            sweeter.username = usernameTextField.text
            sweeter.password = passwordTextField.text
            
            sweeter.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    let errorString = error.userInfo["error"] as? NSString
                    print(errorString)  // Show the errorString somewhere and let the user try again.
                } else {
                    print("login successful") // Hooray! Let them use the app now.
                }
            }
            
            
        }))
        
        self.presentViewController(loginAlert, animated: true, completion: nil)
        
    }
    }
    
//-------------------------------------------------------------------
       
        
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
        }

        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return timelineData.count
    }
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell {
  
        
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let cell:TweetViewCell = tableView!.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath!) as! TweetViewCell

        cell.composetext.alpha = 0
        cell.usernamelabel.alpha = 0
        cell.timestamp.alpha = 0
        

        
        let tweet:PFObject = self.timelineData.objectAtIndex(indexPath!.row) as! PFObject
        cell.composetext.text = tweet.objectForKey("content") as! String
        cell.usernamelabel.text = tweet.objectForKey("tweeter") as? String
        cell.timestamp.text = dateFormatter.stringFromDate(tweet.createdAt!)
        // Configure the cell...

        UIView.animateWithDuration(0.5, animations: {
            cell.composetext.alpha = 1
            cell.usernamelabel.alpha = 1
            cell.timestamp.alpha = 1
        })
        
        return cell
    }
    
/*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
