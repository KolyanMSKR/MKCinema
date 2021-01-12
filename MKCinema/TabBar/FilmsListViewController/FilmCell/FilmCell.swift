//
//  FilmCell.swift
//  MKCinema
//
//  Created by Admin on 1/10/21.
//

import UIKit
import SnapKit

class FilmCell: UITableViewCell {
    
    let filmImageView: CacheImageView = {
        let imageView = CacheImageView()
        
        return imageView
    }()
    
    let filmTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.minimumScaleFactor = 0.3
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let filmScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(filmImageView)
        contentView.addSubview(filmTitleLabel)
        contentView.addSubview(filmScoreLabel)
    }
    
    private func setupConstraints() {
        filmImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.leading.equalToSuperview().inset(12)
            make.width.equalTo(filmImageView.snp.height).multipliedBy(0.6)
        }
        
        filmTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(filmImageView.snp_trailingMargin).inset(-12)
            make.trailing.equalTo(contentView.snp_trailingMargin).inset(20)
            make.centerY.equalTo(contentView)
        }
        
        filmScoreLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
        }
    }
    
}
