//
//  Untitled.swift
//  WallaMarvel
//
//  Created by Daniel Cano on 2/4/25.
//

import UIKit
import Kingfisher

final class HeroDetailViewController: UIViewController {
    private var presenter: HeroDetailPresenterProtocol
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    private let comicsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Comics"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private let comicsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    init(presenter: HeroDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.ui = self
        self.title = presenter.screenTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        presenter.onViewLoaded()
    }
    
    private func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        comicsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        comicsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(comicsTitleLabel)
        view.addSubview(comicsStackView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            comicsTitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
            comicsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            comicsTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            comicsStackView.topAnchor.constraint(equalTo: comicsTitleLabel.bottomAnchor, constant: 8),
            comicsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            comicsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

extension HeroDetailViewController: HeroDetailUI {
    func showHero(name: String, imageURL: URL?) {
        nameLabel.text = name
        imageView.kf.setImage(with: imageURL)
    }
    
    func showComics(_ comics: [Comic]) {
        DispatchQueue.main.async {
            self.comicsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

            if comics.isEmpty {
                let label = UILabel()
                label.text = "No comics found."
                label.textColor = .gray
                label.font = .italicSystemFont(ofSize: 14)
                self.comicsStackView.addArrangedSubview(label)
            } else {
                comics.forEach { comic in
                    let label = UILabel()
                    label.text = "• \(comic.title)"
                    label.numberOfLines = 0
                    self.comicsStackView.addArrangedSubview(label)
                }
            }
        }
    }
}
