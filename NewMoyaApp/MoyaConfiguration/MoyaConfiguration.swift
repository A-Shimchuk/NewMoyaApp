//
//  MoyaConfiguration.swift
//  NewMoyaApp
//
//  Created by User on 11.02.2023.
//

import Foundation
import Moya

enum MoyaConfiguration {
    /// Получение списка покемонов
    case getListOfPokemons
    /// Получение конкретного покемона по имени
    case getSpecificPokemon(name: String)
}

extension MoyaConfiguration: TargetType {
    /// Базовая ссылка для запросов
    var baseURL: URL { URL(string: "https://pokeapi.co/api/v2")! }
    /// Эндпоинты для запросов
    var path: String {
        switch self {
        case .getListOfPokemons:
            return "/pokemon"
        case .getSpecificPokemon(name: let name):
            return "/pokemon/\(name)"
        }
    }
    /// Методы для запросов
    var method: Moya.Method {
        switch self {
        case .getListOfPokemons, .getSpecificPokemon:
            return .get
        }
    }
    /// Задачи для запросов
    var task: Task {
        switch self {
        case .getListOfPokemons, .getSpecificPokemon:
            return .requestPlain
        }
    }
    /// Хедеры для запросов
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
