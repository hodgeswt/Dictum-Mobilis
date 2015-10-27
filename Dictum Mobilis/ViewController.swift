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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func latEngGo(sender: AnyObject) {
        let url = NSURL(string: LATENGURL + latEng.text!)
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
        let url = NSURL(string: ENGLATURL + engLat.text!)
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

