//
//  AppInteractor.swift
//  Lets cook
//
//  Created by Alejandro Agudelo on 28/03/21.
//  Copyright © 2021 Alejandro Agudelo. All rights reserved.
//

import Foundation

class Interactor {
    
    let reposity = Repository.shared
    
    func getRecipes(output: @escaping (RequestResult<[Recipe]>) -> Void) {
        reposity.getRecipes { (requesResult) in
            output(requesResult)
        }
    }
}
