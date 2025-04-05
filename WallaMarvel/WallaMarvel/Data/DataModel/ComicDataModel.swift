//
//  ComicDataModel.swift
//  WallaMarvel
//
//  Created by Daniel Cano on 2/4/25.
//

import Foundation

struct Comic: Decodable, Equatable {
    let id: Int
    let title: String
}
