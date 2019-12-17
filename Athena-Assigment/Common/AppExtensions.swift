//
//  AppExtensions.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 16/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import Foundation
import MBProgressHUD

extension FileManager {
    func getDocumentsURL() -> URL? {
        let documentsUrl = try? self.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return documentsUrl
    }
    
    func getDownloadFolderURL() -> URL? {
        let documentsUrl = try? self.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        // your destination file url
        let destination = documentsUrl?.appendingPathComponent(GeneralConstants.folderName)
        return destination
    }
}

extension UIViewController {
    func showLoader(show: Bool) {
        if show {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        } else {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    /// A Common method to present an alert view on the current view controller
    ///
    /// - Parameters:
    ///   - title: A title value of the alert
    ///   - description: It defines the message of the alert
    ///   - type: Type of the alert controller. It could be either normal alert or action sheet
    ///   - sourceRect: In case of pop over, A source frame is required from where the pop over should get popped
    ///   - actions: An array of UIAlertAction instance which is nil by default. You can provide your own custom actions from the source view controller
    ///   - popoverDelegate: `UIPopoverPresentationControllerDelegate` is required only when we want use any of it's delegate methods
    ///   - direction: Pop over direction
    func showAlert(with title: String?,
                   description: String?,
                   type: UIAlertController.Style = .alert,
                   sourceRect: CGRect? = .zero,
                   sourceView: UIView? = UIView(),
                   barButtonItem: UIBarButtonItem? = nil,
                   actions: [UIAlertAction] = [UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)],
                   popoverDelegate: UIPopoverPresentationControllerDelegate? = nil,
                   direction: UIPopoverArrowDirection = .any) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: type)
        
        for action in actions {
            alertController.addAction(action)
        }
        
        if type == .actionSheet {
            alertController.modalPresentationStyle = .popover
            
            if let barButtonItem = barButtonItem {
                alertController.popoverPresentationController?.barButtonItem = barButtonItem
            } else {
                alertController.popoverPresentationController?.sourceView = sourceView
                alertController.popoverPresentationController?.sourceRect = sourceRect ?? .zero
            }
            alertController.popoverPresentationController?.permittedArrowDirections = direction
            alertController.popoverPresentationController?.delegate = popoverDelegate
        }
        present(alertController, animated: true, completion: nil)
    }
}
