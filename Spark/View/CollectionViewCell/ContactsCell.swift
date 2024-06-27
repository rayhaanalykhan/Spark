//
//  ContactsCell.swift
//  Spark
//
//  Created by rayhaanalykhan on 27/06/2024.
//

import UIKit

class ContactsCell: UICollectionViewCell {
    
    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var nameLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(object: RegisteredContactDM?) {
        
        nameLBL.text = object?.name ?? "Some name"
        imageIV.loadImage(with: object?.image)
    }
}
