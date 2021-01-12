//
//  FavouritesFilmsViewController.swift
//  MKCinema
//
//  Created by Admin on 1/10/21.
//

import UIKit

class FavouritesFilmsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var films: [Film] = []
    
    // MARK: - Lifecycle methods
    override func loadView() {
        super.loadView()
        
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        tabBarController?.title = "Favourites Films"
    }
    
    // MARK: - Private methods
    @objc private func longPressAction(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                films.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            }
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        let cellNib = UINib(nibName: "FavouriteFilmCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "FavouriteFilmCell")
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        tableView.addGestureRecognizer(longPress)
    }
    
}

// MARK: - UITableViewDelegate
extension FavouritesFilmsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filmsDetailVC = FavouriteFilmDetailViewController()
        filmsDetailVC.film = films[indexPath.row]
        self.navigationController?.pushViewController(filmsDetailVC, animated: true)
    }
    
}

// MARK: - UITableViewDataSource
extension FavouritesFilmsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteFilmCell", for: indexPath)
            as? FavouriteFilmCell {
            
            let film = films[indexPath.row]
            cell.filmImageView.downloadImage(from: "https://image.tmdb.org/t/p/original" + film.posterPath)
            cell.filmTitleLabel.text = film.originalTitle
            cell.filmDescriptionLabel.text = film.overview
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}
