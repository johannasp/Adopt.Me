//
//  AnimalDetailSubviewViewController.swift
//  Adopt.Me
//
//  Created by Johanna Smith-Palliser on 7/25/17.
//  Copyright © 2017 Johanna Smith-Palliser. All rights reserved.
//

import UIKit

class AnimalDetailSubview: UIView {
    
    var nameLabel: UILabel!
    //var breedLabel: UILabel!
    var pictureView: UIImageView!
    var animal: Animal?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        layer.cornerRadius = 10
        
        backgroundColor = .white
        
        pictureView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.85))
        pictureView.backgroundColor = .blue
        pictureView.contentMode = .scaleAspectFill
        pictureView.clipsToBounds = true
        addSubview(pictureView)
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: frame.height * 0.85, width: frame.width * 0.9, height: frame.height * 0.15))
        nameLabel.center = CGPoint(x: frame.width / 2.0, y: nameLabel.center.y)
        nameLabel.baselineAdjustment = .alignCenters
        addSubview(nameLabel)
        
        let exitButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        exitButton.setTitle("X", for: .normal)
        exitButton.addTarget(self, action:#selector(removeDetails), for: UIControlEvents.touchUpInside)
        addSubview(exitButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAnimal(animal: Animal) {
        self.animal = animal
        nameLabel.text = animal.name + " (" + animal.breed + ")"
        //breedLabel.text = animal.breed
        //sexLabel.text = animal.sex
        pictureView.image = animal.picture
        //bioLabel.text = animal.bio
    }
    
    func removeDetails() {
        self.removeFromSuperview()
    }
    
}
