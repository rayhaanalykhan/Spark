//
//  UIImageView+Extension.swift
//  Spark
//
//  Created by rayhaanalykhan on 27/06/2024.
//

import UIKit
import Kingfisher

extension UIImageView {

//     use this to load image as well as video thumbnail from url.
    func loadImage(with urlString: String?, placeholder: UIImage? = UIImage(named: .placeholder), completion: ((_ isSuccess: Bool) -> Void)? = nil) {
        
        contentMode = .scaleToFill
        
        image = placeholder
        
        backgroundColor = UIColor.clear
        
        guard let urlString else {
            completion?(false)
            print("Missing URL")
            return
        }
        guard let url = URL(string: urlString) else {
            completion?(false)
            print("Invalid URL")
            return
        }
        
        kf.indicatorType = .activity
        
        kf.setImage(with: url, placeholder: placeholder) { result in
            self.handleImageResult(result, completion: completion)
        }
    }

        private func handleImageResult(_ result: Result<RetrieveImageResult, KingfisherError>, completion: ((Bool) -> Void)? = nil) {

            switch result {

            case .success(let value):

                // Handle aspect ratio
                image = value.image

                contentMode = .scaleToFill

                completion?(true)

            case .failure(let error):
                completion?(false)
                print("Error loading image: \(error.localizedDescription)")
            }
        }
}
