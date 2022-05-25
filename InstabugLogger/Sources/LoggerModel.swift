//
//  LoggerModel.swift
//  InstabugInternshipTask
//
//  Created by Ahmad Yasser on 25/05/2022.
//

import Foundation

class LoggerModel {
    var message: String
    var level: String
    
    init(message: String, level: String) {
        self.message = message
        self.level = level
    }
}
