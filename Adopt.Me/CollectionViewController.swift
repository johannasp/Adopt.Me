//
//  CollectionViewController.swift
//  Adopt.Me
//
//  Created by Johanna Smith-Palliser on 1/28/17.
//  Copyright © 2017 Johanna Smith-Palliser. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var favoriteAnimals = [Animal]()
    let customCellIdentifier = "CustomCellIdentifier"
    var blurEffectView: UIVisualEffectView?
    var detailCard: AnimalDetailSubview?
    var isDetailPresent: Bool = false
    var firstTouchLocation: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // custom back button
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "dog and cat"), for: .normal)
        button.addTarget(self, action:#selector(goToTinderFeedViewController), for: UIControlEvents.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        navigationItem.leftBarButtonItem?.setBackgroundVerticalPositionAdjustment(50.0, for: .default)
        
        // remove navbar line
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        collectionView?.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        collectionView?.register(CustomCell.self, forCellWithReuseIdentifier: customCellIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // change name to pupper name
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as! CustomCell
        customCell.animal = favoriteAnimals[indexPath.row]
        customCell.nameLabel.text = customCell.animal?.name
        customCell.nameLabel.sizeToFit()
        
        
        // truncate if name will go off cell
        let tooLong = customCell.frame.width
        if (customCell.nameLabel.frame.width > tooLong){
            let x = customCell.nameLabel.frame.origin.x
            let y = customCell.nameLabel.frame.origin.y
            customCell.nameLabel.frame = CGRect(x: x, y: y, width: tooLong, height: 20)
        }
        
        //customCell.nameLabel.backgroundColor = .blue
        customCell.nameLabel.center.x = customCell.frame.width/2.0
        
        // change pic to pupper pic
        customCell.picture.image = customCell.animal?.picture
        customCell.picture.clipsToBounds = true
        customCell.picture.frame = CGRect(x: 0, y: 0, width: customCell.frame.height/1.5, height: customCell.frame.height/1.5)
        customCell.picture.layer.cornerRadius = customCell.picture.frame.width/2.0
        customCell.picture.center = CGPoint(x: customCell.frame.width/2.0, y: customCell.frame.height*0.4)
        
        return customCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteAnimals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 0.30*view.frame.width, height: 0.15*view.frame.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("reloading")
        collectionView?.reloadData()
        detailCard?.remove()
    }
    
    func goToTinderFeedViewController () {
        navigationController?.popViewController(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCell
        print(cell.animal?.name)
        
        // blur background
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = self.view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView!)
        
        // display animal detail card 
        detailCard = AnimalDetailSubview(frame: CGRect(x: 0, y: 0, width: self.view.frame.width * 0.8, height: self.view.frame.height * 0.6))
        detailCard?.center = self.view.center
        detailCard?.setupAnimal(animal: cell.animal!)
        detailCard?.parent = self
        self.view.addSubview(detailCard!)
        isDetailPresent = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: view) {
            if detailCard?.frame.contains(location) == true {
                firstTouchLocation = location
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: view) {
            if let origin = firstTouchLocation {
                let card = detailCard
                let offsetX = location.x - origin.x
                let offsetY = location.y - origin.y
                card?.center = CGPoint(x: view.center.x + offsetX, y: view.center.y + offsetY)
                card?.transform = CGAffineTransform(rotationAngle: offsetX / 10.0 * CGFloat(Double.pi) / 180.0)
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: view), let origin = firstTouchLocation {
            let card = detailCard
            if location.x < view.frame.width * 0.25 {
                // swipe left
                UIView.animate(withDuration: 0.25, animations: {
                    card?.center = CGPoint(x: -self.view.frame.width, y: (card?.center.y)!)
                    card?.transform = CGAffineTransform.identity
                }, completion: { _ in
                    card?.remove()
                    print("1")
                })
            } else if location.x > view.frame.width * 0.75 {
                // swipe right
                UIView.animate(withDuration: 0.25, animations: {
                    card?.center = CGPoint(x: self.view.frame.width * 3.0 / 2.0, y: (card?.center.y)!)
                    card?.transform = CGAffineTransform.identity
                }, completion: { _ in
                    card?.remove()
                    print("2")
                    
                })
            } else if location.y < view.frame.height * 0.25 {
                // swipe up
                UIView.animate(withDuration: 0.25, animations: {
                    card?.center = CGPoint(x: (card?.center.x)!, y: -self.view.frame.height)
                    card?.transform = CGAffineTransform.identity
                }, completion: { _ in
                    card?.remove()
                    print("3")
                })
            } else if location.y > view.frame.height * 0.75 {
                // swipe down
                UIView.animate(withDuration: 0.25, animations: {
                    card?.center = CGPoint(x: (card?.center.x)!, y: self.view.frame.height * 3.0 / 2.0)
                    card?.transform = CGAffineTransform.identity
                }, completion: { _ in
                    card?.remove()
                    print("4")
                    
                })
            }
            else {
                //reset
                UIView.animate(withDuration: 0.25, animations: {
                    card?.transform = CGAffineTransform.identity
                    card?.center = self.view.center
                })
            }
            
            firstTouchLocation = nil
        }
    }
    
    
    
    
    
}


class CustomCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
        label.text = "Custom Text"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var picture: UIImageView = {
        let pic = UIImage(named: "poop")
        let picView = UIImageView(image: pic)
        return picView
    }()
    
    var animal: Animal?
    
    func setupViews() {
        nameLabel.center.x = frame.width/2.0
        nameLabel.frame.origin.y = frame.height - nameLabel.frame.height
        addSubview(nameLabel)
        addSubview(picture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

