//
//  RecipesViewController.swift
//  Lets cook
//
//  Created by Alejandro Agudelo on 28/03/21.
//  Copyright © 2021 Alejandro Agudelo. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backgroundMessage: UILabel!
    @IBOutlet weak var recipeTableView: UITableView!
    
    var tableViewSource = [Recipe]() {
        didSet {
            recipeTableView.reloadData()
        }
    }
    
    let presenter = RecipesPresenter()
    
    struct Constants {
        static let reuseIdentifier = "recipeCellID"
        static let showDetailSegue = "showDetail"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    func updateViewWith(message: String) {
        recipeTableView.isHidden = true
        backgroundMessage.text = message
    }
    
    func updateViewWith(recipes: [Recipe]) {
        recipeTableView.isHidden = false
        tableViewSource = recipes
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showDetailSegue {
            guard let row = sender as? Int,
                let vc = segue.destination as? RecipeDetailViewController else {
                return
            }
            vc.recipeId = tableViewSource[row].id
        }
    }
}

extension RecipesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = tableViewSource[indexPath.row].title
        cell.detailTextLabel?.text = tableViewSource[indexPath.row].title
        return cell
    }
}

extension RecipesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Constants.showDetailSegue, sender: indexPath.row)
    }
}

extension RecipesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchRecipeWith(searchText)
    }
}
