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
    var likedAnimals = [Animal]()
    var cards = [TinderCardView]()
    //let collectionViewController = CollectionViewController()
    
    let collectionViewController = CollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = .white
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
        
        let favoritesButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        favoritesButton.setTitleColor(.red, for: .normal)
        favoritesButton.setTitleColor(.black, for: .highlighted)
        favoritesButton.setBackgroundImage(UIImage(named: "star"), for: .normal)
        favoritesButton.frame.origin.x = view.frame.width - favoritesButton.frame.width - 10
        favoritesButton.frame.origin.y = 25
        favoritesButton.addTarget(self, action: #selector(goToCollectionViewController), for: .touchUpInside)
        view.addSubview(favoritesButton)
        
    }
    
    func goToCollectionViewController() {
        navigationController?.pushViewController(collectionViewController, animated: true)
    }
    
    func addCardsToView() {
        DispatchQueue.main.async {
            for animal in self.animals {
                let newCard = TinderCardView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width * 0.8, height: self.view.frame.height * 0.5))
                newCard.center = self.view.center
                newCard.setup(animal: animal)
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
                card.transform = CGAffineTransform(rotationAngle: offsetX / 10.0 * CGFloat(Double.pi) / 180.0)
                
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
                    
                    // Add liked to a list
                    self.likedAnimals.append(card.animal!)
                    self.collectionViewController.favoriteAnimals.append(card.animal!)
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
    
    // Remove navigation bar from login/sign up screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    // Put back navigation bar once you leave this view so it shows up on all other views
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

