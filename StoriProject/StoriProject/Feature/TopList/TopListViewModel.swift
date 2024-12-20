//
//  TopListViewModel.swift
//  StoriProject
//
//  Created by Bodgar Espinosa Miranda on 18/12/24.
//

import Foundation
import UIKit
import Switchboard
import Common
import Combine

protocol ViewModel {
    var movies: [MovieResponse.Movie] { get set }
    var reloadPublisher: AnyPublisher<Void, Error> { get }
    func getImage(index: Int) async throws -> UIImage
    func refresh()
}


final class TopListViewModel: ViewModel {
    
    var movies: [MovieResponse.Movie] = [] {
        didSet {
            reloadSubject.send(())
        }
    }
    
    var reloadPublisher: AnyPublisher<Void, Error> {
        return reloadSubject.share().eraseToAnyPublisher()
    }

    private let reloadSubject = CurrentValueSubject<Void, Error>(())
    
    @Dependency var movieService: TopListMovieService
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        movieService.topListPublisher
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] result in
                switch result {
                case .failure(_):
                    break
                case .success(let movie):
                    self?.movies.append(contentsOf: movie.results)
                }
            }).store(in: &cancellables)
        
        movieService.refresh()
    }
    
    func refresh() {
        movieService.refresh()
    }
    
    func getImage(index: Int) async throws -> UIImage {
        let imageCache = NSCache<AnyObject, AnyObject>()
        let poster = movies[index].posterPath
        
        if let cachedImage = imageCache.object(forKey: poster as AnyObject) as? UIImage {
            return cachedImage
        }
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "ImageDownloadError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se pudo convertir los datos en una imagen."])
        }
        
        imageCache.setObject(image, forKey: poster as AnyObject)
        
        return image
    }
}
