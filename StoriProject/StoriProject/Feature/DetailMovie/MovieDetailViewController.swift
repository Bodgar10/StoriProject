//
//  MovieDetailViewController.swift
//  StoriProject
//
//  Created by Bodgar Espinosa Miranda on 20/12/24.
//

import UIKit
import Switchboard
import DesignSystem

class MovieDetailViewController: UIViewController {

    private let viewModel: MovieViewModel

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.H1.attributes.font
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.H3.attributes.font
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.H5.attributes.font
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.H5.attributes.font
        label.textColor = Colors.color900
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = viewModel.movie.title

        setupViews()
        layoutViews()
        configureWithMovie()
    }

    private func setupViews() {
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(posterImageView)
        mainStackView.addArrangedSubview(descriptionLabel)
        mainStackView.addArrangedSubview(releaseDateLabel)
        mainStackView.addArrangedSubview(ratingLabel)
        view.addSubview(mainStackView)
    }

    private func layoutViews() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        posterImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }

    private func configureWithMovie() {
        titleLabel.text = viewModel.movie.title
        descriptionLabel.text = viewModel.movie.overview
        releaseDateLabel.text = "Release Date: \(viewModel.movie.releaseDate)"
        ratingLabel.text = "Rating: \(viewModel.movie.voteAverage)"
        Task {
            do {
                posterImageView.image = try await viewModel.getImage()
            } catch {}
        }
    }
}
