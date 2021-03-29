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
                self?.updateViewWith(recipes: data)
            case .error(let message):
                self?.updateViewWith(message: message)
            }
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
}
