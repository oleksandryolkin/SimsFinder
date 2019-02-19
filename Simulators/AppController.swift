//
//  AppController.swift
//  Simulators
//
//  Created by Oleksandr Yolkin on 2/19/19.
//  Copyright © 2019 Oleksandr Yolkin. All rights reserved.
//

import Foundation
import AppKit

class AppController: NSObject, NSMenuDelegate {
    
    private var statusMenu: NSMenu?
    private var statusItem: NSStatusItem?
    
    private var simulatorsManager = SimulatorsManager()
    
    override init() {
        super.init()
        
        self.statusMenu = NSMenu(title: "Simulators")
        self.statusMenu?.delegate = self
        self.statusItem = NSStatusBar.system.statusItem(withLength: -1)
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true
        self.statusItem?.image = icon
        self.statusItem?.menu = statusMenu
        
    }
    
    private func buildMenu() {
        
        for simulator in simulatorsManager.simulators {
            if simulator.isValid() {
            
                let menuItem = NSMenuItem(title: simulator.name, action: nil, keyEquivalent: "")
                menuItem.representedObject = simulator
                if let apps = simulator.applications(), apps.count > 0 {
                    let submenu = NSMenu(title: simulator.name)
                    menuItem.submenu = submenu
                    
                    for app in apps {
                        let menuItem = NSMenuItem(title: app.name, action: #selector(menuItemPressed(_:)), keyEquivalent: "")
                        menuItem.target = self
                        menuItem.representedObject = app
                        submenu.addItem(menuItem)
                    }
                    
                }
                
                statusMenu?.addItem(menuItem)
 
            }
            
        }
        
    }
    
    private func clearMenu() {
        statusMenu?.removeAllItems()
    }
    
    @objc func menuItemPressed(_ menuItem: NSMenuItem) {
        if let app = menuItem.representedObject as? Application {
            NSWorkspace.shared.activateFileViewerSelecting([app.url])
        }
    }
    
    // MARK: - NSMenuDelegate
    func menuWillOpen(_ menu: NSMenu) {
        clearMenu()
        buildMenu()
    }
    
}
