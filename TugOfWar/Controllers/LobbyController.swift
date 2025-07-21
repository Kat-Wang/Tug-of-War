//
//  LobbyController.swift
//  TugOfWar
//
//  Created by Kate Wang on 7/15/25.
//

import UIKit

class LobbyController: UIViewController{
    let headerStack = UIStackView()
    let titleLabel = UILabel()
    let newLobbyButton = UIButton()
    
    let lobbies: [[String: String]] = [
        ["lobbyid": "1a", "host": "fart-master", "lobby-name": "farters", "player-count": "1"],
        ["lobbyid": "1a", "host": "fart-master", "lobby-name": "farters", "player-count": "1"],
        ["lobbyid": "1a", "host": "fart-master", "lobby-name": "farters", "player-count": "1"],
        ["lobbyid": "1a", "host": "fart-master", "lobby-name": "farters", "player-count": "1"],
        ["lobbyid": "1a", "host": "fart-master", "lobby-name": "farters", "player-count": "1"],
        ["lobbyid": "1a", "host": "fart-master", "lobby-name": "farters", "player-count": "1"],
        ["lobbyid": "1a", "host": "fart-master", "lobby-name": "farters", "player-count": "1"],
        ["lobbyid": "1a", "host": "fart-master", "lobby-name": "farters", "player-count": "1"],
        ["lobbyid": "1a", "host": "fart-master", "lobby-name": "farters", "player-count": "1"],
        ["lobbyid": "1a", "host": "fart-master", "lobby-name": "farters", "player-count": "1"],
        ["lobbyid": "1a", "host": "fart-master", "lobby-name": "farters", "player-count": "1"],
        ["lobbyid": "1a", "host": "fart-master", "lobby-name": "farters", "player-count": "1"],
        ["lobbyid": "1a", "host": "fart-master", "lobby-name": "farters", "player-count": "1"]]
    
    let lobbiesTable = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLobbiesTable()
        configureHeader()
    }
    
    func configureLobbiesTable() {
        view.addSubview(lobbiesTable)
        
        lobbiesTable.dataSource = self
        lobbiesTable.delegate = self
        lobbiesTable.register(LobbyCell.self, forCellReuseIdentifier: "LobbyCell")
        lobbiesTable.rowHeight = 100
        
        lobbiesTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lobbiesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lobbiesTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            lobbiesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lobbiesTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureHeader() {
        view.addSubview(headerStack)
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(newLobbyButton)
        
        titleLabel.backgroundColor = .red
        titleLabel.text = "Lobby list"
        newLobbyButton.setTitle("Create lobby", for: .normal)
        newLobbyButton.backgroundColor = .green
        
        headerStack.axis = NSLayoutConstraint.Axis.horizontal
        headerStack.spacing = 20
        
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        newLobbyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            headerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerStack.bottomAnchor.constraint(equalTo: lobbiesTable.topAnchor),
            
            titleLabel.widthAnchor.constraint(equalTo: headerStack.widthAnchor, multiplier: 0.5),
            newLobbyButton.widthAnchor.constraint(equalTo: headerStack.widthAnchor, multiplier: 0.5)
        ])
        
    }
    
    
    
}

extension LobbyController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lobbies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LobbyCell") as! LobbyCell
        
        guard
            let lobbyName = lobbies[indexPath.row]["lobby-name"],
            let playerCount = lobbies[indexPath.row]["player-count"]
        else {
            print("no lobby name/player count")
            return cell
        }
        cell.set(lobbyName, playerCount)
        return cell
    }
    
    
}
