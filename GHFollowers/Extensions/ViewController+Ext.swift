//
//  ViewController+Ext.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 07..
//

import UIKit
import SafariServices

extension UIViewController {
    
    enum URLString {
        static var urlString: String? = ""
    }
    
    func openUserWebsite() {
        if let urlString = URLString.urlString {
            let url: URL?
            if urlString.hasPrefix("http://") || urlString.hasPrefix("https://")  {
                url = URL(string: urlString)
            } else {
                url = URL(string: "https://" + urlString)
            }
            if let url = url {
                let sfViewController = SFSafariViewController(url: url)
                self.present(sfViewController, animated: true, completion: nil)
                print ("User's website is opened in SFSafariViewController")
            }
        }
    }
    
    func isInTheFavorites(name: String) -> Bool {
        if DatabaseManager.main.getUsers().first(where: { $0.login == name.lowercased() }) != nil {
            return true
        } else {
            return false
        }
    }
    
    func changeFavoriteButton(isFavorite: Bool) {
        if isFavorite {
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
        } else {
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
