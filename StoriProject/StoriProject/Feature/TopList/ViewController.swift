//
//  ViewController.swift
//  StoriProject
//
//  Created by Bodgar Espinosa Miranda on 16/12/24.
//

import UIKit
import Switchboard
import DesignSystem
import Combine

class ViewController: UITableViewController {

    var viewModel: ViewModel?
    private var cancellables: Set<AnyCancellable> = []
    private var debounceTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        
        viewModel?.reloadPublisher
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            }).store(in: &cancellables)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.movies.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { fatalError() }
        let currentMovie = viewModel?.movies[indexPath.row]
        Task {
            do {
                let uiImage = try await viewModel?.getImage(index: indexPath.row)
                let movie = Movie(title: currentMovie?.title ?? "", date: currentMovie?.releaseDate ?? "", image: uiImage)
                cell.set(movie: movie)
            } catch {}
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel else { return }
        let selectedMovie = viewModel.movies[indexPath.row]
        let vc = MovieDetailViewController(viewModel: MovieViewModel(movie: selectedMovie))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height

        if position > (contentHeight - scrollViewHeight - 100) {
            debounceTimer?.invalidate()
                        
            debounceTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
                self?.viewModel?.refresh()
            }
        }
    }
}

