//
//  Repository.swift
//  Lets cook
//
//  Created by Alejandro Agudelo on 28/03/21.
//  Copyright © 2021 Alejandro Agudelo. All rights reserved.
//

import Foundation

class Repository {
    
    static let shared = Repository()
    
    struct Constants {
        static let getRecipesURL = "http://gl-endpoint.herokuapp.com/recipes/"
    }
    
    private init() {}
    
    func getRecipes(output: @escaping (RequestResult<[Recipe]>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: Constants.getRecipesURL) else {
            output(.error("Error creating request"))
            return
        }
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else {
                output(.error("The respone contained errors"))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                output(.error("Unvalid response"))
                return
            }
            
            guard let data = data else {
                output(.error("The server returned an empty response"))
                return
            }

            do {
                let recipes = try [Recipe].decode(from: data)
                output(.success(recipes))
            } catch {
                output(.error("Error decoding"))
            }
        })
        task.resume()
    }
    
    func getRecipeDetail(id: Int, output: @escaping (RequestResult<RecipeDetail>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: "\(Constants.getRecipesURL)\(id)") else {
            output(.error("Error creating request"))
            return
        }
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else {
                output(.error("The respone contained errors"))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                output(.error("Unvalid response"))
                return
            }
            
            guard let data = data else {
                output(.error("The server returned an empty response"))
                return
            }

            do {
                let recipe = try RecipeDetail.decode(from: data)
                output(.success(recipe))
            } catch {
                output(.error("Error decoding"))
            }
        })
        task.resume()
    }
    
}
