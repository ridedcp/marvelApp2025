import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes()
}

protocol ListHeroesUI: AnyObject {
    func update(heroes: [CharacterDataModel])
    func showLoading(_ loading: Bool)
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    
    private var offset: Int = 0
    private var isLoading = false
    private var allHeroes: [CharacterDataModel] = []
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = GetHeroes()) {
        self.getHeroesUseCase = getHeroesUseCase
    }
    
    func screenTitle() -> String {
        "List of Heroes"
    }
    
    // MARK: UseCases
    
    func getHeroes() {
        guard !isLoading else { return }
        isLoading = true
        ui?.showLoading(true)

        getHeroesUseCase.execute(offset: offset) { [weak self] characterDataContainer in
            guard let self = self else { return }

            let newHeroes = characterDataContainer.characters
            self.offset += newHeroes.count
            self.allHeroes.append(contentsOf: newHeroes)
            self.isLoading = false

            DispatchQueue.main.async {
                print("new Heroes \(newHeroes)")
                self.ui?.showLoading(false)
                self.ui?.update(heroes: self.allHeroes)
            }
        }
    }
}

