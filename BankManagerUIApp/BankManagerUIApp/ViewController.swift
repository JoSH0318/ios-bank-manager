//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

final class ViewController: UIViewController {
    
    private var mainView = MainView()
    private var bank = Bank(loanClerksCount: 1, depositClerksCount: 2)
       

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        self.view = mainView
        mainView.makeView()
        
        bank.delegate = self
        
        mainView.addClientButton.addTarget(self, action: #selector(didTapClientAppend), for: .touchUpInside)
        mainView.resetButton.addTarget(self, action: #selector(didTapClientReset), for: .touchUpInside)
    }
    
    @objc private func didTapClientAppend() {
        bank.executeBankWork()
    }
    
    @objc private func didTapClientReset() {
        mainView.waitingListStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        mainView.workingListStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        bank.clientsQueue.clear()
    }
}

extension ViewController: BankDelegate {
    func bank(_ bank: Bank, shouldRecieve waitingClient: Client) {
        let waitingClientLabel = mainView.makeClientLabel(waitingClient)
        mainView.add(waitingClientLabel: waitingClientLabel)
    }

    func bank(_ bank: Bank, shouldMoveToWorkingList workingClient: Client) {
        DispatchQueue.main.async { [self] in
            let workingClientLabel = mainView.makeClientLabel(workingClient)
            mainView.removeWaitingLabelAndAdd(workingClientLabel)
        }
    }
    
    func bank(_ bank: Bank, shouldFinishWork client: Client) {
        DispatchQueue.main.async { [self] in
            mainView.remove(client)
        }
    }
}

