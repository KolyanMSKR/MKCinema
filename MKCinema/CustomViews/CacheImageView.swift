//
//  CacheImageView.swift
//  MKCinema
//
//  Created by Admin on 1/11/21.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CacheImageView: UIImageView {
    
    var imageUrlString: String?
    
    let activityIndicator = UIActivityIndicatorView()
    
    func downloadImage(from url: String) {
        activityIndicator.color = .darkGray
        
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.startAnimating()

        imageUrlString = url
        image = nil
        
        if let cachedImeg = imageCache.object(forKey: url as AnyObject) as? UIImage {
            DispatchQueue.main.async {
                self.image = cachedImeg
                self.activityIndicator.stopAnimating()
            }
            return
        }
        
        if let urlS = URL(string: url) {
            let urlRequest = URLRequest (url: urlS)
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if error != nil {
                    print(error ?? "")
                    DispatchQueue.main.async(execute: {
                        self.image = UIImage(named: "imageTMDB")
                        self.activityIndicator.stopAnimating()
                    })
                    
                    return
                }
                
                if let data = data, let downloadedImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        let imageToCache = UIImage(data: data)
                        if self.imageUrlString == url {
                            self.image = imageToCache
                        }
                        imageCache.setObject(downloadedImage, forKey: url as AnyObject)
                    }
                } else {
                    DispatchQueue.main.async(execute: {
                        self.image = UIImage(named: "imageTMDB")
                    })
                }
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                })
            }
            task.resume()
        }
    }
    
}
