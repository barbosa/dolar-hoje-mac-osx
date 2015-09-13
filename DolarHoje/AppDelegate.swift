//
//  AppDelegate.swift
//  DolarHoje
//
//  Created by Gustavo Barbosa on 9/10/15.
//  Copyright © 2015 Gustavo Barbosa. All rights reserved.
//

import Cocoa
import ServiceManagement

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var loginOnStartupItem: NSMenuItem!
    var statusItem: NSStatusItem?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
        statusItem?.menu = statusMenu
        statusItem?.highlightMode = true
        
        loginOnStartupItem.state = NSBundle.mainBundle().isLoginItem() ? NSOnState : NSOffState
        
        fetch()
        NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "fetch", userInfo: nil, repeats: true)
    }
    
    func fetch() {
        let url: NSURL = NSURL(string: "http://api.dolarhoje.com")!
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
    
    @IBAction func toggleLoginOnStartup(menuItem: NSMenuItem) {
        menuItem.state = menuItem.state == NSOnState ? NSOffState : NSOnState
        
        if menuItem.state == NSOnState {
            NSBundle.mainBundle().addToLoginItems()
        } else {
            NSBundle.mainBundle().removeFromLoginItems()
        }
    }
    
    @IBAction func quit(menuItem: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }
}

