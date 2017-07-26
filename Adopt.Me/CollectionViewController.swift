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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // custom back button
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "dog and cat"), for: .normal)
        button.addTarget(self, action:#selector(goToTinderFeedViewController), for: UIControlEvents.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40) //CGRectMake(0, 0, 30, 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        navigationItem.leftBarButtonItem?.setBackgroundVerticalPositionAdjustment(50.0, for: .default)
        
        // remove navbar line
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        collectionView?.backgroundColor = .white
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
    }
    
    func goToTinderFeedViewController () {
        navigationController?.popViewController(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCell
        print(cell.animal?.name)
        
        // display details 
        let detailCard = AnimalDetailSubview(frame: CGRect(x: 0, y: 0, width: self.view.frame.width * 0.8, height: self.view.frame.height * 0.7))
        detailCard.center = self.view.center
        detailCard.setupAnimal(animal: cell.animal!)
        self.view.addSubview(detailCard)
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
        //backgroundColor = .yellow
        
        nameLabel.center.x = frame.width/2.0
        nameLabel.frame.origin.y = frame.height - nameLabel.frame.height
        addSubview(nameLabel)
        addSubview(picture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
