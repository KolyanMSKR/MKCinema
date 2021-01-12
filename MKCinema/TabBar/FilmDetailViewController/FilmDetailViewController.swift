//
//  FilmDetailViewController.swift
//  MKCinema
//
//  Created by Admin on 1/10/21.
//

import UIKit

class FilmDetailViewController: UIViewController {
    
    @IBOutlet weak var filmImageView: CacheImageView!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var filmDescriptionTextView: UITextView!
    
    var film: Film!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        filmImageView.downloadImage(from: "https://image.tmdb.org/t/p/original" + film.backdropPath)
        filmTitleLabel.text = "\(film.originalTitle). \(film.releaseDate.convertDateFormat())"
        filmDescriptionTextView.text = film.overview
    }
    
}
