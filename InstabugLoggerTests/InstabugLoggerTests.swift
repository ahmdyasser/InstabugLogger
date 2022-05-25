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
        sut = nil
    }

    
    func test_ConfigureLogMessageLessThan1000Chars() throws {
        
        // when
        let message = sut.configureLogMessage(message: "here is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test case which is longer than 100 charshere is some test 100 charshere is some test 100 charshere is some test ")
        
       
        // NOTE: here we are setting the test to 1004 because we added ' ...' to the log message when it's longer than 1000 chars
        
        // then
        XCTAssertLessThanOrEqual(message.count, 1004)
    }
    
    
    func test_ValidateLogsLengthLessThan1000Log() throws {
        // given
        for _ in 0..<1006 {
            sut.saveLog("level1", message: "msg1")
        }
        
        // when
        let logs = sut.fetchAllLogs()
        
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            XCTAssertEqual(logs.count, 1000)

        }
    }
    
    func test_ValidateLogIsSaved() throws {
       // given
        sut.saveLog("level1", message: "msg1")
        sut.saveLog("level2", message: "msg2")
        
        // when
        let logs = sut.fetchAllLogs()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(logs[0].level, "level1")
            XCTAssertEqual(logs[0].message, "msg1")
            
        }
       
    }
    
    func test_ValidateAllLogsAreFetched() throws {
        // given
        for _ in 0..<10 {
            sut.saveLog("level1", message: "msg1")
        }
        
        
        // when
        let logs = sut.fetchAllLogs()
        
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(logs.count, 10)
        }
        
    }
   
    
}
