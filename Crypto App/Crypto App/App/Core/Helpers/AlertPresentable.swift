//
//  AlertManager.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 29.01.2023.
//

import UIKit

protocol AlertPresentable { }

extension AlertPresentable where Self: UIViewController { // It's like accessing ViewController from outer scope.
    // When the desired view controller conforms AlertManager, this extension gains access to VC to present alerts.
    func showAlert(title: String? = nil, message: String? = nil) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)

        self.present(alertController, animated: true)

        let okButton = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okButton)
    }

    func showError(_ error: Error) {
        showAlert(title: "An Error Occured", message: error.localizedDescription)
    }

}
