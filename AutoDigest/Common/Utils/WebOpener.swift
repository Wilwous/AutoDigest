//
//  WebOpener.swift
//  AutoDigest
//
//  Created by Антон Павлов on 18.07.2025.
//

import UIKit
import SafariServices

// MARK: - WebOpener

final class WebOpener {
    
    static func openWebLink(from viewController: UIViewController, urlString: String) {
        guard let url = URL(string: urlString) else {
            viewController.showAlert(
                title: "Ошибка",
                message: "Невалидная ссылка"
            )
            return
        }

        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .formSheet
        viewController.present(safariVC, animated: true)
    }
}
