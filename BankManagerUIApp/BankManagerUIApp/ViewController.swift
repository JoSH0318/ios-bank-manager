//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    private var bankManager: BankManager? {
        didSet {
            bankManager?.taskStart()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        executeConsolApp()
    }
    
    func configView() {
        self.view = MainView()
        self.view.backgroundColor = .white
        guard let mainView = self.view as? MainView else {return}
        mainView.makeView()
    }
    
    func executeConsolApp() {
        let a = Bank(loanClerksCount: 1, depositClerksCount: 2)
        let b = BankManager(of: a)
        b.taskStart()
    }
}

