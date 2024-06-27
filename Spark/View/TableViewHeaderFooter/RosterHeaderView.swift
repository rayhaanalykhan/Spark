//
//  RosterHeaderView.swift
//  Spark
//
//  Created by rayhaanalykhan on 27/06/2024.
//

import UIKit

class RosterHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var rosterInfoView: UIView!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var timeLBL: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundView = UIView()
    }
    
    func configureHeader(object: RosterDM?) {
        
        baseView.layer.cornerRadius = 8
        baseView.layer.masksToBounds = false
        baseView.layer.shadowColor = UIColor.black.cgColor // not using exact figma design color for shadow
        baseView.layer.shadowOpacity = 0.75 // not using exact figma design opacity for shadow
        baseView.layer.shadowOffset = CGSize(width: 0, height: 2) // not using exact figma design offset for shadow
        
        rosterInfoView.roundCorners(corners: [.topLeft, .topRight], radius: 8)
        
        nameLBL.text = object?.classRosterName
        timeLBL.text = "\(Utils.shared.convertToAMPMTimeFormat(dateString: object?.classStartTime)) - \(Utils.shared.convertToAMPMTimeFormat(dateString: object?.classEndTime))"
        
        collectionView.register(UINib(nibName: "ContactsCell", bundle: nil), forCellWithReuseIdentifier: "ContactsCell")
        
        collectionViewHeight.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
        
        collectionView.reloadData()
    }
}
