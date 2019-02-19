//
//  FileManager+Extension.swift
//  Simulators
//
//  Created by Oleksandr Yolkin on 2/19/19.
//  Copyright © 2019 Oleksandr Yolkin. All rights reserved.
//

import Foundation

extension FileManager {
    
    func devicesFolderUrl() -> URL? {
        return URL(string: NSHomeDirectory() + Constants.devicesPath)
    }
    
    func applicationsFolderUrlForDevice(UDID: String) -> URL? {
        return devicesFolderUrl()?.appendingPathComponent(UDID).appendingPathComponent(Constants.applicationsPath)
    }
}
