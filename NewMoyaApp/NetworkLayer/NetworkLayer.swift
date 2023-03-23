//
//  NetworkLayer.swift
//  NewMoyaApp
//
//  Created by User on 11.02.2023.
//

import Foundation
import Moya

typealias PokemonsListResponse = ((PokemonsListModel?, Error?) -> Void)
typealias SpecificPokemonResponse = ((SpecificPokemonModel?, Error?) -> Void)

class NetworkLayer {
    /// Провайдер для работы с Moya
    let provider = MoyaProvider<MoyaConfiguration>()
    /// Получение списка покемонов
    func requestPokemonsList(completionHandler: @escaping (PokemonsListResponse)) {
        provider.request(.getListOfPokemons) { result in
            switch result {
            case .success(let response):
                guard let result = self.tryToParseResponce(parsingModel: PokemonsListModel.self,
                                                            responceData: response.data)
                else { return }
                completionHandler(result, nil)
                
            case .failure(let error):
                print(error.errorDescription ?? Constants.somethingWrongWithErrorDescription)
                completionHandler(nil, error)
            }
        }
    }
    /// - Parameters:
    ///   - name: Имя конкретного покемона
    ///   - completionHandler: Модель конкретного покемона
    func requestSpecificPokemon(name: String, completionHandler: @escaping (SpecificPokemonResponse)) {
        provider.request(.getSpecificPokemon(name: name)) { result in
            switch result {
            case .success(let response):
                guard let result = self.tryToParseResponce(parsingModel: SpecificPokemonModel.self,
                                                            responceData: response.data)
                else { return }
                completionHandler(result, nil)
                
            case .failure(let error):
                print(error.errorDescription ?? Constants.somethingWrongWithErrorDescription)
                completionHandler(nil, error)
            }
        }
    }
    ///  Метод для парсинга JSON ответа
    private func tryToParseResponce<T:Codable>(parsingModel: T.Type, responceData: Data) -> T? {
        // TODO: Можно переделать через конструкцию do-catch с нормально обработкой ошибки
        let decoder = JSONDecoder()
        let result = try? decoder.decode(parsingModel.self, from: responceData)
        guard result != nil else {
            print(Constants.parsingError)
            return nil
        }
        return result
    }
}
