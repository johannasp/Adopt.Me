//
//  CollectionViewController.swift
//  Adopt.Me
//
//  Created by Johanna Smith-Palliser on 1/28/17.
//  Copyright © 2017 Johanna Smith-Palliser. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    var favesTableView: UITableView!
    var favoriteAnimals = [Animal]()
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        //backButton.backgroundColor = .black
        backButton.setTitleColor(.red, for: .normal)
        backButton.setTitleColor(.black, for: .highlighted)
        backButton.setBackgroundImage(UIImage(named: "dog and cat"), for: .normal)
        backButton.frame.origin.x = view.frame.origin.x + 10
        backButton.frame.origin.y = 25
        backButton.addTarget(self, action: #selector(goToTinderFeedViewController), for: .touchUpInside)
        view.addSubview(backButton)
        
        
        favesTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 10, height: 150))
        favesTableView.center.x = view.center.x
        favesTableView.frame.origin.y = backButton.frame.origin.y + backButton.frame.height + 20
        favesTableView.dataSource = self
        favesTableView.delegate = self
        favesTableView.tableFooterView = UIView()
        // Remove header
        self.automaticallyAdjustsScrollViewInsets = false
        favesTableView.layer.masksToBounds = true
        favesTableView.layer.borderColor = UIColor(red: 181/255, green: 195/255, blue: 204/255, alpha: 1).cgColor
        favesTableView.layer.borderWidth = 1.0
        view.addSubview(favesTableView)
        
        
        // collection view setup
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 7, bottom: 10, right: 7)
        layout.itemSize = CGSize(width: 80, height: 100)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300), collectionViewLayout: layout)
        collectionView.frame.origin.y = favesTableView.frame.origin.y + favesTableView.frame.height + 30
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .red
        self.view.addSubview(collectionView)
        
    }
    
    func goToTinderFeedViewController () {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteAnimals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "A Reuse Identifier")
        cell.textLabel?.text = favoriteAnimals[indexPath.row].name
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favesTableView.reloadData()
        collectionView.reloadData()
    }
    
    /*
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
     let group = favoriteAnimals[indexPath.row]
     let interestsViewController = InterestsViewController()
     interestsViewController.group = group
     navigationController?.pushViewController(interestsViewController, animated: true)
     }
     */
    
    
    
    // more collection view setup
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //number of items in collection view
        return favoriteAnimals.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath)
        
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: 20))
        nameLabel.text = favoriteAnimals[indexPath.row].name
        nameLabel.sizeToFit()
        nameLabel.center.x = cell.center.x
        nameLabel.frame.origin.y = 0
        nameLabel.backgroundColor = .blue
        cell.addSubview(nameLabel)
        
        cell.backgroundColor = .orange
        return cell
    }
    
    
}
