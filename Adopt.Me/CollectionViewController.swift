//
//  CollectionViewController.swift
//  Adopt.Me
//
//  Created by Johanna Smith-Palliser on 1/28/17.
//  Copyright © 2017 Johanna Smith-Palliser. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    var favesTableView: UITableView!
    var favoriteAnimals = [Animal]()
    
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
        
        
        favesTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 10, height: 250))
        favesTableView.center.x = view.center.x
        favesTableView.center.y = 300
        favesTableView.dataSource = self
        favesTableView.delegate = self
        favesTableView.tableFooterView = UIView()
        // Remove header
        self.automaticallyAdjustsScrollViewInsets = false
        favesTableView.layer.masksToBounds = true
        favesTableView.layer.borderColor = UIColor(red: 181/255, green: 195/255, blue: 204/255, alpha: 1).cgColor
        favesTableView.layer.borderWidth = 1.0
        view.addSubview(favesTableView)
        
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
    }
    
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let group = favoriteAnimals[indexPath.row]
        let interestsViewController = InterestsViewController()
        interestsViewController.group = group
        navigationController?.pushViewController(interestsViewController, animated: true)
    }
    */

    
}
