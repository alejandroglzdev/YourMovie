//
//  ListOfMoviesView.swift
//  YourMovie
//
//  Created by Carlos Gonzalez2 on 20/4/24.
//

import Foundation
import UIKit

class ListOfMoviesView: UIViewController {
    private var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MovieCellView.self, forCellReuseIdentifier: "MovieCellView")
        return tableView
    }()
    
    private var movieNavigationItem: UINavigationItem = {
        let navigationItem = UINavigationItem()
        navigationItem.title = K.App.appName
        return navigationItem
    }()
    
    private let presenter: ListOfMoviesPresentable
    
    init(presenter: ListOfMoviesPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        presenter.onViewAppear()
    }
    
    private func setupTableView() {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.items = [movieNavigationItem]
        
        view.addSubview(navigationBar)
        view.addSubview(moviesTableView)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 44),
            
            moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            moviesTableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        ])
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
    }
}

extension ListOfMoviesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onTapCell(atIndex: indexPath.row)
    }
}

extension ListOfMoviesView: ListOfMoviesUI {
    func update(movies: [MovieViewModel]) {
        print(movies)
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
        }
    }
}

extension ListOfMoviesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.movieViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellView", for: indexPath) as! MovieCellView
        let model = presenter.movieViewModels[indexPath.row]
        
        cell.configure(model: model)
        
        return cell
    }
}
