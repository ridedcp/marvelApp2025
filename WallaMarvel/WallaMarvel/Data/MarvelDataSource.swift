import Foundation

protocol MarvelDataSourceProtocol {
    func getHeroes(completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getComics(for heroId: Int, completionBlock: @escaping ([Comic]) -> Void)
}

final class MarvelDataSource: MarvelDataSourceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getHeroes(completionBlock: @escaping (CharacterDataContainer) -> Void) {
        return apiClient.getHeroes(completionBlock: completionBlock)
    }
    
    func getComics(for heroId: Int, completionBlock: @escaping ([Comic]) -> Void) {
        return apiClient.getComics(for: heroId, completionBlock: completionBlock)
    }
}
