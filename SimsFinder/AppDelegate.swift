//
//  AppDelegate.swift
//  Simulators
//
//  Created by Oleksandr Yolkin on 2/19/19.
//  Copyright © 2019 Oleksandr Yolkin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    private var appController = AppController()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Reserved
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

