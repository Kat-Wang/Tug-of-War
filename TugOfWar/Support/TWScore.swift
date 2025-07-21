//
//  TWLabel.swift
//  TugOfWar
//
//  Created by Kate Wang on 6/1/25.
//

import UIKit

class TWScore: UIView {
    
    private let label = UILabel()
    
    var text: String? {
        get { label.text }
        set { label.text = newValue}
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(color: UIColor){
        super.init(frame: .zero)
        configure(color: color)
    }
    
    func configure(color: UIColor) {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        
        self.backgroundColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 200),
            self.heightAnchor.constraint(equalToConstant: 100),
        ])
    }

}



