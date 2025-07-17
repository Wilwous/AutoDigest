//
//  UIViewController+Alert.swift
//  AutoDigest
//
//  Created by Антон Павлов on 17.07.2025.
//

import UIKit

// MARK: - Extension

extension UIViewController {
    
    // MARK: - Alert
    
    func showAlert(title: String = "Ошибка", message: String, buttonText: String = "ОК") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonText, style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
