//
//  SimulatorsManager.swift
//  Simulators
//
//  Created by Oleksandr Yolkin on 2/19/19.
//  Copyright © 2019 Oleksandr Yolkin. All rights reserved.
//

import Foundation

class SimulatorsManager {
    
    public private(set) var simulators = [Simulator]()
    
    init() {
        loadSimulators()
        sortSimulatorsByName()
    }
    
    private func loadSimulators() {
        guard let devicesFolderUrl = FileManager.default.devicesFolderUrl() else {
            print("Can't get \(String(describing: FileManager.default.devicesFolderUrl())) folder URL")
            return
        }
        
        guard let devicesUrls = try? FileManager.default.contentsOfDirectory(at: devicesFolderUrl, includingPropertiesForKeys: nil, options: []) else {
            print("Can't get content of \(String(describing: devicesFolderUrl)) folder")
            return
        }
            
        for deviceUrl in devicesUrls {
            
            let plistPath = deviceUrl.appendingPathComponent(Constants.devicePlistFileName)
            
            if FileManager.default.fileExists(atPath: plistPath.path) {
                let simulator = Simulator(devicePlistPath: plistPath.path)
                simulators.append(simulator)
            }

        }

    }
    
    private func sortSimulatorsByName() {
        simulators.sort(by: {$0.name > $1.name})
    }
    
}
