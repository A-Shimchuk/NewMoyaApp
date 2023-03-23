//
//  MainViewController.swift
//  NewMoyaApp
//
//  Created by User on 09.02.2023.
//

import UIKit
import Bond

class MainViewController: UIViewController {
    // MARK: Публичные свойства
    var coordinator: AppCoordinator?
    var viewModel: MainViewModel?
    
    // MARK: Приватные свойства
    private var tableView = UITableView()
    private var screen = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupObservers()
        setupTableView()
        viewModel?.handleViewDidLoad()
    }
    
    // MARK: Приватные методы
    /// Настройка расположения
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
    }
    
    /// Настройка таблицы
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    
    /// Установка обсерверов
    private func setupObservers() {
        _ = viewModel?.data.pokemonsList.observeNext(with: { result in
            self.tableView.reloadData()
        }).dispose(in: self.reactive.bag)
    }
}

// MARK: UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as! MainTableViewCell
        if let cellModel = viewModel?.data.pokemonsList.value?.results[indexPath.row] {
            cell.initialize(with: cellModel)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataResults = viewModel?.data.pokemonsList.value?.results else { return .zero }
        return dataResults.count
    }
}
// MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let dataResults = viewModel?.data.pokemonsList.value?.results {
            let name = dataResults[indexPath.row].name.uppercased()
            coordinator?.showDetailScreen(withPokemonName: name)
        }
   
    }
}
