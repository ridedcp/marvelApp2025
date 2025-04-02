//
//  HeroDetailPresenter.swift
//  WallaMarvel
//
//  Created by Daniel Cano on 2/4/25.
//

import Foundation

protocol HeroDetailPresenterProtocol {
    var ui: HeroDetailUI? { get set }
    func onViewLoaded()
    func screenTitle() -> String
}

protocol HeroDetailUI: AnyObject {
    func showHero(name: String, imageURL: URL?)
}

final class HeroDetailPresenter: HeroDetailPresenterProtocol {
    weak var ui: HeroDetailUI?
    private let hero: CharacterDataModel
    
    init(hero: CharacterDataModel) {
        self.hero = hero
    }
    
    func onViewLoaded() {
        let urlString = "\(hero.thumbnail.path)/portrait_uncanny.\(hero.thumbnail.extension)"
        ui?.showHero(name: hero.name, imageURL: URL(string: urlString))
    }
    
    func screenTitle() -> String {
        return "Hero Detail"
    }
}
