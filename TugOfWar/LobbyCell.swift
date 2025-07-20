//
//  LobbyCell.swift
//  TugOfWar
//
//  Created by Kate Wang on 7/16/25.
//

import UIKit

class LobbyCell: UITableViewCell {
    
    var playerCount: String?
    var lobbyName: String?
    var title = UILabel()
    

   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ lobbyName: String, _ playerCount: String){
        self.lobbyName = lobbyName
        self.playerCount = playerCount
        
        title.text = lobbyName
    }
    
    func configureAppearance() {
        self.addSubview(title)
        
        self.backgroundColor = .systemBackground
        
        title.numberOfLines = 0
        title.adjustsFontSizeToFitWidth = true
        
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            title.heightAnchor.constraint(greaterThanOrEqualToConstant: 80)
            
        ])
        
    }
}
