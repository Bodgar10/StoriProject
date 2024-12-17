//
//  MovieTableViewCell.swift
//  DesignSystem
//
//  Created by Bodgar Espinosa Miranda on 17/12/24.
//

import UIKit

public struct Movie {
    public let title: String
    public let date: String
    public let image: UIImage
    
    public init(
        title: String,
        date: String,
        image: UIImage
    ) {
        self.title = title
        self.date = date
        self.image = image
    }
}

public class MovieTableViewCell: UITableViewCell {
    
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var movieImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.H2.attributes.font
        label.textColor = Colors.color900
        label.accessibilityIgnoresInvertColors = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.T2.attributes.font
        label.textColor = Colors.color700
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(movie: Movie) {
        movieImageView.image = movie.image
        titleLabel.text = movie.title
        dateLabel.text = movie.date
    }
    
    private func setupUI() {
        contentView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(movieImageView)
        mainStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(titleLabel)
        horizontalStackView.addArrangedSubview(dateLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            movieImageView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
