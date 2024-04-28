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
    
    let movieImageView: UIImageView = {
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
        label.font = .systemFont(ofSize: 12, weight: .light, width: .standard)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let voteAverageFirstStar :UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    let voteAverageSecondStar :UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    let voteAverageThirdStar :UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    let voteAverageFourthStar :UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    let voteAverageFifthStar :UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    let movieVoteCount: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .light, width: .standard)
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
        let starsContainer = UIView()
        starsContainer.translatesAutoresizingMaskIntoConstraints = false
        starsContainer.addSubview(voteAverageFirstStar)
        starsContainer.addSubview(voteAverageSecondStar)
        starsContainer.addSubview(voteAverageThirdStar)
        starsContainer.addSubview(voteAverageFourthStar)
        starsContainer.addSubview(voteAverageFifthStar)
        starsContainer.addSubview(movieVoteCount)
        
        view.addSubview(starsContainer)
        view.addSubview(movieImageView)
        view.addSubview(movieNameLabel)
        view.addSubview(movieDescriptionLabel)
        
        NSLayoutConstraint.activate([
            movieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            movieImageView.heightAnchor.constraint(equalToConstant: 200),
            movieImageView.widthAnchor.constraint(equalToConstant: 300),
            
            movieNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieNameLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 20),
            
            starsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            starsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            starsContainer.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 10),
            
            voteAverageFirstStar.leadingAnchor.constraint(equalTo: starsContainer.leadingAnchor),
            voteAverageFirstStar.topAnchor.constraint(equalTo: starsContainer.topAnchor),
            voteAverageFirstStar.bottomAnchor.constraint(equalTo: starsContainer.bottomAnchor),

            voteAverageSecondStar.leadingAnchor.constraint(equalTo: voteAverageFirstStar.trailingAnchor, constant: 2),
            voteAverageSecondStar.topAnchor.constraint(equalTo: starsContainer.topAnchor),

            voteAverageThirdStar.leadingAnchor.constraint(equalTo: voteAverageSecondStar.trailingAnchor, constant: 2),
            voteAverageThirdStar.topAnchor.constraint(equalTo: starsContainer.topAnchor),

            voteAverageFourthStar.leadingAnchor.constraint(equalTo: voteAverageThirdStar.trailingAnchor, constant: 2),
            voteAverageFourthStar.topAnchor.constraint(equalTo: starsContainer.topAnchor),

            voteAverageFifthStar.leadingAnchor.constraint(equalTo: voteAverageFourthStar.trailingAnchor, constant: 2),
            voteAverageFifthStar.topAnchor.constraint(equalTo: starsContainer.topAnchor),
            
            movieVoteCount.leadingAnchor.constraint(equalTo: voteAverageFifthStar.trailingAnchor, constant: 7),
            movieVoteCount.topAnchor.constraint(equalTo: starsContainer.topAnchor),
            movieVoteCount.bottomAnchor.constraint(equalTo: starsContainer.bottomAnchor),
            
            movieDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieDescriptionLabel.topAnchor.constraint(equalTo: starsContainer.bottomAnchor, constant: 20)
        ])
    }
}

extension DetailView: DetailPresenterUI {
    func updateUI(viewmodel: DetailMovieViewModel) {
        movieNameLabel.text = viewmodel.title
        movieDescriptionLabel.text = viewmodel.overview
        movieImageView.kf.setImage(with: viewmodel.backdropPath)
        setupStars(viewmodel)
        movieVoteCount.text = "\(viewmodel.voteCount) votes"
        
        
    }
    
