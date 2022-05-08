//
//  MainView.swift
//  BankManagerUIApp
//
//  Created by 조성훈 on 2022/05/06.
//

import UIKit

final class MainView: UIView {
    //MARK: - button
    let addClientButton: UIButton = {
        let button = UIButton()
        button.setTitle("고객 10명 추가", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    //MARK: - timerLabel
    let takenWorkTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "업무시간 - "
        label.textColor = .black
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .right
        return label
    }()
    
    var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:000"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .left
        return label
    }()
    
    //MARK: - statusLabel
    let waitingStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "대기중"
        label.textColor = .white
        label.backgroundColor = .systemGreen
        label.font = .systemFont(ofSize: 35)
        label.textAlignment = .center
        return label
    }()
    
    let workingStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "업무중"
        label.textColor = .white
        label.backgroundColor = .systemIndigo
        label.font = .systemFont(ofSize: 35)
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - stackView
    let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    let timerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    let statusLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    //MARK: - scrollView
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let listStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    let waitingListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    let workingListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    //MARK: - method
    func makeView() {
        configTotalStackView()
        configScrollView()
        self.backgroundColor = .white
    }
    
    private func configTotalStackView() {
        self.addSubview(totalStackView)
        
        buttonStackView.addArrangedSubview(addClientButton)
        buttonStackView.addArrangedSubview(resetButton)
        totalStackView.addArrangedSubview(buttonStackView)
        
        timerStackView.addArrangedSubview(takenWorkTimeLabel)
        timerStackView.addArrangedSubview(timerLabel)
        totalStackView.addArrangedSubview(timerStackView)
        
        statusLabelStackView.addArrangedSubview(waitingStatusLabel)
        statusLabelStackView.addArrangedSubview(workingStatusLabel)
        totalStackView.addArrangedSubview(statusLabelStackView)
        
        let safeArea = self.safeAreaLayoutGuide
        let leading = NSLayoutConstraint(item: totalStackView,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: safeArea,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: 0)
        let trailing = NSLayoutConstraint(item: totalStackView,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: safeArea,
                                          attribute: .trailing,
                                          multiplier: 1,
                                          constant: 0)
        let top = NSLayoutConstraint(item: totalStackView,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: safeArea,
                                     attribute: .top,
                                     multiplier: 1,
                                     constant: 0)
        let height = NSLayoutConstraint(item: totalStackView,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .height,
                                        multiplier: 0.17,
                                        constant: 0)
        NSLayoutConstraint.activate([leading, trailing, top, height])
    }
    
    private func configScrollView() {
        self.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: totalStackView.bottomAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        configListStackView()
    }
    
    private func configListStackView() {
        listStackView.addArrangedSubview(waitingListStackView)
        listStackView.addArrangedSubview(workingListStackView)
        scrollView.addSubview(listStackView)
        
        let contentLayoutGuide = scrollView.contentLayoutGuide
        let frameLayoutGuide = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            listStackView.widthAnchor.constraint(equalTo: frameLayoutGuide.widthAnchor),
            listStackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            listStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            listStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            listStackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor)
        ])
    }
    
    func makeClientLabel(_ client: Client) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(client.orderNumber)-\(client.requirementType.description)"
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        
        switch client.requirementType {
        case .loan:
            label.textColor = .purple
        case .deposit:
            label.textColor = .black
        }
        return label
    }
    
    func add(waitingClientLabel: UILabel) {
        waitingListStackView.addArrangedSubview(waitingClientLabel)
    }
    
    func removeWaitingLabelAndAdd(_ workingLabel: UILabel) {
        guard let labelArray = waitingListStackView.subviews as? [UILabel] else {
            return
        }
        let label = workingLabel.text
        labelArray.forEach {
            if $0.text == label {
                $0.removeFromSuperview()
                workingListStackView.addArrangedSubview($0)
            }
        }
    }
    
    func remove(_ workingClient: Client) {
        guard let labelArray = workingListStackView.subviews as? [UILabel] else {
            return
        }
        let label = "\(workingClient.orderNumber)-\(workingClient.requirementType.description)"
        labelArray.forEach {
            if $0.text == label {
                $0.removeFromSuperview()
            }
        }
    }
}
