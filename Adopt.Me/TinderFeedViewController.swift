//
//  ViewController.swift
//  Adopt.Me
//
//  Created by Johanna Smith-Palliser on 1/28/17.
//  Copyright © 2017 Johanna Smith-Palliser. All rights reserved.
//

import UIKit

class Animal {
    
    var name: String
    var breed: String
    var sex: String
    var picture: UIImage?
    var bio: String
    
    init (name: String, breed: String, sex: String, picture: UIImage?, bio: String) {
        self.name = name
        self.breed = breed
        self.sex = sex
        self.picture = picture
        self.bio = bio
    }
    
}

class TinderFeedViewController: UIViewController {
    
    var firstTouchLocation: CGPoint?
    var animals = [Animal]()
    var cards = [TinderCardView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let api = API()
        
        api.getDataFromURL { (data: Data?) in
            
            if let unwrappedData = data {
                if let dictionary = api.getDictionaryFromData(data: unwrappedData) {
                    let animals = api.animalsFromDictionary(dictionary: dictionary)
                    self.animals = animals
                    
                    self.addCardsToView()
                }
            }
        }
        
    }
    
    func addCardsToView() {
        
        DispatchQueue.main.async {
            for animal in self.animals {
                let newCard = TinderCardView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width * 0.8, height: self.view.frame.height * 0.5))
                newCard.center = self.view.center
                
                // UPDATE THIS AFTER NEW CARD
                newCard.setup(name: animal.name, breed: animal.breed, sex: animal.sex, picture: animal.picture, bio: animal.bio)
                
                self.view.addSubview(newCard)
                self.cards.insert(newCard, at: 0)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: view) {
            if cards[0].frame.contains(location) {
                firstTouchLocation = location
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: view) {
            if let origin = firstTouchLocation {
                let card = cards[0]
                let offsetX = location.x - origin.x
                let offsetY = location.y - origin.y
                card.center = CGPoint(x: view.center.x + offsetX, y: view.center.y + offsetY)
                card.transform = CGAffineTransform(rotationAngle: offsetX / 10.0 * CGFloat(M_PI) / 180.0)
                
                if offsetX > 0 {
                    card.nopeOverlayImageView.alpha = 0
                    card.likeOverlayImageView.alpha = offsetX / (view.frame.width / 3.0)
                } else {
                    card.likeOverlayImageView.alpha = 0
                    card.nopeOverlayImageView.alpha = abs(offsetX) / (view.frame.width / 3.0)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: view), let origin = firstTouchLocation {
            let card = cards[0]
            if location.x < view.frame.width * 0.25 {
                //nope
                UIView.animate(withDuration: 0.25, animations: {
                    card.center = CGPoint(x: -self.view.frame.width, y: card.center.y)
                    card.transform = CGAffineTransform.identity
                }, completion: { _ in
                    card.removeFromSuperview()
                    self.cards.remove(at: 0)
                })
            } else if card.center.x > view.frame.width * 0.75 {
                //like
                UIView.animate(withDuration: 0.25, animations: {
                    card.center = CGPoint(x: self.view.frame.width * 3.0 / 2.0, y: card.center.y)
                    card.transform = CGAffineTransform.identity
                }, completion: { _ in
                    card.removeFromSuperview()
                    self.cards.remove(at: 0)
                })
            } else {
                //reset
                UIView.animate(withDuration: 0.25, animations: {
                    card.transform = CGAffineTransform.identity
                    card.center = self.view.center
                    card.likeOverlayImageView.alpha = 0.0
                    card.nopeOverlayImageView.alpha = 0.0
                })
            }
            
            firstTouchLocation = nil
        }
    }
    

}
