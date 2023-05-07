//
//  HHAnalyticsTests.swift
//  HHAnalyticsTests
//
//  Created by Nav on 07/05/23.
//

import XCTest
@testable import HHAnalytics


class AnalyticsManager{
    private let engine: AnalyticsProtocol
    init(engine: AnalyticsProtocol) {
        self.engine = engine
    }
    
    func log(event: AnalyticsEvent){
        engine.send(event: event) { result in
            
        }
    }
}

class AnalyticsSpy: AnalyticsProtocol{
    var logEventCallCount = 0
    var receivedEvents = [AnalyticsEvent]()
    func send(event: HHAnalytics.AnalyticsEvent, completion: @escaping (AnalyticsProtocol.Result) -> Void) {
        logEventCallCount += 1
        receivedEvents.append(event)
    }
    
    
}
final class HHAnalyticsTests: XCTestCase {

    func test_init_doesnotLogsAnyEvent(){
        let (sut, engine) = makeSUT()
        XCTAssertEqual(engine.logEventCallCount, 0)
    }
    
    func test_log_callsEngineToLogAnEvent(){
        let (sut, engine) = makeSUT()
        sut.log(event: .loginViewed)
        XCTAssertEqual(engine.receivedEvents, [.loginViewed])

    }
    
    // MARK: - Helpers
    private func makeSUT() -> (AnalyticsManager, AnalyticsSpy){
        let engine = AnalyticsSpy()
        let sut = AnalyticsManager(engine: engine)
        return (sut, engine)
    }
    private func anyNSError() -> NSError{
        NSError(domain: "some error", code: 2)
    }

}
