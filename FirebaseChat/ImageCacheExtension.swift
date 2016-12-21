//
//  ImageCacheExtension.swift
//  FirebaseChat
//
//  Created by GOOD on 12/21/16.
//  Copyright © 2016 mrGott. All rights reserved.
//

import UIKit
import Firebase

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func imageCacheFromURLString(imageName: String){
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: imageName as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        
        let imageURL = FIRStorage.storage().reference(forURL: "gs://fir-chat-9cb64.appspot.com").child(imageName)
        
        imageURL.downloadURL(completion: { (url, error) in
            
            if error != nil {
                print("error=>\(error?.localizedDescription)")
                return
            }
            
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                
                if error != nil {
                    //print(error)
                    return
                }
                
                guard let imageData = UIImage(data: data!) else { return }
                
                DispatchQueue.main.async {
                    
                    imageCache.setObject(imageData as AnyObject, forKey: imageName as AnyObject)
                    self.image = imageData
                    
                }
                
            }).resume()
            
        })
        
    }
    
}
