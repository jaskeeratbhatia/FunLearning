//
//  HomeViewController.swift
//  FunLearning
//
//  Created by Jaskeerat Singh Bhatia on 2018-07-06.
//  Copyright © 2018 jaskeeratbhatia. All rights reserved.
//

import UIKit
import Speech
import AVFoundation
import ARKit
import RealmSwift

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ARSCNViewDelegate {
    
    @IBOutlet weak var arSceneView: ARSCNView!
    @IBOutlet weak var soundButton: UIButton!
    
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var objectsCollectionView: UICollectionView!
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var objectList = [ObjectModel(name: "Dice", category: "Toy", imgURL: "https://s3.amazonaws.com/files.thegamecrafter.com/2614aeb1cc6479d67b64482f237b303ef8c9a083"), ObjectModel(name: "Banana", category: "Fruit", imgURL: "https://img.aws.livestrongcdn.com/ls-article-image-673/ds-photo/getty/article/108/3/125536796.jpg"), ObjectModel(name: "Cup", category: "Utensil", imgURL: "https://images-na.ssl-images-amazon.com/images/I/41hJwmmICAL.jpg"), ObjectModel(name: "Table", category: "Furniture", imgURL: "https://www.ikea.com/PIAimages/0516714_PE640511_S5.JPG"), ObjectModel(name: "Lamp", category: "Furniture", imgURL: "https://images.homedepot-static.com/productImages/fd27cd76-fd25-4a40-b023-ccff56a2cd90/svn/rhodes-bronze-hampton-bay-floor-lamps-hd09999frbrzc-64_1000.jpg"), ObjectModel(name: "Airplane", category: "Aircraft", imgURL: "https://pics.clipartpng.com/Airplane_PNG_Clipart-421.png")]
    
    override func viewDidLoad() {
        let speechUtterance = AVSpeechUtterance(string: "Welcome to Fun Learning. Click on any of the objects to learn more.")
        speechUtterance.rate = 0.52
        speechUtterance.pitchMultiplier = 1.2
        speechUtterance.volume = 1.0
        speechSynthesizer.speak(speechUtterance)
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        objectsCollectionView.dataSource = self
        objectsCollectionView.delegate = self
        arSceneView.delegate = self
       // arSceneView.showsStatistics = true
        let configuration = ARWorldTrackingConfiguration()
        arSceneView.session.run(configuration)
        soundButton.isEnabled = false
        quizButton.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        let configuration = ARWorldTrackingConfiguration()
        arSceneView.session.run(configuration)
        soundButton.isEnabled = false
        quizButton.isEnabled = false
        nameLabel.text = ""
    }

    @IBAction func didPressQuiz(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "quizView") as! QuizViewController
            nextViewController.objectName = nameLabel.text
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func didPressSound(_ sender: Any) {
        let speechUtterance = AVSpeechUtterance(string: nameLabel.text!)
        speechUtterance.rate = 0.42
        speechUtterance.pitchMultiplier = 1.2
        speechUtterance.volume = 1.0
        speechSynthesizer.speak(speechUtterance)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arSceneView.session.pause()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = objectsCollectionView.dequeueReusableCell(withReuseIdentifier: "objectCell", for: indexPath) as? ObjectCollectionViewCell{
            cell.configureCell(object: objectList[indexPath.row])
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "objectCell", for: indexPath)
                    cell.backgroundColor = UIColor.black
                    return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //imageView.downloadImage(from: objectList[indexPath.row].objImgURL)
        soundButton.isEnabled = true
        quizButton.isEnabled = true
        nameLabel.text = objectList[indexPath.row].objName
        let speechUtterance = AVSpeechUtterance(string: "This is a " + objectList[indexPath.row].objName)
        speechUtterance.rate = 0.42
        speechUtterance.pitchMultiplier = 1.2
        speechUtterance.volume = 1.0
        speechSynthesizer.speak(speechUtterance)
        let scene = SCNScene(named: "art.scnassets/" + objectList[indexPath.row].objName.lowercased() + ".scn")!
        
        // Set the scene to the view
        arSceneView.scene = scene
        //Speech.shared.speak(text: objectList[indexPath.row].objName )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 170)
    }


}
