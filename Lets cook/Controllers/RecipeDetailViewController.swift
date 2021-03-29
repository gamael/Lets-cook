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
    @IBOutlet weak var starsStackView: UIStackView!
    
    let presenter = RecipeDetailPresenter()
    var recipeId: Int = 0
    
    struct Constants {
        static let filledStarImage = UIImage(named: "fill_star")
        static let unfilledStarImage = UIImage(named: "unfilled_star")
    }

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
        recipeTimage.loadImage(from: recipe.image)
        addRating(recipe.rating)
    }
    
    private func addRating(_ rating: Int) {
        for i in 1...5 {
            if rating >= i {
                let imageView = UIImageView(image: Constants.filledStarImage)
                starsStackView.addArrangedSubview(imageView)
            } else {
                let imageView = UIImageView(image: Constants.unfilledStarImage)
                starsStackView.addArrangedSubview(imageView)
            }
        }
    }
}
