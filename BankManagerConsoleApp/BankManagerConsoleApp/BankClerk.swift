//
//  BankClerk.swift
//  BankManagerConsoleApp
//
//  Created by mmim, malrang.
//

import Foundation

final class BankClerk: Workable {
    private enum Message {
        static let start = "%d번 고객 %@업무 시작"
        static let end = "%d번 고객 %@업무 종료"
    }
    
    func deal(with client: Client) {
        let workStartingMessage = String(format: Message.start,
                                         client.orderNumber,
                                         client.requirementType.description)
        let workEndingMessage = String(format: Message.end,
                                       client.orderNumber,
                                       client.requirementType.description)
        
        print(workStartingMessage)
        Thread.sleep(forTimeInterval: client.requirementType.takenTime)
        print(workEndingMessage)
    }
}
