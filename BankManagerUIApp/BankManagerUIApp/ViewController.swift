//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = MainView()
        self.view.backgroundColor = .white
        guard let mainView = self.view as? MainView else {return}
        mainView.makeView()
        
        executeConsolApp()
    }
    
    func executeConsolApp() {
        let a = Bank(loanClerksCount: 1, depositClerksCount: 2)
        let b = BankManager(of: a)
        b.taskStart()
    }
}

