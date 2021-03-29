//
//  RecipeDetailViewController.swift
//  Lets cook
//
//  Created by Alejandro Agudelo on 29/03/21.
//  Copyright © 2021 Alejandro Agudelo. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeTimage: UIImageView!
    @IBOutlet weak var recipeDetails: UILabel!
    
    let presenter = RecipeDetailPresenter()
    var recipeId: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear(recipeId: recipeId)
    }
    
    func updateViewWith(recipe: RecipeDetail) {
        recipeTitle.text = recipe.title
        recipeDetails.text = recipe.instructions
    }
}
