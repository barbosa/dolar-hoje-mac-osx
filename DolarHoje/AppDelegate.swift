//
//  AppDelegate.swift
//  DolarHoje
//
//  Created by Gustavo Barbosa on 9/10/15.
//  Copyright © 2015 Gustavo Barbosa. All rights reserved.
//

import Cocoa
import Alamofire

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
        Alamofire.request(.GET, "http://api.dolarhoje.com")
            .responseString { _, _, result in
                if let value = result.value {
                    print("\(value)")
                    self.statusItem?.title = "R$ \(value)"
                }
        }
    }
    
    @IBAction func quit(sender: NSMenuItem) {
        NSApp.terminate(self)
    }
}

