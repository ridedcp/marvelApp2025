import Foundation

struct CharacterDataContainer: Decodable {
    var count: Int
    var limit: Int
    var offset: Int
    var characters: [CharacterDataModel]
    
    enum CodingKeys: String, CodingKey {
        case data
        case count, limit, offset, characters = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.count = try data.decode(Int.self, forKey: .count)
        self.limit = try data.decode(Int.self, forKey: .limit)
        self.offset = try data.decode(Int.self, forKey: .offset)
        
        self.characters = try data.decode([CharacterDataModel].self, forKey: .characters)
    }
    
    init(count: Int, limit: Int, offset: Int, characters: [CharacterDataModel]) {
        self.count = count
        self.limit = limit
        self.offset = offset
        self.characters = characters
    }
}
