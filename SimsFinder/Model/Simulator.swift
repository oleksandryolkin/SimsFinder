//
//  Simulator.swift
//  Simulators
//
//  Created by Oleksandr Yolkin on 2/19/19.
//  Copyright © 2019 Oleksandr Yolkin. All rights reserved.
//

import Foundation

class Simulator {
    
    public private(set) var UDID: String
    public private(set) var deviceType: String
    public private(set) var name: String
    public private(set) var runtime: String
    public private(set) var state: Int
    
    private var url: URL

    init(devicePlistPath: String) {
        
        let dict = NSDictionary(contentsOfFile: devicePlistPath)
        self.UDID = dict?.value(forKey: "UDID") as? String ?? "unknown"
        self.deviceType = dict?.value(forKey: "deviceType") as? String ?? "unknown"
        self.name = dict?.value(forKey: "name") as? String ?? "unknown"
        self.runtime = dict?.value(forKey: "runtime") as? String ?? "unknown"
        self.state = dict?.value(forKey: "state") as? Int ?? -9999
        
        self.url = URL(fileURLWithPath: devicePlistPath).deletingLastPathComponent()
    }
    
    public func isValid() -> Bool {
        return UDID != "unknown" && deviceType != "unknown" && name != "unknown"
    }
    
    public func applications() -> [Application]? {
        var apps = [Application]()
        
        guard let applicationsFolderUrl = FileManager.default.applicationsFolderUrlForDevice(UDID: self.UDID) else {
            return nil
        }
        
        guard let applicationsUrls = try? FileManager.default.contentsOfDirectory(at: applicationsFolderUrl, includingPropertiesForKeys: nil, options: []) else {
            return nil
        }
        
        for applicationUrl in applicationsUrls {
            
            if let contentItems = try? FileManager.default.contentsOfDirectory(at: applicationUrl, includingPropertiesForKeys: [URLResourceKey.isPackageKey], options: []) {
                
                for item in contentItems {
                    if item.lastPathComponent == Constants.metadataPlist {
                        if let dict = NSDictionary(contentsOf: item) {
                            if let appId = dict[Constants.metadataIdentifier] as? String, appId.hasPrefix("com.apple") == false {
                                let app = Application(name: appId, url: item)
                                apps.append(app)
                                
                            }
                            
                        }
                    
                    }
                    
                }
                
            }

        }
        
        return apps
    }
    
}

