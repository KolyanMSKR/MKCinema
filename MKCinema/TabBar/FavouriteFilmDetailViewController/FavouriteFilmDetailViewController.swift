//
//  FavouriteFilmDetailViewController.swift
//  MKCinema
//
//  Created by Admin on 1/12/21.
//

import UIKit

class FavouriteFilmDetailViewController: UIViewController {
    
    var film: Film!
    
    private let filmTitleLabel = UILabel(title: "title", font: .systemFont(ofSize: 26, weight: .semibold), textAlignment: .center)
    private let genresTitleLabel = UILabel(title: "genres",
                                           font: .systemFont(ofSize: 14),
                                           numberOfLines: 0,
                                           lineBreakMode: .byWordWrapping,
                                           textAlignment: .center)
    
    override func loadView() {
        super.loadView()
        
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func setupUI() {
        view.addSubview(filmTitleLabel)
        view.addSubview(genresTitleLabel)
        
        NSLayoutConstraint.activate([
            filmTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            filmTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            filmTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            genresTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genresTitleLabel.topAnchor.constraint(equalTo: filmTitleLabel.bottomAnchor, constant: 30)
        ])
    }
    
    private func configureUI() {
        if let film = film {
            filmTitleLabel.text = film.originalTitle
            
            var genres = ""
            film.genres?.forEach({ genres += $0.name + "\n" })
            genresTitleLabel.text = genres
        }
    }
    
}
