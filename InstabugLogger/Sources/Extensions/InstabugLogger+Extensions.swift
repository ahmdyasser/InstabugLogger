//
//  InstabugLogger+Extensions.swift
//  InstabugLogger
//
//  Created by Ahmad Yasser on 27/05/2022.
//

import Foundation

extension InstabugLogger {
    
    /// Configures the log message to be less than 1000 chars and returns the new message
    /// - Parameters:
    ///    - message: The message  to configure
    ///
    public func configureLogMessage(message: String) -> String {
        var message = message
        
        if message.count > 1000 {
            message = "\(message.prefix(1000))..."
        }
        
        return message
    }
}

