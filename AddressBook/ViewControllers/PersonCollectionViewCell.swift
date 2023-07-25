//
//  PersonCollectionViewCell.swift
//  AddressBook
//
//  Created by zehra on 25.07.2023.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    
    func setPersonName(name: String) {
        personName.text = name
    }
    
    func setPersonImage(gender: String) {
        personImage.image = UIImage(named: gender)
    }
}
