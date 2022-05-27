//
//  InstabugLogger.swift
//  InstabugLogger
//
//  Created by Yosef Hamza on 19/04/2021.
//

import Foundation

public class InstabugLogger {
    public static var shared = InstabugLogger()
    private var entityName = "LoggerEntity"
    
    
    // MARK: Logging
    
    /// Saves  logs  to Core Data
    /// - Parameters:
    ///    - level: The level of the log
    ///    - message: The message of the log
    public func saveLog(_ level: Any, message: String) {
        let message = configureLogMessage(message: message)
        let log = LoggerModel(message: message, level: level as! String)
        
        CoreDataManager.shared.saveLog(logger: log)
    }
    
    // MARK: Fetch logs
    
    /// Fetches all the logs  from the Core Data store and returns value of type Any.
    public func fetchAllLogs() -> [LoggerEntity] {
        var logs: [LoggerEntity] = []
        logs = CoreDataManager.shared.fetchLogs()
        return logs
    }
    
    /// Fetches all the logs  from the Core Data store 
    /// - Parameters:
    ///    - CompletionHandler: The block to execute after the fetching finishes. This block has no return value and takes no parameters.
    ///
    public func fetchAllLogs(completionHandler: ([LoggerEntity]) -> Void) {
        var logs: [LoggerEntity] = []
        logs = CoreDataManager.shared.fetchLogs()
        completionHandler(logs)
    }
    
    public func clearLogs() {
        CoreDataManager.shared.clearLog(for: "LoggerEntity")
    }

}



