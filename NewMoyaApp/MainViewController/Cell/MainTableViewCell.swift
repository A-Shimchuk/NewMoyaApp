//
//  MainTableViewCell.swift
//  NewMoyaApp
//
//  Created by User on 03.03.2023.
//

import UIKit

extension MainTableViewCell {
    /// Структура для хранения констант расположения
    struct MainTableViewCellLayout {
        /// Высота тайтла
        let titleHeight: CGFloat = 20
        /// Высота стрелки
        let arrowImageHeight: CGFloat = 35
        /// Ширина стрелки
        let arrowImageWidth: CGFloat = 35
    }
}

extension MainTableViewCell {
    /// Структура для хранения констант отображения
    struct MaintableViewCellAppearance {
        let titleFont: UIFont = UIFont.boldSystemFont(ofSize: 20)
    }
}

class MainTableViewCell: UITableViewCell {
    /// Идентификатор ячейки MainTableViewCell
    static var identifier = "MainTableViewCell"
    /// Тайтл для ячейки
    private var name = UILabel()
    /// Иконка
    private var arrowImage = UIImageView()
    /// Layout для ячейки
    private let layout = MainTableViewCellLayout()
    /// Appearance для ячейки
    private let appearance = MaintableViewCellAppearance()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Метод для настройки ячейки из контроллера
    func initialize(with model: Result) {
        setupLayout()
        setupAppearance()
        setupWithModel(model)
    }
    
    /// Настройка ячейки в соответвтии с моделью
    private func setupWithModel(_ model: Result) {
        name.text = model.name.capitalized
    }
    
    /// Настройка расположения
    private func setupLayout() {
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.setContentHuggingPriority(.required, for: .horizontal)
        arrowImage.image = UIImage(named: Constants.rightArrowImageName)

        name.translatesAutoresizingMaskIntoConstraints = false
        name.numberOfLines = 1
        name.textAlignment = .center

        contentView.addSubview(arrowImage)
        contentView.addSubview(name)

        NSLayoutConstraint.activate([
            arrowImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            arrowImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            arrowImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor)
        ])
    }
    
    /// Настройка отображения
    private func setupAppearance() {
        name.font = appearance.titleFont
    }
    
}
