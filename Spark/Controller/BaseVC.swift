//
//  BaseVC.swift
//  Spark
//
//  Created by rayhaanalykhan on 26/06/2024.
//

import UIKit

class BaseVC: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showActivityIndicator() {
        
        view.isUserInteractionEnabled = false
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.color = .accent
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
    
        activityIndicator.startAnimating()
        
        self.activityIndicator = activityIndicator
    }
    
    func hideActivityIndicator() {
        
        view.isUserInteractionEnabled = true
        
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
    }
    
    func showMessage(title: String, message: String) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Setup pull to refresh
    func setupPullToRefresh(scrollableView: UIScrollView) { // pass UITableView, UICollectionView, UIScrollView
        
        scrollableView.refreshControl = UIRefreshControl()
        
        scrollableView.refreshControl?.tintColor = UIColor(color: .text)
        
        scrollableView.refreshControl?.backgroundColor = UIColor(color: .contactListBG)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(color: .text) ?? UIColor.systemRed,
        ]
        
        scrollableView.refreshControl?.attributedTitle = NSAttributedString(string: "Reload rostera with their contact list", attributes: attributes)
        scrollableView.refreshControl?.addTarget(self, action: #selector(pullToRefreshActionPerformed), for: .valueChanged)
    }
    
    // Pull to refresh method (to be called in view controllers)
    @objc func pullToRefreshActionPerformed(_ sender: UIRefreshControl) {
        
        if let scrollableView = sender.superview as? UIScrollView {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                scrollableView.panGestureRecognizer.isEnabled = false
                sender.endRefreshing()
                scrollableView.panGestureRecognizer.isEnabled = true
            }
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
