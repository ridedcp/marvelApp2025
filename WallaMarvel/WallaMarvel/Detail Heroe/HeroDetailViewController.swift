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
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        comicsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        comicsStackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(comicsTitleLabel)
        contentView.addSubview(comicsStackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            comicsTitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
            comicsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            comicsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            comicsStackView.topAnchor.constraint(equalTo: comicsTitleLabel.bottomAnchor, constant: 8),
            comicsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            comicsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            comicsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
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
