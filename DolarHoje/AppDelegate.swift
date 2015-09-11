//
//  AppDelegate.swift
//  DolarHoje
//
//  Created by Gustavo Barbosa on 9/10/15.
//  Copyright © 2015 Gustavo Barbosa. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var statusMenu: NSMenu!
    var statusItem: NSStatusItem?


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
        statusItem?.menu = statusMenu
        statusItem?.highlightMode = true
        
        fetch()
        NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "fetch", userInfo: nil, repeats: true)
    }
    
    func fetch() {
        let urlPath: String = "http://api.dolarhoje.com"
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let queue:NSOperationQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            if let responseData = data {
                if let value = NSString(data: responseData, encoding: NSUTF8StringEncoding) {
                    print(value)
                    self.statusItem?.title = "R$ \(value)"
                }
            }
        })
    }
    
    @IBAction func quit(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }
}

