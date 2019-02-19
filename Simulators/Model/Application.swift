//
//  Application.swift
//  Simulators
//
//  Created by Oleksandr Yolkin on 2/19/19.
//  Copyright © 2019 Oleksandr Yolkin. All rights reserved.
//

import Foundation

class Application {
    
    public private(set) var name: String
    public private(set) var url: URL
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }

}
