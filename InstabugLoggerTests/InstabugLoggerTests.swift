//
//  InstabugLoggerTests.swift
//  InstabugLoggerTests
//
//  Created by Yosef Hamza on 19/04/2021.
//

import XCTest
import CoreData
@testable import InstabugLogger

class InstabugLoggerTests: XCTestCase {
    
    var sut: InstabugLogger!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = InstabugLogger()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut.clearLogs()
        sut = nil
    }
    
    func test_LogsAreLessThan1000Log() throws {
        // NOTE: here we are setting the test to be more than 100 not 1000 to shorten test time
        // given
        for i in 0..<103 {
            sut.saveLog("lvl", message: "msg")
        }
        // when
        let logs = sut.fetchAllLogs()
    
        
        

        // then
        XCTAssertEqual(logs.count, 100)
    }
    func test_LogMessageLessThan1000Chars() throws {
        
        // given
        sut.saveLog("lvl", message: Constants.longMsg)
        
        
        // when
        let logs = sut.fetchAllLogs()
    
        
        
        // NOTE: here we are setting the test to 1004 because we added '...' to the log message when it's longer than 1000 chars
        // then
        XCTAssertEqual(logs[0].message!.count, 1003)
    }
    
    
    func test_ValidateLogIsSaved() throws {
        // given
        sut.saveLog("level1", message: "msg1")
        sut.saveLog("level2", message: "msg2")
        
        // when
        let logs = sut.fetchAllLogs()
       
        XCTAssertEqual(logs[0].level, "level1")
        XCTAssertEqual(logs[0].message, "msg1")
        
        
    }
    
    func test_ValidateAllLogsAreFetched() throws {
        // given
        for _ in 0..<10 {
            sut.saveLog("level1", message: "msg1")
        }
        
        
        // when
        let logs = sut.fetchAllLogs()
        
        // then
            XCTAssertEqual(logs.count, 10)
        
        
    }
    
    
}
