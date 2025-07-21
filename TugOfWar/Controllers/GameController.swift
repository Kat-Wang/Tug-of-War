//
//  ViewController.swift
//  TugOfWar
//
//  Created by Kate Wang on 5/19/25.
//

import UIKit

class GameController: UIViewController {
    let client = WebSocketClient()
    let game = Game()
    let playerID: String? = "A" //set to nothing after testing
    let scoreStack = UIStackView()
    let buttonStack = UIStackView()
    let score1 = TWScore(color: .systemPink)
    let score2 = TWScore(color: .systemTeal)
    let button1 = UIButton(type: .system)
    let button2 = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        client.connect{data in
            if let opponentScore = Int(data) {
                DispatchQueue.main.async{
                    self.updateOpponentScore(opponentScore)
                }
            } else {
                print("received something else")
            }
        }
        
        view.backgroundColor = .systemBackground
        configureScores()
        configureButtons()
    }
    
    func configureScores() {
        view.addSubview(scoreStack)
        scoreStack.addArrangedSubview(score1)
        scoreStack.addArrangedSubview(score2)
        
        scoreStack.axis = .horizontal
        scoreStack.spacing = 10
        score1.text = String(game.scoreA)
        score2.text = String(game.scoreA)
        
        scoreStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scoreStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func configureButtons() {
        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(button1)
        buttonStack.addArrangedSubview(button2)
        
        buttonStack.axis = .horizontal
        buttonStack.spacing = 10
        
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        button1.backgroundColor = .systemPink
        button2.backgroundColor = .systemTeal
        
        button1.setTitle("A", for: .normal)
        button2.setTitle("B", for: .normal)
        button1.setTitleColor(.white, for: .normal)
        button2.setTitleColor(.white, for: .normal)
        
        if (playerID == "A") {
            button1.addTarget(self, action: #selector(updatePlayerScore), for: .touchUpInside)
            button2.isUserInteractionEnabled = false
        } else {
            button2.addTarget(self, action: #selector(updatePlayerScore), for: .touchUpInside)
            button1.isUserInteractionEnabled = false
        }
        
        NSLayoutConstraint.activate([
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.topAnchor.constraint(equalTo: scoreStack.bottomAnchor, constant: 50),
            button1.widthAnchor.constraint(equalToConstant: 100),
            button1.heightAnchor.constraint(equalToConstant: 100),
            button2.widthAnchor.constraint(equalToConstant: 100),
            button2.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc func updatePlayerScore(_ sender: UIButton) {
        game.scoreA += 1
        
        guard let data = try? JSONSerialization.data(withJSONObject: ["player": "A", "score": game.scoreA]),
              let jsonString = String(data: data, encoding: .utf8) else {
            print("player score can't send")
            return
        }
        
        client.send(text: jsonString)
        updateUI()
    }
    
    func updateOpponentScore(_ score: Int) {
        if (playerID != "A") {
            game.scoreA = score
        } else {
            game.scoreB = score
        }
        updateUI()
    }

    func updateUI(){
        score1.text = String(game.scoreA)
        score2.text = String(game.scoreB)
    }
    
}

