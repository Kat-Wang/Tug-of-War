//
//  NewLobbyController.swift
//  TugOfWar
//
//  Created by Kate Wang on 7/18/25.
//

import UIKit

class NewLobbyController: UIViewController {
    
    var lobbyName = ""
    var timeLimit = 5
    
    let heading = UILabel()
    let timeLimitValues = Array(5...60)
    let lobbyNameLabel = UILabel()
    let lobbyNameTextField = UITextField()
    let timeLimitLabel = UILabel()
    let timeLimitTextField = UITextField()
    let timeLimitPicker = UIPickerView()
    let createButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        timeLimitPicker.dataSource = self
        timeLimitPicker.delegate = self
        
        configureUI()
        
        configureCreateLobbyButton()
        
        configureLobbyNameTextField()
        
        createDismissKeywordTapGesture()
    }
    
    func configureUI() {
        view.addSubview(heading)
        view.addSubview(lobbyNameLabel)
        view.addSubview(lobbyNameTextField)
        view.addSubview(timeLimitLabel)
        view.addSubview(timeLimitTextField)
        view.addSubview(createButton)
        
        heading.text = "Create A Lobby"
        heading.font = UIFont.preferredFont(forTextStyle: .title1)
        heading.textColor = .label
        
        lobbyNameLabel.text = "Lobby Name"
        
        lobbyNameTextField.placeholder = "lobby name"
        
        timeLimitLabel.text = "Time Limit"
        
        createButton.setTitle("Create Lobby", for: .normal)
        createButton.backgroundColor = .systemBlue
        createButton.layer.cornerRadius = 10
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        timeLimitTextField.leftView = paddingView
        timeLimitTextField.leftViewMode = .always
        timeLimitTextField.rightView = paddingView
        timeLimitTextField.rightViewMode = .always

        timeLimitTextField.inputView = timeLimitPicker
        timeLimitTextField.text = String(timeLimit)
        timeLimitTextField.backgroundColor = .systemGray6
        timeLimitTextField.layer.cornerRadius = 10
        
        heading.translatesAutoresizingMaskIntoConstraints = false
        lobbyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        lobbyNameTextField.translatesAutoresizingMaskIntoConstraints = false
        timeLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLimitTextField.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heading.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            heading.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            lobbyNameLabel.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 50),
            lobbyNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            lobbyNameLabel.widthAnchor.constraint(equalToConstant: 100),
            lobbyNameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            lobbyNameTextField.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 50),
            lobbyNameTextField.leadingAnchor.constraint(equalTo: lobbyNameLabel.trailingAnchor, constant: 50),
            lobbyNameTextField.widthAnchor.constraint(equalToConstant: 100),
            lobbyNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            timeLimitLabel.topAnchor.constraint(equalTo: lobbyNameLabel.bottomAnchor, constant: 50),
            timeLimitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            timeLimitLabel.widthAnchor.constraint(equalToConstant: 100),
            timeLimitLabel.heightAnchor.constraint(equalToConstant: 40),
            
            timeLimitTextField.topAnchor.constraint(equalTo: lobbyNameTextField.bottomAnchor, constant: 50),
            timeLimitTextField.leadingAnchor.constraint(equalTo: timeLimitLabel.trailingAnchor, constant: 50),
            timeLimitTextField.widthAnchor.constraint(equalToConstant: 100),
            timeLimitTextField.heightAnchor.constraint(equalToConstant: 40),
            
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.topAnchor.constraint(equalTo: timeLimitLabel.bottomAnchor, constant: 80),
            createButton.widthAnchor.constraint(equalToConstant: 200),
            createButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureCreateLobbyButton () {
        createButton.addTarget(self, action: #selector(createNewLobby), for: .touchUpInside)
    }
    
    @objc func createNewLobby() {
        //TODO: go to new screen
        print(lobbyName, timeLimit)
        view.endEditing(true)
    }
    
    func configureLobbyNameTextField() {
        lobbyNameTextField.addTarget(self, action: #selector(updateLobbyName), for: .editingChanged)
    }
    
    @objc func updateLobbyName() {
        lobbyName = lobbyNameTextField.text!
    }
    
    func updateUI() {
        timeLimitTextField.text = String(timeLimit)
    }
    
    func createDismissKeywordTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }

}


extension NewLobbyController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        timeLimitValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(timeLimitValues[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timeLimit = timeLimitValues[row]
        updateUI()
    }

}
