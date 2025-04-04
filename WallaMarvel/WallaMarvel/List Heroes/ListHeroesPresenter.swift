import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes()
    func filterHeroes(with query: String)
}

protocol ListHeroesUI: AnyObject {
    func update(heroes: [CharacterDataModel])
    func showLoading(_ loading: Bool)
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    
    private var query: String?
    private var offset: Int = 0
    private var isLoading = false
    private var allHeroes: [CharacterDataModel] = []
    private var totalCount: Int = .max
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = GetHeroes()) {
        self.getHeroesUseCase = getHeroesUseCase
    }
    
    func screenTitle() -> String {
        "List of Heroes"
    }
    
    // MARK: UseCases
    
    func getHeroes() {
        guard !isLoading, offset < totalCount else { return }
        isLoading = true
        ui?.showLoading(true)

        getHeroesUseCase.execute(offset: offset, query: query) { [weak self] container in
            guard let self = self else { return }

            let newHeroes = container.characters
            self.totalCount = container.total
            
            self.offset += newHeroes.count
            if self.offset == newHeroes.count {
                self.allHeroes = newHeroes
            } else {
                self.allHeroes.append(contentsOf: newHeroes)
            }

            self.isLoading = false
            DispatchQueue.main.async {
                print("new Heroes \(newHeroes)")
                self.ui?.showLoading(false)
                self.ui?.update(heroes: self.allHeroes)
            }
        }
    }
    
    func filterHeroes(with query: String) {
        let normalizedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if normalizedQuery != self.query {
            self.query = normalizedQuery
            self.offset = 0
            self.allHeroes = []
            ui?.update(heroes: [])
            getHeroes()
        }
    }

}

