//
//  ViewController.swift
//  Random Dog With API 23
//
//  Created by Ahmed Nafie on 20/07/2023.
//

import UIKit

class ViewController: UIViewController {
    var breeds = [String]()
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogBreedPickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DogAPI.requestBreedList { Array in
            self.breeds = Array
            DispatchQueue.main.async {
        self.dogBreedPickerView.reloadAllComponents()
            }
        }
        dogBreedPickerView.delegate = self
        dogBreedPickerView.dataSource = self
    }
    
}
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        breeds[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImage(breed: breeds[row]) { DogImage, Error in
            DogAPI.requestImageFile(url: DogImage!.url) { UIImage, Error in
                self.handleImageResponse(image: UIImage, error: Error)
            }
        }
    }
    func handleImageResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.dogImageView.image = image
        }
    }
    
}

