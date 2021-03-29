//
//  RecipeDetailPresenter.swift
//  Lets cook
//
//  Created by Alejandro Agudelo on 29/03/21.
//  Copyright © 2021 Alejandro Agudelo. All rights reserved.
//

import Foundation

class RecipeDetailPresenter{
    weak var view: RecipeDetailViewController?
    var interactor = Interactor()

    init() {
        self.view = nil
    }

    init(view: RecipeDetailViewController) {
        self.view = view
    }

    func setView(view: RecipeDetailViewController) {
        self.view = view
    }

    func viewWillAppear(recipeId: Int) {
        interactor.getRecipeDetail(id: recipeId) { [weak self] (requestResult) in
            switch requestResult {
            case .success(let data):
                self?.updateViewWith(recipe: data)
            case .error(let message):
                break
            }
        }
    }
    
    private func updateViewWith(recipe: RecipeDetail) {
        DispatchQueue.main.async {
            self.view?.updateViewWith(recipe: recipe)
        }
    }
}



