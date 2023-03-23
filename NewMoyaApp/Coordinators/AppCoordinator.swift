//
//  AppCoordinator.swift
//  NewMoyaApp
//
//  Created by User on 04.03.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMainScreen()
    }
    /// Переход на главный экран
    func showMainScreen() {
        let vc = MainViewController()
        let viewModel = MainViewModel()
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: false)
    }
    /// Переход на экран детальной информации
    func showDetailScreen(withPokemonName name: String) {
        let vc = DetailViewController()
        let viewModel = DetailViewModel(pokemonName: name)
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
