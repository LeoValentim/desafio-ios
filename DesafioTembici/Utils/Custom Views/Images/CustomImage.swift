//
//  CustomImage.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImage: UIImageView {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .gray
        indicator.hidesWhenStopped = true
        indicator.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        indicator.isUserInteractionEnabled = false
        indicator.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        return indicator
    }()
    
    var imageUrlString: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(activityIndicator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    func loadAndCacheImage(from urlString: String, completion: (() -> Void)? = nil) {
        if let url = URL(string: urlString) {
            loadAndCacheImage(from: url, completion: completion)
        }
    }
    
    func loadAndCacheImage(from url: URL, completion: (() -> Void)? = nil) {
        let urlString = url.absoluteString
        imageUrlString = urlString
        
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            completion?()
            return
        }
        
        let networkLayer = NetworkLayerAlamofire()
        
        activityIndicator.startAnimating()
        networkLayer.get(url, headers: nil, completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.activityIndicator.stopAnimating()
                if let imageToCache = UIImage(data: data) {
                    if self?.imageUrlString == urlString {
                        self?.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: urlString as NSString)
                    completion?()
                }
            case .failure(let err):
                self?.activityIndicator.stopAnimating()
                print(err)
            }
        })
    }
    
}

