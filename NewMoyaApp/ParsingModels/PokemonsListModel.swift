//
//  PokemonsListModel.swift
//  NewMoyaApp
//
//  Created by User on 11.02.2023.
//

import Foundation

// MARK: - PokemonsListModel
struct PokemonsListModel: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let name: String
    let url: String
}

