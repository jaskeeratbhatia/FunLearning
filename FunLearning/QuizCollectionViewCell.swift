//
//  QuizCollectionViewCell.swift
//  FunLearning
//
//  Created by Jaskeerat Singh Bhatia on 2018-07-07.
//  Copyright © 2018 jaskeeratbhatia. All rights reserved.
//

import UIKit

class QuizCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var cellLabel : String!
    
    func configureCell(object: ObjectModel){
        imageView.downloadImage(from: object.objImgURL)
        self.cellLabel = object.objName
    }
    
    override func awakeFromNib() {
        imageView.layer.borderColor = UIColor(red: 1.0, green: 47.0/255, blue: 146.0/255, alpha: 1.0).cgColor
      imageView.layer.borderWidth = 2    }
    
}
