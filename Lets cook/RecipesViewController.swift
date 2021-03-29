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
