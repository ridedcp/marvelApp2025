import Foundation

protocol APIClientProtocol {
    func getHeroes(offset: Int, query: String?, completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getComics(for heroId: Int, completionBlock: @escaping ([Comic]) -> Void)
}

final class APIClient: APIClientProtocol {
    enum Constant {
        static let privateKey = "188f9a5aa76846d907c41cbea6506e4cc455293f"
        static let publicKey = "d575c26d5c746f623518e753921ac847"
    }
    
    init() { }
    
    func getHeroes(offset: Int = 0, query: String? = nil, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        let ts = String(Int(Date().timeIntervalSince1970))
        let privateKey = Constant.privateKey
        let publicKey = Constant.publicKey
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        
        var parameters: [String: String] = ["apikey": publicKey,
                                            "ts": ts,
                                            "hash": hash,
                                            "offset": String(offset)]
        
        if let query = query, !query.isEmpty {
            parameters["nameStartsWith"] = query
        }
        
        
        let endpoint = "https://gateway.marvel.com:443/v1/public/characters"
        var urlComponent = URLComponents(string: endpoint)
        urlComponent?.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        let urlRequest = URLRequest(url: urlComponent!.url!)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let dataModel = try! JSONDecoder().decode(CharacterDataContainer.self, from: data!)
            completionBlock(dataModel)
            print(dataModel)
        }.resume()
    }
    
    func getComics(for heroId: Int, completionBlock: @escaping ([Comic]) -> Void) {
        let ts = String(Int(Date().timeIntervalSince1970))
        let privateKey = Constant.privateKey
        let publicKey = Constant.publicKey
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        let parameters: [String: String] = ["apikey": publicKey,
                                            "ts": ts,
                                            "hash": hash]

        let endpoint = "https://gateway.marvel.com:443/v1/public/characters/\(heroId)/comics"
        var urlComponent = URLComponents(string: endpoint)
        urlComponent?.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        guard let url = urlComponent?.url else { return }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                completionBlock([])
                return
            }

            do {
                let decoded = try JSONDecoder().decode(ComicDataWrapper.self, from: data)
                completionBlock(decoded.data.results)
            } catch {
                completionBlock([])
            }
        }.resume()
    }

}
