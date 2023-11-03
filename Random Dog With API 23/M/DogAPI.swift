//
//  DogAPI.swift
//  Random Dog With API 23
//
//  Created by Ahmed Nafie on 20/07/2023.
//

import UIKit

class DogAPI {
    enum dogEndPoints {
        case randomDog
        case randomByBreed(String)
        case allBreedsList
        var url: URL {
            return URL(string: self.stringUrl)!
        }
        var stringUrl: String {
            switch self {
            case .randomDog:
              return "https://dog.ceo/api/breeds/image/random"
            case .randomByBreed(let breed):
//                return "https://dog.ceo/api/\(breed)/images/random" What caused the problem
                return "https://dog.ceo/api/breed/\(breed)/images/random"
                
            case .allBreedsList:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    class func requestRandomImage(breed: String,completionHandler: @escaping (DogImage?,Error?)-> Void) {
        let dogEndPoint  = DogAPI.dogEndPoints.randomByBreed(breed).url
        let task = URLSession.shared.dataTask(with: dogEndPoint) { data, response, error in
            guard let data = data else {
                completionHandler(nil,error)
                return
            }
            // Parsing JSON with codable protocol
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            completionHandler(imageData,nil)

        
            // Parsing JSON with JSONSerialization
            //            do {
            //                let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            //                let url = json["message"] as! String
            //                print(url)
            //            } catch  {
            //                print(error)
            //            }
        }
        task.resume()
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?,Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(nil,error)
                return
            }
            let imageData = UIImage(data: data)
            completionHandler(imageData,nil)
        }
        task.resume()
    }
    class func requestBreedList(completionHandler: @escaping ([String]) -> ()) {
        let listEndPoint = dogEndPoints.allBreedsList.url
        let task = URLSession.shared.dataTask(with: listEndPoint) { data, response, Error in
            guard let data = data else {
                return
            }
            var array = [String]()
            let decoder = JSONDecoder()
           let breedData = try! decoder.decode(BreedsListResponse.self, from: data)
            array = breedData.message.keys.map({$0})
//            for key in breedData.message.keys {
//                array.append(key)
//            }
            completionHandler(array)
        }
        task.resume()
    }
    
}
