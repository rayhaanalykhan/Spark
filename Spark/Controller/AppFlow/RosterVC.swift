//
//  ClassRosterVC.swift
//  Spark
//
//  Created by rayhaanalykhan on 25/06/2024.
//

import UIKit

class RosterVC: BaseVC {
    
    @IBOutlet weak var instructorBGView: UIView!
    @IBOutlet weak var instructorLBL: UILabel!
    @IBOutlet weak var instructorSwitch: AppTextSwitch!
    @IBOutlet weak var searchBGView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    func initUI() {
        
        instructorSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        searchTF.attributedPlaceholder = NSAttributedString(string: "Enter name, ID", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]) // show placeholder in dark mode also
        
        tableView.backgroundColor = .clear
        
        // tableView nib registration
        self.tableView.register(UINib(nibName: "RosterHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "RosterHeaderView")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func switchValueChanged(_ sender: AppTextSwitch) {
        
        print("Switch value changed to: \(sender.getIsOn())")
        
        if sender.getIsOn() {
            
            instructorBGView.backgroundColor =  UIColor(color: .instructorBGEnabled)
            searchBGView.borderColor = .white
            instructorLBL.textColor = UIColor(red: 0.345, green: 0.341, blue: 0.341, alpha: 1.0)
            
        } else {
            
            instructorBGView.backgroundColor =  UIColor(color: .instructorBGDisabled)
            searchBGView.borderColor = UIColor(color: .textFieldborder)
            instructorLBL.textColor = UIColor(color: .text)
        }
    }
}

extension RosterVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RosterHeaderView") as? RosterHeaderView else {
            return UIView()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}



