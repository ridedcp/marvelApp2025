import Foundation

protocol MarvelRepositoryProtocol {
    func getHeroes(offset: Int, completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getComics(for heroId: Int, completionBlock: @escaping ([Comic]) -> Void)
}

final class MarvelRepository: MarvelRepositoryProtocol {
    private let dataSource: MarvelDataSourceProtocol
    
    init(dataSource: MarvelDataSourceProtocol = MarvelDataSource()) {
        self.dataSource = dataSource
    }
    
    func getHeroes(offset: Int, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        dataSource.getHeroes(offset: offset, completionBlock: completionBlock)
    }
    
    func getComics(for heroId: Int, completionBlock: @escaping ([Comic]) -> Void) {
        dataSource.getComics(for: heroId, completionBlock: completionBlock)
    }
}
