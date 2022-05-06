//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by mmim, malrang.
//

import Foundation

final class Bank {
    private var clerk: Workable
    private var clientsQueue = Queue(list: LinkedList<Client>())
    private let loanClerksQueue = OperationQueue()
    private let depositClerksQueue = OperationQueue()
    private let clerkGroup = DispatchGroup()
    private(set) var loanClerksCount: Int
    private(set) var depositClerksCount: Int
    
    init(loanClerksCount: Int, depositClerksCount: Int) {
        self.loanClerksCount = loanClerksCount
        self.depositClerksCount = depositClerksCount
        self.clerk = BankClerk()
    }
    
    func executeBankWork() {
        receiveClients()
        let totalClientsCount = clientsQueue.count
        let totalWorkTime = measureWorkTime {
            executeWork()
        }
        let resultDescription = "업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 %d명이며, 총 업무시간은 %.2f입니다."
        let resultMessage = String(format: resultDescription, totalClientsCount, totalWorkTime)
        
        print(resultMessage)
    }
    
    private func receiveClients() {
        for order in 1...Int.random(in: 10...30) {
            clientsQueue.enqueue(Client(order))
        }
    }
    
    private func measureWorkTime(_ block: () -> Void) -> Double {
        let start = CFAbsoluteTimeGetCurrent()
        block()
        let interval = CFAbsoluteTimeGetCurrent() - start
        return interval
    }
    
    private func executeWork() {
        loanClerksQueue.maxConcurrentOperationCount = loanClerksCount
        depositClerksQueue.maxConcurrentOperationCount = depositClerksCount
        while let client = clientsQueue.dequeue() {
            switch client.requirementType {
            case .loan:
                loanClerksQueue.addOperation {
                    self.clerk.deal(with: client)
                }
            case .deposit:
                depositClerksQueue.addOperation {
                    self.clerk.deal(with: client)
                }
            }
        }
    }
}
