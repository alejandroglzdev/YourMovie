//
//  DetailView.swift
//  YourMovie
//
//  Created by Carlos Gonzalez2 on 27/4/24.
//

import Foundation
import UIKit
import Kingfisher

class DetailView: UIViewController {
    private let presenter: DetailPresentable
    
    let movieImageVIew: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 32, weight: .bold, width: .condensed)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .bold, width: .standard)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(presenter: DetailPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        presenter.onViewAppear()
    }
    
    func setupView() {
        view.addSubview(movieImageVIew)
        view.addSubview(movieNameLabel)
        view.addSubview(movieDescriptionLabel)
        
        NSLayoutConstraint.activate([
            movieImageVIew.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieImageVIew.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            movieImageVIew.heightAnchor.constraint(equalToConstant: 200),
            movieImageVIew.widthAnchor.constraint(equalToConstant: 300),
            
            movieNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieNameLabel.topAnchor.constraint(equalTo: movieImageVIew.bottomAnchor, constant: 20),
            
            movieDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieDescriptionLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 20)
        ])
    }
}

extension DetailView: DetailPresenterUI {
    func updateUI(viewmodel: DetailMovieViewModel) {
        movieNameLabel.text = viewmodel.title
        movieDescriptionLabel.text = viewmodel.overview
        movieImageVIew.kf.setImage(with: viewmodel.backdropPath)
    }
}
