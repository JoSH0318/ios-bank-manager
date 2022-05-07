//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by mmim, malrang.
//

import Foundation

protocol BankDelegate: AnyObject {
    func receive(_ waitingClient: Client)
    func moveToWorkingList(_ workingClient: Client)
    func finishWork(of client: Client)
}

final class Bank {
    private var clerk: Workable
    private(set) var clientsQueue = Queue(list: LinkedList<Client>())
    private let loanClerksQueue = OperationQueue()
    private let depositClerksQueue = OperationQueue()
    private let clerkGroup = DispatchGroup()
    private(set) var loanClerksCount: Int
    private(set) var depositClerksCount: Int
    
    weak var bankDelegate: BankDelegate?
    
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
        
        clerkGroup.notify(queue: .main){
            let resultDescription = "업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 %d명이며, 총 업무시간은 %.2f입니다."
            let resultMessage = String(format: resultDescription, totalClientsCount, totalWorkTime)
            
            print(resultMessage)
        }
    }
    
    func receiveClients(_ numberOfPeople: Int = Int.random(in: 10...30)) {
        for order in 1...10 {
            let client = Client(order)
            bankDelegate?.receive(client)
            clientsQueue.enqueue(client)
        }
    }
    
    private func measureWorkTime(_ block: () -> Void) -> Double {
        let start = CFAbsoluteTimeGetCurrent()
        block()
        let interval = CFAbsoluteTimeGetCurrent() - start
        return interval
    }
    
    func executeWork() {
        loanClerksQueue.maxConcurrentOperationCount = loanClerksCount
        depositClerksQueue.maxConcurrentOperationCount = depositClerksCount
        while let client = clientsQueue.dequeue() {
            arrangeByWork(of: client)
        }
    }
    
    private func arrangeByWork(of client: Client) {
        clerkGroup.enter()
        switch client.requirementType {
        case .loan:
            loanClerksQueue.addOperation { [self] in
                bankDelegate?.moveToWorkingList(client)
                clerk.deal(with: client)
                bankDelegate?.finishWork(of: client)
                clerkGroup.leave()
            }
        case .deposit:
            depositClerksQueue.addOperation { [self] in
                bankDelegate?.moveToWorkingList(client)
                clerk.deal(with: client)
                bankDelegate?.finishWork(of: client)
                clerkGroup.leave()
            }
        }
    }
}
