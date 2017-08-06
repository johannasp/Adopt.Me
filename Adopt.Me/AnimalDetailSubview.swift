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
    
    var nameLabel: UILabel!
    //var breedLabel: UILabel!
    var pictureView: UIImageView!
    var animal: Animal?
    var parent: CollectionViewController?
    
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
        print(self.animal?.breed)
        nameLabel.text = animal.name + " (" + animal.breed + ")"
        //breedLabel.text = animal.breed
        //sexLabel.text = animal.sex
        pictureView.image = animal.picture
        //bioLabel.text = animal.bio
        
        // if statement to determine gender - m/f icons in blue/pink in upper right hand corner
        print(self.animal?.sex)
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
            let femaleImg = Ionicons.female.image(20, color: .red)
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
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width * 0.9, height: frame.height * 0.15))
        nameLabel.frame.origin.y = pictureView.frame.height + 12
        nameLabel.center = CGPoint(x: frame.width / 2.0, y: nameLabel.center.y)
        nameLabel.baselineAdjustment = .alignCenters
        addSubview(nameLabel)
        
        let exitButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        exitButton.setImage(UIImage(named: "nope"), for: .normal)
        exitButton.frame.size = CGSize(width: 30, height: 30)
        exitButton.frame.origin.x = 5
        exitButton.frame.origin.y = 5
        exitButton.addTarget(self, action:#selector(remove), for: UIControlEvents.touchUpInside)
        addSubview(exitButton)
        
        // if statement to determine gender - m/f icons in blue/pink in upper right hand corner
        print(self.animal?.sex)
        if animal?.sex == "Male" {
            print("in male")
            let maleImg = Ionicons.male.image(30, color: .blue)
            let maleImgView = UIImageView(image: maleImg)
            maleImgView.frame.origin.x = frame.width - maleImgView.frame.width
            maleImgView.frame.origin.y = frame.height - maleImgView.frame.height
            addSubview(maleImgView)
        }
        else if animal?.sex == "Female" {
            print("in female")
            let femaleImg = Ionicons.female.image(30, color: .red)
            let femaleImgView = UIImageView(image: femaleImg)
            femaleImgView.frame.origin.x = frame.width - femaleImgView.frame.width
            femaleImgView.frame.origin.y = frame.height - femaleImgView.frame.height
            addSubview(femaleImgView)
        }
        
        
        
        
        
    }
    
}
