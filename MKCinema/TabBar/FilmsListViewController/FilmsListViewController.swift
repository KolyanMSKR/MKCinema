//
//  ViewController.swift
//  MKCinema
//
//  Created by Admin on 1/10/21.
//

import UIKit

class FilmsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let backendAPI = BackendAPI()
    private var tabbarTitle = "" {
        didSet {
            tabBarController?.title = tabbarTitle
        }
    }
    private var films: [Film] = [] {
        didSet {
            if let tableView = tableView {
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getFilms()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.title = tabbarTitle
    }
    
    // MARK: - Private methods
    private func getFilms() {
        backendAPI.fetchMoviesList { [weak self] movies in
            guard let self = self else { return }
            guard let movies = movies else { return }
            
            self.films = movies.films
            self.tabbarTitle = movies.name
        }
    }
    
    @objc private func longPressAction(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                if let favouriteVC = tabBarController?.viewControllers?[1] as? FavouritesFilmsViewController {
                    backendAPI.fetchGenres(movieID: films[indexPath.row].id) { film in
                        guard let film = film else { return }
                        
                        if !favouriteVC.films.contains(film) {
                            favouriteVC.films.append(film)
                        }
                    }
                }
            }
        }
    }
    
    private func setupTableView() {
        tableView.register(FilmCell.self, forCellReuseIdentifier: "FilmCell")
        tableView.tableFooterView = UIView()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        tableView.addGestureRecognizer(longPress)
    }

}

// MARK: - UITableViewDelegate
extension FilmsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "List", bundle:nil)

        guard let filmsDetailVC = storyboard.instantiateViewController(identifier: "FilmDetailViewController")
                as? FilmDetailViewController else {
            
            return
        }
        
        filmsDetailVC.film = films[indexPath.row]
        self.navigationController?.pushViewController(filmsDetailVC, animated: true)
    }
    
}

// MARK: - UITableViewDataSource
extension FilmsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell
        cell.filmTitleLabel.text = films[indexPath.row].originalTitle
        cell.filmImageView.downloadImage(from: "https://image.tmdb.org/t/p/original" + films[indexPath.row].posterPath)
        cell.filmScoreLabel.text = "\(films[indexPath.row].voteAverage)/10"
        
        return cell
    }
    
}





