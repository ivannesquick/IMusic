//
//  NetworkService.swift
//  IMusic
//
//  Created by Neskin Ivan on 27.03.2020.
//  Copyright © 2020 Neskin Ivan. All rights reserved.
//

import UIKit


class NetworkService {
    
    func downloadData(url: String, completion: @escaping(SearchResponse)->Void) {
            
            let request = URLRequest(url: URL(string: url)!)
            
            let task = URLSession.shared.dataTask(with: request) { (data, responce, error) in
                guard let data = data else {return}
                guard error == nil else { return }
                do {
                 let objects = try JSONDecoder().decode(SearchResponse.self, from: data)
                    completion(objects)
//                    print(objects)
                } catch let error {
                  print(error)
//                 completion(.failure(error))
                }
            }
            task.resume()
        }
}
