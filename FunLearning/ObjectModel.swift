//
//  ObjectModel.swift
//  FunLearning
//
//  Created by Jaskeerat Singh Bhatia on 2018-07-06.
//  Copyright © 2018 jaskeeratbhatia. All rights reserved.
//

import Foundation
class ObjectModel {

    private var _objName : String!
    private var _objCategory : String!
    private var _objImgURL : String!
    
    var objName : String {
        if _objName == nil{
            _objName = ""
        }
        return _objName
    }
    
    var objCategory : String {
        if _objCategory == nil{
            _objCategory = ""
        }
        return _objCategory
    }
    
    var objImgURL : String {
        if _objImgURL == nil{
            _objImgURL = ""
        }
        return _objImgURL
    }
    
    
    init(name : String, category : String, imgURL : String){
        self._objName = name
        self._objCategory = category
        self._objImgURL = imgURL
    }
    
    
}
