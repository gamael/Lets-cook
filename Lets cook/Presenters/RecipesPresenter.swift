//
//  RecipesPresenter.swift
//  Lets cook
//
//  Created by Alejandro Agudelo on 28/03/21.
//  Copyright © 2021 Alejandro Agudelo. All rights reserved.
//

import Foundation

class RecipesPresenter {
    
    weak var view: RecipesViewController?
    var interactor = Interactor()
    
    var allRecipes = [Recipe]()
    
    init() {
        self.view = nil
    }
    
    init(view: RecipesViewController) {
        self.view = view
    }
    
    func setView(view: RecipesViewController) {
        self.view = view
    }
    
    func viewWillAppear() {
        interactor.getRecipes { [weak self] (requestResult) in
            switch requestResult {
            case .success(let data):
                self?.allRecipes = data
                self?.updateViewWith(recipes: data)
            case .error(let message):
                self?.updateViewWith(message: message)
            }
        }
    }
    
    func searchRecipeWith(_ searchString: String) {
        guard searchString.count > 0 else {
            restoreOriginalResults()
            return
        }
        
        let resultRecipes = allRecipes.filter { (recipe) -> Bool in
            return recipe.title.contains(searchString)
        }
        if resultRecipes.count > 0 {
            updateViewWith(recipes: resultRecipes)
        } else {
            updateViewWith(message: "No results")
        }
        
    }
    
    private func updateViewWith(message: String) {
        DispatchQueue.main.async {
            self.view?.updateViewWith(message: message)
        }
    }
    
    private func updateViewWith(recipes: [Recipe]) {
        DispatchQueue.main.async {
            self.view?.updateViewWith(recipes: recipes)
        }
    }
    
    private func restoreOriginalResults() {
        DispatchQueue.main.async {
            self.view?.updateViewWith(recipes: self.allRecipes)
        }
    }
}
