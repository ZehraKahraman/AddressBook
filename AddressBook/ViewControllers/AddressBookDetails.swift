//
//  AddressBookDetails.swift
//  AddressBook
//
//  Created by zehra on 23.07.2023.
//

import UIKit

class AddressBookDetails: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var genderImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var personInfo: PeopleModel?
    var groupofPerson: [PeopleModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNameLabel()
        setGroupLabel()
        setGenderImage()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setNameLabel() {
        nameLabel.text = personInfo?.name
    }
    
    private func setGroupLabel() {
        groupLabel.text = personInfo?.group.group
    }
    
    private func setGenderImage() {
        guard let personInfo else { return }
        genderImage.image = UIImage(named: personInfo.gender.rawValue)
    }

}

extension AddressBookDetails: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupofPerson!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCollectionViewCell", for: indexPath) as! PersonCollectionViewCell
        let person = groupofPerson![indexPath.row]
        cell.setPersonName(name: person.name)
        cell.setPersonImage(gender: person.gender.rawValue)
        return cell
    }
}
