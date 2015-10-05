//
//  ComposeViewController.swift
//  demoChat
//
//  Created by Amey Jain on 5/29/15.
//  Copyright (c) 2015 Amey Jain. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {


    @IBOutlet var textBox: UITextView! = UITextView()
    @IBOutlet var countChar: UILabel! = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textBox.becomeFirstResponder()
        textBox.layer.borderColor = UIColor.blackColor().CGColor
        textBox.layer.borderWidth = 0.5
        textBox.layer.cornerRadius = 5
        textBox.delegate = self
        // Do any additional setup after loading the view.
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendText(sender: AnyObject) {
        let tweet: PFObject = PFObject(className: "Tweets")
        tweet["content"] = textBox.text
        tweet["tweeter"] = PFUser.currentUser()?.username
        tweet.save()
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        
    }

    func textView(textView: UITextView,
        shouldChangeTextInRange range: NSRange,
        replacementText text: String) -> Bool{
    
            let newlength:Int = (textView.text as NSString).length + (text as NSString).length - range.length
            let remainingChar:Int = 140 - newlength
            
            countChar.text = "\(remainingChar)"
            
            if (newlength > 120){
                countChar.textColor = UIColor.redColor()
                
            }
            
            return (newlength > 139) ?  false : true
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
