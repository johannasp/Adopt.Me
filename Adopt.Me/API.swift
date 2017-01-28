//
//  API.swift
//  Adopt.Me
//
//  Created by Johanna Smith-Palliser on 1/28/17.
//  Copyright © 2017 Johanna Smith-Palliser. All rights reserved.
//

import UIKit

class API {
    let databaseURL = "https://raw.githubusercontent.com/johannasp/Adopt.Me/master/Database/database.json"
    
    func getDataFromURL(completion: @escaping (Data?) -> ()) {
        if let url = URL(string: databaseURL) {
            
            let urlRequest = URLRequest(url: url)
            let session = URLSession.shared
            
            let task = session.dataTask(with: urlRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        completion(data)
                    } else {
                        print("failed with http status code \(httpResponse.statusCode)")
                    }
                }
            })
            
            task.resume()
        }
    }
    
    func getDictionaryFromData(data: Data) -> [String:Any]? {
        if let jsonSerialization = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
            if let dictionary = jsonSerialization as? [String:Any] {
                return dictionary
            }
        }
        return nil
    }
    
    func animalsFromDictionary(dictionary: [String:Any]) -> [Animal] {
        var animals = [Animal]()
        
        if let animalJSONArray = dictionary["animals"] as? [[String: Any]] {
            for animalJSON in animalJSONArray {
                if let animal = animalFromDictionary(dictionary: animalJSON) {
                    animals.append(animal)
                }
            }
        }
        
        return animals
    }
    
    func animalFromDictionary(dictionary: [String:Any]) -> Animal? {
        
        if let name = dictionary["name"] as? String,
            let breedString = dictionary["breed"] as? String,
            let sexString = dictionary["sex"] as? String,
            let pictureURLString = dictionary["picture"] as? String,
            let bioString = dictionary["bio"] as? String {
            
            return Animal(name: name, breed: breedString, sex: sexString, picture: imageFromURLString(urlString: pictureURLString), bio: bioString)
        }
        
        return nil
    }
    
    func imageFromURLString(urlString: String) -> UIImage? {
        
        if let url = URL(string: urlString) {
            
            if let data = try? Data(contentsOf: url) {
                
                return UIImage(data: data)
            }
        }
        return nil
    }

    
    
}

