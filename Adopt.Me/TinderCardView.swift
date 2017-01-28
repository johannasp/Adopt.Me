//
//  TinderCardView.swift
//  Adopt.Me
//
//  Created by Johanna Smith-Palliser on 1/28/17.
//  Copyright © 2017 Johanna Smith-Palliser. All rights reserved.
//

import UIKit

class TinderCardView: UIView {
    
    var nameLabel: UILabel!
    //var breedLabel: UILabel!
    var pictureView: UIImageView!
    
    var likeOverlayImageView: UIImageView!
    var nopeOverlayImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        layer.cornerRadius = 10
        
        backgroundColor = .white
        
        pictureView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.85))
        pictureView.backgroundColor = .white
        pictureView.contentMode = .scaleAspectFill
        pictureView.clipsToBounds = true
        addSubview(pictureView)
        
        likeOverlayImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 75, height: 75))
        likeOverlayImageView.image = UIImage(named: "like")
        likeOverlayImageView.alpha = 0.0
        addSubview(likeOverlayImageView)
        
        nopeOverlayImageView = UIImageView(frame: CGRect(x: frame.width - 85, y: 10, width: 75, height: 75))
        nopeOverlayImageView.image = UIImage(named: "nope")
        nopeOverlayImageView.alpha = 0.0
        addSubview(nopeOverlayImageView)
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: frame.height * 0.85, width: frame.width * 0.9, height: frame.height * 0.15))
        nameLabel.center = CGPoint(x: frame.width / 2.0, y: nameLabel.center.y)
        nameLabel.baselineAdjustment = .alignCenters
        addSubview(nameLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(name: String, breed: String, sex: String, picture: UIImage?, bio: String) {
        nameLabel.text = name
        //breedLabel.text = breed
        //sexLabel.text = sex
        pictureView.image = picture
        //bioLabel.text = bio
    }
    
}

