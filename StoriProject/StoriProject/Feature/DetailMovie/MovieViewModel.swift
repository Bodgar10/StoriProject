//
//  MovieViewModel.swift
//  StoriProject
//
//  Created by Bodgar Espinosa Miranda on 20/12/24.
//

import Foundation
import Switchboard
import UIKit

final class MovieViewModel {
    
    public let movie: MovieResponse.Movie
    
    init(movie: MovieResponse.Movie) {
        self.movie = movie
    }
    
    func getImage() async throws -> UIImage {
        let imageCache = NSCache<AnyObject, AnyObject>()
        let poster = movie.posterPath
        
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
