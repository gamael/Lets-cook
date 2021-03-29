//
//  Models.swift
//  Lets cook
//
//  Created by Alejandro Agudelo on 28/03/21.
//  Copyright © 2021 Alejandro Agudelo. All rights reserved.
//

import Foundation
import UIKit

enum RequestResult<T> {
    case success(T)
    case error(String)
}

struct Recipe: Codable {
    let id: Int
    let title: String
}

struct RecipeDetail: Codable {
    let id: Int
    let title: String
    let rating: Int
    let image: String
    let instructions: String
}

extension Decodable {
  
  static func decode(with decoder: JSONDecoder = JSONDecoder(), from data: Data) throws -> Self {
    return try decoder.decode(Self.self, from: data)
  }
}

extension Encodable {
  
  func encode(with encoder: JSONEncoder = JSONEncoder()) throws -> Data {
    return try encoder.encode(self)
  }
  
}

extension UIImageView {
    func loadImage(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        let activityView = UIActivityIndicatorView(style: .medium)
        activityView.center = center
        addSubview(activityView)
        activityView.startAnimating()
        activityView.hidesWhenStopped = true
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
            DispatchQueue.main.async {
                activityView.stopAnimating()
            }
        }
    }
    
    func loadImage(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        loadImage(from: url, contentMode: mode)
    }
}
