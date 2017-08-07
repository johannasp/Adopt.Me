//
//  AnimalDetailSubviewViewController.swift
//  Adopt.Me
//
//  Created by Johanna Smith-Palliser on 7/25/17.
//  Copyright © 2017 Johanna Smith-Palliser. All rights reserved.
//

import UIKit
import IoniconsSwift

class AnimalDetailSubview: UIView {
    
    var animal: Animal?
    var parent: CollectionViewController?
    var pictureView: UIImageView!
    var nameLabel: UILabel!
    var subdetailLabel: UILabel!
    var bioLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = .white
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAnimal(animal: Animal) {
        self.animal = animal
        pictureView.image = animal.picture
        nameLabel.text = animal.name
        subdetailLabel.text = animal.breed + " · " + animal.sex
        bioLabel.text = animal.bio
        
        // if statement to determine gender - m/f icons in blue/pink in upper right hand corner
        if animal.sex == "Male" {
            print("in male")
            let maleImg = Ionicons.male.image(20, color: .blue)
            let maleImgView = UIImageView(image: maleImg)
            maleImgView.frame.origin.x = frame.width - maleImgView.frame.width - 5
            maleImgView.frame.origin.y = 5
            addSubview(maleImgView)
        }
        else if animal.sex == "Female" {
            print("in female")
            let femaleImg = Ionicons.female.image(20, color: .magenta)
            let femaleImgView = UIImageView(image: femaleImg)
            femaleImgView.frame.origin.x = frame.width - femaleImgView.frame.width - 5
            femaleImgView.frame.origin.y = 5
            addSubview(femaleImgView)
        }
    }
    
    func remove() {
        parent?.blurEffectView?.removeFromSuperview()
        self.removeFromSuperview()
        parent?.isDetailPresent = false
    }
    
    func setupUI() {
        
        pictureView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.height/1.5, height: frame.height/1.5))
        pictureView.clipsToBounds = true
        pictureView.layer.cornerRadius = pictureView.frame.width/2.0
        pictureView.center = CGPoint(x: frame.width/2.0, y: frame.height*0.4)
        addSubview(pictureView)
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width * 0.9, height: frame.height * 0.07))
        nameLabel.font = nameLabel.font.withSize(25)
        nameLabel.frame.origin.y = pictureView.frame.height + frame.height * 0.07
        nameLabel.center = CGPoint(x: frame.width / 2.0, y: nameLabel.center.y)
        nameLabel.baselineAdjustment = .alignCenters
        addSubview(nameLabel)
        
        subdetailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width * 0.9, height: frame.height * 0.05))
        subdetailLabel.frame.origin.y = nameLabel.frame.origin.y + nameLabel.frame.height + 3
        subdetailLabel.center = CGPoint(x: frame.width / 2.0, y: subdetailLabel.center.y)
        subdetailLabel.baselineAdjustment = .alignCenters
        addSubview(subdetailLabel)
        
        bioLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width * 0.9, height: frame.height * 0.13))
        bioLabel.frame.origin.y = subdetailLabel.frame.origin.y + subdetailLabel.frame.height + 3
        bioLabel.center = CGPoint(x: frame.width / 2.0, y: bioLabel.center.y)
        bioLabel.baselineAdjustment = .alignCenters
        bioLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        bioLabel.numberOfLines = 5
        bioLabel.font = bioLabel.font.withSize(13)
        addSubview(bioLabel)
        
    }
    
}
