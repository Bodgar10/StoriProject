//
//  DemoMovieTableViewController.swift
//  DesignSystemDemo
//
//  Created by Bodgar Espinosa Miranda on 17/12/24.
//

import UIKit
import DesignSystem

class DemoMovieTableViewController: UITableViewController {

    var movies: [Movie] =
    [
        .init(title: "Star Wars", date: "2021", image: Icons.Example.example!),
        .init(title: "The Matrix", date: "2021", image: Icons.Example.example!),
        .init(title: "The Avengers", date: "2021", image: Icons.Example.example!),
        .init(title: "The Dark Knight", date: "2021", image: Icons.Example.example!),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Movie Cells"
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { fatalError() }
        cell.set(movie: movies[indexPath.row])
        return cell
    }
}
