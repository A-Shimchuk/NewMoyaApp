//
//  MainviewModel?.swift
//  NewMoyaApp
//
//  Created by User on 09.02.2023.
//

import Foundation
import Moya
import Bond


class MainViewModelData {
    ///  Наблюдаемая переменная со списком
    var pokemonsList = Observable<PokemonsListModel?>(nil)
}

protocol MainViewModelProtocol {
    var data: MainViewModelData { get set }
}

class MainViewModel: MainViewModelProtocol {
    /// Ссылка на класс с данными
    var data = MainViewModelData()
    /// Работа с NetworkLayer
    private let networkLayer = NetworkLayer()
    /// Обработчик viewDidLoad
    func handleViewDidLoad() {
        requestPokemonsList()
    }
    /// Запрос списка покемонов через сетевой слой
    private func requestPokemonsList() {
        networkLayer.requestPokemonsList { [weak self] result, error in
            guard let strongSelf = self else { return }
            if let error = error {
                fatalError(error.localizedDescription)
            }
            if let result = result {
                strongSelf.data.pokemonsList.send(result)
            }
        }
    }
}
