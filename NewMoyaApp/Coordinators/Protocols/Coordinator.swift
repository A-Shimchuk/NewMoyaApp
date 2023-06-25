//
//  Coordinator.swift
//  NewMoyaApp
//
//  Created by User on 04.03.2023.
//

import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get }
    
    func start()
}
