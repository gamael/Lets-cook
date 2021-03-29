//
//  Models.swift
//  Lets cook
//
//  Created by Alejandro Agudelo on 28/03/21.
//  Copyright © 2021 Alejandro Agudelo. All rights reserved.
//

import Foundation

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
