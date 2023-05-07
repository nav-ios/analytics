//
//  AnalyticsProtocol.swift
//  HHAnalytics
//
//  Created by Nav on 07/05/23.
//

import Foundation

enum AnalyticsEvent{
    case loginViewed
}
protocol AnalyticsProtocol{
    typealias Result = Swift.Result<Void, Error>
    func send(event: AnalyticsEvent, completion: @escaping (Result) -> Void)
}
