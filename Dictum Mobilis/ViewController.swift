//
//  ViewController.swift
//  Dictum Mobilis
//
//  Created by Will Hodges on 10/27/15.
//  Copyright © 2015 Will T Hodges. All rights reserved.
//

import UIKit
import WebKit


let ENGLATURL = "http://129.74.15.137/cgi-bin/wordz.pl?english="
let LATENGURL = "http://129.74.15.137/cgi-bin/wordz.pl?keyword="

class ViewController: UIViewController {

    @IBOutlet weak var latEng: UITextField!
    
    @IBOutlet weak var output: UITextView!
    
    @IBOutlet weak var engLat: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func latEngGo(sender: AnyObject) {
        let txt = latEng.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        let url = NSURL(string: LATENGURL + txt!)
        latEng.text! = ""
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            if let doc = HTML(html: data!, encoding: NSUTF8StringEncoding) { // THANKS FOR SOLVING THIS, https://www.reddit.com/user/Sh3z
                for info in doc.css("pre") {
                    let inf = info.text!
                    let formatChanges = inf.stringByReplacingOccurrencesOfString("\n", withString: "\n\n")
                    dispatch_async(dispatch_get_main_queue(), {
                        self.output!.text! = formatChanges
                    })
                }
            }
        }
        task.resume()
    }
    @IBAction func engLatGo(sender: AnyObject) {
        let txt = engLat.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        let url = NSURL(string: ENGLATURL + txt!)
        engLat.text! = ""
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            if let doc = HTML(html: data!, encoding: NSUTF8StringEncoding) { // THANKS FOR SOLVING THIS, https://www.reddit.com/user/Sh3z
                for info in doc.css("pre") {
                    let inf = info.text!
                    let formatChanges = inf.stringByReplacingOccurrencesOfString("\n", withString: "\n\n")
                    dispatch_async(dispatch_get_main_queue(), {
                        self.output!.text! = formatChanges
                    })
                }
            }
        }
        task.resume()
    }

}

