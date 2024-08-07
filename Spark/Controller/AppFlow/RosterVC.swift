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
    
    let viewModel = RosterVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        initVariable()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        tableView.reloadData()
    }

    // MARK: UI Stuff
    func initUI() {
        
        instructorSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        searchTF.attributedPlaceholder = NSAttributedString(string: "Enter name, ID", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]) // show placeholder in dark mode also
        
        tableView.backgroundColor = .clear
        
        // tableView nib registration
        self.tableView.register(UINib(nibName: "RosterHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "RosterHeaderView")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        
        setupPullToRefresh(scrollableView: tableView)
        
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: Data Stuff/API calls
    func initVariable() {
        requestRosterWithContactList()
    }
    
    func requestRosterWithContactList() {
        
        showActivityIndicator()
        
        viewModel.requestRosterWithContactList { isSuccess in
            
            self.hideActivityIndicator()
            
            guard isSuccess else {
                
                // Show error
                self.showMessage(title: "Error", message: self.viewModel.rosterWithContactList?.message ?? "Some error occurred")
                
                return
            }
            
            self.tableView.reloadData()
        }
    }
    
    @IBAction func dropDownBTNTapped(_ sender: UIButton) {
        print("Drop down button tapped")
        // show drop down
    }
    
    @IBAction func settingsBTNTapped(_ sender: UIButton) {
        print("Settings button tapped")
        // open and modal to show settings
    }
    
    @objc func switchValueChanged(_ sender: AppTextSwitch) {
        
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
    
    override func pullToRefreshActionPerformed(_ sender: UIRefreshControl) {
        
        super.pullToRefreshActionPerformed(sender)
        
        requestRosterWithContactList()
    }
}

extension RosterVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.rosterWithContactList?.result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RosterHeaderView") as? RosterHeaderView else {
            return UIView()
        }
        
        headerView.collectionView.tag = section
        
        headerView.collectionView.dataSource = self
        headerView.collectionView.delegate = self
        
        headerView.configureHeader(object: viewModel.rosterWithContactList?.result?[section])
        
        headerView.collectionView.reloadData()
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // not using
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // not using 
        return UITableViewCell()
    }
}

// MARK: - CollectionView configuration
extension RosterVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.rosterWithContactList?.result?[collectionView.tag].registeredContacts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactsCell", for: indexPath) as? ContactsCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(object: viewModel.rosterWithContactList?.result?[collectionView.tag].registeredContacts?[indexPath.row])
        
        return cell
    }
}

// MARK: - CollectionView layout configuration
extension RosterVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat = 130
        
        if UIDevice.currentDeviceIdiom == .pad {
            return CGSize(width: collectionView.frame.width / 6, height: height) // show 6 cells in a row
        }
        
        if UIDevice.currentDeviceIdiom == .phone {
            return CGSize(width: collectionView.frame.width / 2, height: height) // show 2 cells in a row
        }
        
        // Other supported devices (Apple Vision e.t.c)
        return CGSize(width: collectionView.frame.width / 8, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { // row in-between gap
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { // column in-between gap
        return 0
    }
}
