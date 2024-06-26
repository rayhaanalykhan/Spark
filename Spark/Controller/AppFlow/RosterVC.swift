//
//  ClassRosterVC.swift
//  Spark
//
//  Created by rayhaanalykhan on 25/06/2024.
//

import UIKit

class RosterVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    func initUI() {

        // tableView nib registration
        self.tableView.register(UINib(nibName: "", bundle: nil), forHeaderFooterViewReuseIdentifier: "")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension RosterVC: UITableViewDataSource, UITableViewDelegate {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchHeaderView") as? SearchHeaderView else {
//            return UIView()
//        }
//    
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}