    private func setupStars(_ viewmodel: DetailMovieViewModel) {
        switch viewmodel.voteAverage {
        case 0..<0.5:
            voteAverageFirstStar.image = UIImage(systemName: "star.leadinghalf.fill")
            voteAverageSecondStar.image = UIImage(systemName: "star")
            voteAverageThirdStar.image = UIImage(systemName: "star")
            voteAverageFourthStar.image = UIImage(systemName: "star")
            voteAverageFifthStar.image = UIImage(systemName: "star")
        
        case 0..<1:
            voteAverageFirstStar.image = UIImage(systemName: "star.fill")
            voteAverageSecondStar.image = UIImage(systemName: "star")
            voteAverageThirdStar.image = UIImage(systemName: "star")
            voteAverageFourthStar.image = UIImage(systemName: "star")
            voteAverageFifthStar.image = UIImage(systemName: "star")

        case 1..<1.5:
            voteAverageFirstStar.image = UIImage(systemName: "star.fill")
            voteAverageSecondStar.image = UIImage(systemName: "star.leadinghalf.fill")
            voteAverageThirdStar.image = UIImage(systemName: "star")
            voteAverageFourthStar.image = UIImage(systemName: "star")
            voteAverageFifthStar.image = UIImage(systemName: "star")
        
        case 1.5..<2:
            voteAverageFirstStar.image = UIImage(systemName: "star.fill")
            voteAverageSecondStar.image = UIImage(systemName: "star.fill")
            voteAverageThirdStar.image = UIImage(systemName: "star")
            voteAverageFourthStar.image = UIImage(systemName: "star")
            voteAverageFifthStar.image = UIImage(systemName: "star")
        
        case 2..<2.5:
            voteAverageFirstStar.image = UIImage(systemName: "star.fill")
            voteAverageSecondStar.image = UIImage(systemName: "star.fill")
            voteAverageThirdStar.image = UIImage(systemName: "star.leadinghalf.fill")
            voteAverageFourthStar.image = UIImage(systemName: "star")
            voteAverageFifthStar.image = UIImage(systemName: "star")
        
        case 2.5..<3:
            voteAverageFirstStar.image = UIImage(systemName: "star.fill")
            voteAverageSecondStar.image = UIImage(systemName: "star.fill")
            voteAverageThirdStar.image = UIImage(systemName: "star.fill")
            voteAverageFourthStar.image = UIImage(systemName: "star")
            voteAverageFifthStar.image = UIImage(systemName: "star")
            
        case 3..<3.5:
            voteAverageFirstStar.image = UIImage(systemName: "star.fill")
            voteAverageSecondStar.image = UIImage(systemName: "star.fill")
            voteAverageThirdStar.image = UIImage(systemName: "star.fill")
            voteAverageFourthStar.image = UIImage(systemName: "star.leadinghalf.fill")
            voteAverageFifthStar.image = UIImage(systemName: "star")
            
        case 3.5..<4:
            voteAverageFirstStar.image = UIImage(systemName: "star.fill")
            voteAverageSecondStar.image = UIImage(systemName: "star.fill")
            voteAverageThirdStar.image = UIImage(systemName: "star.fill")
            voteAverageFourthStar.image = UIImage(systemName: "star.fill")
            voteAverageFifthStar.image = UIImage(systemName: "star")
        
        case 4..<4.5:
            voteAverageFirstStar.image = UIImage(systemName: "star.fill")
            voteAverageSecondStar.image = UIImage(systemName: "star.fill")
            voteAverageThirdStar.image = UIImage(systemName: "star.fill")
            voteAverageFourthStar.image = UIImage(systemName: "star.fill")
            voteAverageFifthStar.image = UIImage(systemName: "star.leadinghalf.fill")
            
        case 4.5..<5:
            voteAverageFirstStar.image = UIImage(systemName: "star.fill")
            voteAverageSecondStar.image = UIImage(systemName: "star.fill")
            voteAverageThirdStar.image = UIImage(systemName: "star.fill")
            voteAverageFourthStar.image = UIImage(systemName: "star.fill")
            voteAverageFifthStar.image = UIImage(systemName: "star.fill")
            
        default:
            print("No vote average was retrieved from API.")
        }
    }
}
