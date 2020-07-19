//
//  QuizViewController.swift
//  FunLearning
//
//  Created by Jaskeerat Singh Bhatia on 2018-07-07.
//  Copyright © 2018 jaskeeratbhatia. All rights reserved.
//

import UIKit
import AVFoundation

class QuizViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 

    var objectList = [ObjectModel(name: "Dice", category: "Toy", imgURL: "https://s3.amazonaws.com/files.thegamecrafter.com/2614aeb1cc6479d67b64482f237b303ef8c9a083"), ObjectModel(name: "Banana", category: "Fruit", imgURL: "https://img.aws.livestrongcdn.com/ls-article-image-673/ds-photo/getty/article/108/3/125536796.jpg"), ObjectModel(name: "Cup", category: "Utensil", imgURL: "https://images-na.ssl-images-amazon.com/images/I/41hJwmmICAL.jpg"), ObjectModel(name: "Table", category: "Furniture", imgURL: "https://www.ikea.com/PIAimages/0516714_PE640511_S5.JPG"), ObjectModel(name: "Lamp", category: "Furniture", imgURL: "https://images.homedepot-static.com/productImages/fd27cd76-fd25-4a40-b023-ccff56a2cd90/svn/rhodes-bronze-hampton-bay-floor-lamps-hd09999frbrzc-64_1000.jpg"), ObjectModel(name: "Airplane", category: "Aircraft", imgURL: "https://pics.clipartpng.com/Airplane_PNG_Clipart-421.png")]
        let speechSynthesizer = AVSpeechSynthesizer()
    var filteredList : [ObjectModel] = []
    var currentObject : ObjectModel!
    var quizOptions : [ObjectModel] = []
    
    @IBOutlet weak var quizCollection: UICollectionView!
    @IBOutlet weak var findLabel: UILabel!
 
    
    var objectName : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let speechUtterance = AVSpeechUtterance(string: "Here is a small test. Just try to find " + objectName!)
        speechUtterance.rate = 0.51
        speechUtterance.pitchMultiplier = 1.2
        speechUtterance.volume = 1.0
        speechSynthesizer.speak(speechUtterance)
        navigationController?.navigationBar.isHidden = true
        quizCollection.dataSource = self
        quizCollection.delegate = self
        findLabel.text = "Find " + objectName!
        filteredList = objectList.filter { (object) -> Bool in
            return object.objName != objectName!
        }
        currentObject = (objectList.filter { (object) -> Bool in
            return object.objName == objectName!
        })[0]
        print(currentObject)
        print(filteredList)
        filteredList.shuffle()
        for index in 0...2{
                quizOptions.append(filteredList[index])
        }
        quizOptions.append(currentObject)
        quizOptions.shuffle()
        quizCollection.reloadData()
    }

    @IBAction func didPressBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "quizCell", for: indexPath) as? QuizCollectionViewCell{
            cell.configureCell(object: quizOptions[indexPath.row])
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "quizCell", for: indexPath)
            cell.backgroundColor = UIColor.black
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if quizOptions[indexPath.row].objName == objectName! {
            let speechUtterance = AVSpeechUtterance(string: "Great! You are getting better.")
            speechUtterance.rate = 0.51
            speechUtterance.pitchMultiplier = 1.2
            speechUtterance.volume = 1.0
            speechSynthesizer.speak(speechUtterance)
            navigationController?.popViewController(animated: true)
        }
        else{
            let speechUtterance = AVSpeechUtterance(string: "I am afraid that is not correct. Try again!")
            speechUtterance.rate = 0.51
            speechUtterance.pitchMultiplier = 1.2
            speechUtterance.volume = 1.0
            speechSynthesizer.speak(speechUtterance)
            
        }
    }
    
}
