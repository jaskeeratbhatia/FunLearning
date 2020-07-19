//
//  ObjectCollectionViewCell.swift
//  FunLearning
//
//  Created by Jaskeerat Singh Bhatia on 2018-07-06.
//  Copyright © 2018 jaskeeratbhatia. All rights reserved.
//

import UIKit

class ObjectCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var objectNameLabel: UILabel!
    @IBOutlet weak var objectImageView: UIImageView!
    
    func configureCell (object : ObjectModel) {
        self.objectImageView.downloadImage(from: object.objImgURL)
       self.objectNameLabel.text = object.objName
    }
    
    override func awakeFromNib() {
        objectImageView.layer.borderColor = UIColor(red: 1.0, green: 47.0/255, blue: 146.0/255, alpha: 1.0).cgColor
        objectImageView.layer.borderWidth = 2
    }

}
