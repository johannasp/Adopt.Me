//
//  CollectionViewController.swift
//  Adopt.Me
//
//  Created by Johanna Smith-Palliser on 1/28/17.
//  Copyright © 2017 Johanna Smith-Palliser. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
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
    }
    
    func goToTinderFeedViewController () {
        navigationController?.popViewController(animated: true)
    }
    
}
