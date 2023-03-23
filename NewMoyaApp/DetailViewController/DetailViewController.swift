//
//  DetailViewController.swift
//  NewMoyaApp
//
//  Created by User on 10.03.2023.
//

import UIKit
import Bond

// MARK: Структура для хранения констант отображения
extension DetailViewController {
    private struct LayoutConstants {
        static let singleCellAtTableView: Int = 1
    }
}

class DetailViewController: UIViewController {
    // MARK: Публичные свойства
    var coordinator: AppCoordinator?
    var viewModel: DetailViewModel?
    
    // MARK: Приватные свойства
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTableView()
        setupObservers()
        viewModel?.handleViewDidLoad()
    }
    
    /// Настройка таблицы
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
    }
    
    /// Установка обсерверов
    private func setupObservers() {
        _ = viewModel?.data.namedPokemonData.observeNext(with: { [weak self] _ in
                self?.tableView.reloadData()
        })
    }
    
    /// Настройка расположения
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LayoutConstants.singleCellAtTableView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as! DetailTableViewCell
        guard let cellModel = viewModel?.data.namedPokemonData.value else { return UITableViewCell() }
        cell.initialize(with: cellModel)
        return cell
    }
}
