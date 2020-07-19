//
//  utilities.swift
//  FunLearning
//
//  Created by Jaskeerat Singh Bhatia on 2018-07-06.
//  Copyright © 2018 jaskeeratbhatia. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView{
    
    func downloadImage(from imgurl : String){
        
        let urlRequest = URLRequest(url: URL(string: imgurl)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if(error != nil){
                
                print(error!)
                
                return
                
            }
            
            //Whenever u have to update the UI u have to do it in main thread, otherwise it will crash
            
            DispatchQueue.main.async {
                
                self.image = UIImage(data : data!)
                
            }
        }
        
        task.resume()
        
    }
}
    
    extension MutableCollection where Indices.Iterator.Element == Index {
        /// Shuffles the contents of this collection.
        mutating func shuffle() {
            let c = count
            guard c > 1 else { return }
            
            for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
                // Change `Int` in the next line to `IndexDistance` in < Swift 3.2
                let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
                guard d != 0 else { continue }
                let i = index(firstUnshuffled, offsetBy: d)
                self.swapAt(firstUnshuffled, i)
            }
        }
    }
    extension Sequence {
        /// Returns an array with the contents of this sequence, shuffled.
        func shuffled() -> [Iterator.Element] {
            var result = Array(self)
            result.shuffle()
            return result
        }
    }
    

