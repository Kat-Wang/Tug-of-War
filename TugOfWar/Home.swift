//
//  ViewController.swift
//  TugOfWar
//
//  Created by Kate Wang on 5/19/25.
//

import UIKit

class Home: UIViewController {
    let client = WebSocketClient()
    let textBox = UITextField()
    let textBox2 = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        view.addSubview(textBox)
        textBox.translatesAutoresizingMaskIntoConstraints = false
        textBox.backgroundColor = .systemCyan
        NSLayoutConstraint.activate([
            textBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textBox.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textBox.heightAnchor.constraint(equalToConstant: 200),
            textBox.widthAnchor.constraint(equalToConstant: 300)])
        
        view.addSubview(textBox2)
        textBox2.translatesAutoresizingMaskIntoConstraints = false
        textBox2.backgroundColor = .white
        textBox2.textColor = .black
        NSLayoutConstraint.activate([
            textBox2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textBox2.topAnchor.constraint(equalTo: textBox.bottomAnchor),
            textBox2.heightAnchor.constraint(equalToConstant: 200),
            textBox2.widthAnchor.constraint(equalToConstant: 300)])
        
        createDismissKeywordTapGesture()
        
        textBox.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        client.connect{ message in
            DispatchQueue.main.async {
                self.textBox2.text = message
            }
        }
        
        
        client.send(text: "hello world")
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("Text changed:", textField.text ?? "")
        client.send(text: textField.text ?? "")
    }
    
    

    
    func createDismissKeywordTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
}

