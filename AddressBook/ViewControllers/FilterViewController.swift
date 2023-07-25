//
//  FilterViewController.swift
//  AddressBook
//
//  Created by zehra on 23.07.2023.
//

import UIKit

protocol FilterViewControllerDelegate {
    func didSelectGroup(_ type: Group)
}

extension FilterViewControllerDelegate {
    func didSelectGroup(_ type: Group) {}
}


class FilterViewController: UIViewController {
    
    @IBOutlet weak var filterPickerView: UIPickerView!
    
    private var selectedGroup: Group?
    
    var delegate: FilterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterPickerView.delegate = self
        filterPickerView.dataSource = self
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        delegate?.didSelectGroup(selectedGroup ?? .family)
        dismiss(animated: true)
    }
}

extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Group.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Group.allCases[row].group
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGroup = Group.allCases[row]
    }
}
