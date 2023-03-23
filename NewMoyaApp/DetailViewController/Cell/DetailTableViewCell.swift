//
//  DetailTableViewCell.swift
//  NewMoyaApp
//
//  Created by User on 18.03.2023.
//

import UIKit


extension DetailTableViewCell {
    // MARK: Структура для хранения констант расположения
    private struct LayoutConstants {
        static let heightAnchorConstaint: CGFloat = 50
    }
}

class DetailTableViewCell: UITableViewCell {
    // MARK: Публичные свойства
    static let identifier = "DetailTableViewCell"
    
    // MARK: Приватные свойства
    private var idLabel = UILabel()
    private var nameLabel = UILabel()
    private var heightLabel = UILabel()
    private var weightLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Публичные методы
    func initialize(with model: SpecificPokemonModel) {
        setupLayout()
        setupAppearace()
        setup(with: model)
    }
    
    // MARK: Приватные методы
    
    /// Настройка ячейки
    /// - Parameter model: модель для  конкретной ячейки
    private func setup(with model: SpecificPokemonModel) {
        idLabel.text = pokemonDescribing(parameter: Constants.id,
                                                   value: String(model.id),
                                                   unit: .emptyString)
        nameLabel.text = pokemonDescribing(parameter: Constants.name,
                                                     value: model.name.capitalized,
                                                     unit: .emptyString)
        heightLabel.text = pokemonDescribing(parameter: Constants.height,
                                                       value: String(model.height),
                                                       unit: Constants.feet)
        weightLabel.text = pokemonDescribing(parameter: Constants.weight,
                                                       value: String(model.weight),
                                                       unit: Constants.pound)
    }
    
    /// Настройка расположения
    private func setupLayout() {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        idLabel.numberOfLines = 1
        nameLabel.numberOfLines = 1
        
        addSubview(idLabel)
        addSubview(nameLabel)
        addSubview(heightLabel)
        addSubview(weightLabel)
        
        NSLayoutConstraint.activate([
            idLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.heightAnchorConstaint),
            idLabel.topAnchor.constraint(equalTo: topAnchor),
            idLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            idLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            nameLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.heightAnchorConstaint),
            nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            heightLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.heightAnchorConstaint),
            heightLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            heightLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            heightLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            weightLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.heightAnchorConstaint),
            weightLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor),
            weightLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            weightLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            weightLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    /// Настройка отображения
    private func setupAppearace() {
        selectionStyle = .none
    }
    
    /// Формирует описание характеристики покемона
    /// - Parameters:
    ///   - parameter: Описываемый параметр
    ///   - value: Значение параметра
    ///   - unit: Единица измерения параметра
    /// - Returns: Сформировнное описание характеристики покемона через интерполяцию строк
    private func pokemonDescribing(parameter: String, value: String, unit: String) -> String {
        "The pokemon \(parameter) is - \(value) \(unit)"
    }
    
}

