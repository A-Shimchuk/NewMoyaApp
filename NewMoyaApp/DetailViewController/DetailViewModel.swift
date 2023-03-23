//
//  DetailviewModel?.swift
//  NewMoyaApp
//
//  Created by User on 10.03.2023.
//

import Foundation
import Moya
import Bond

class DetailViewModelData {
    /// Наблюдаемое свойство для модели покемона
    let namedPokemonData = Observable<SpecificPokemonModel?>(nil)
}

protocol DetailViewModelProtocol {
    var data: DetailViewModelData { get set }
}

class DetailViewModel: DetailViewModelProtocol {
    // MARK: Публичные свойства
    /// Ссылка на класс с данными
    var data = DetailViewModelData()
    // MARK: Приватные свойства
    private let networkLayer = NetworkLayer()
    private var pokemonName: String?
    
    required init(pokemonName: String) {
        self.pokemonName = pokemonName
    }
    
    // MARK: Публичные методы
    func handleViewDidLoad() {
        makePokemonRequest()
    }
    
    // MARK: Приватные методы
    /// Запросить покемона по имени
    func makePokemonRequest() {
        guard let name = pokemonName else { return }
        networkLayer.requestSpecificPokemon(name: name) { [weak self] result, error in
            guard let strongSelf = self else { return }
            if let error = error {
                fatalError(error.localizedDescription)
            }
            if let result = result {
                strongSelf.data.namedPokemonData.send(result)
            }
        }
    }
}
