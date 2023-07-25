//
//  ViewController.swift
//  AddressBook
//
//  Created by zehra on 23.07.2023.
//

import UIKit

struct PeopleModel: Equatable {
    var name:String
    var gender: Gender
    var group: Group
}

enum Gender: String {
    case female
    case male
}

enum Group:CaseIterable {
    case family
    case closeFriend
    case colleague
    case Neigbor
    
    var group: String {
        switch self{
        case .family:
            return "Family"
        case .closeFriend:
            return "Close Friends"
        case .colleague:
            return "Colleagues"
        case .Neigbor:
            return "Neigbors"
            
        }
    }
}

struct People {
    static let people: [PeopleModel] = [
        PeopleModel(name: "Sevil", gender: .female, group: .family),
        PeopleModel(name: "Ahmet", gender: .male, group: .family),
        PeopleModel(name: "Kevser", gender: .female, group: .family),
        PeopleModel(name: "Varol", gender: .male, group: .family),
        PeopleModel(name: "Gökhan", gender: .male, group: .closeFriend),
        PeopleModel(name: "Ali", gender: .male, group: .closeFriend),
        PeopleModel(name: "Yeşim", gender: .female, group: .closeFriend),
        PeopleModel(name: "Eliz", gender: .female, group: .closeFriend),
        PeopleModel(name: "İlayda", gender: .female, group: .colleague),
        PeopleModel(name: "Kurtuluş", gender: .male, group: .colleague),
        PeopleModel(name: "Hüseyin", gender: .male, group: .colleague),
        PeopleModel(name: "Mustafa", gender: .male, group: .colleague),
        PeopleModel(name: "Ayşenur", gender: .female, group: .colleague),
        PeopleModel(name: "Erhan", gender: .male, group: .colleague),
        PeopleModel(name: "Furkan", gender: .male, group: .Neigbor),
        PeopleModel(name: "Hürol", gender: .male, group: .Neigbor),
        PeopleModel(name: "Beste", gender: .female, group: .Neigbor),
        PeopleModel(name: "Ekin", gender: .female, group: .Neigbor),
        PeopleModel(name: "Serhat", gender: .male, group: .Neigbor),
        PeopleModel(name: "Anıl", gender: .male, group: .Neigbor)
    ]
    
}

class ViewController: UIViewController {

    
    @IBOutlet weak var peopleTableView: UITableView!
    var selectedPerson: PeopleModel?
    var clickedGroup: [PeopleModel]?
    
    private var selectedGroup: Group? {
        didSet {
            peopleTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
        
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle.fill"), style: .done, target: self, action: #selector(filterButtonAct))
        navigationItem.rightBarButtonItem = filterButton
    }
    
    @objc private func filterButtonAct() {
        let storyboard = UIStoryboard(name: "FilterViewController", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(identifier: "FilterViewController") as? FilterViewController {
            vc.delegate = self
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
    }
    
}

extension ViewController: FilterViewControllerDelegate {
    func didSelectGroup(_ type: Group) {
        selectedGroup = type
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return setSections().count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return setSections()[section].group
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterPeople(section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleTableViewCell") as! PeopleTableViewCell
        cell.personImageView.image = UIImage(named: filterPeople(indexPath.section)[indexPath.row].gender.rawValue)
        cell.nameLabel.text = filterPeople(indexPath.section)[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionPeople = filterPeople(indexPath.section)
        clickedGroup = sectionPeople
        selectedPerson = sectionPeople[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    private func setSections() -> [Group] {
        
        if let selectedGroup {
            return [selectedGroup]
        } else {
            return Group.allCases
        }
    }
    
    private func filterPeople(_ sectionIndex: Int) -> [PeopleModel] {
        if selectedGroup == nil {
        return People.people.filter({ $0.group == Group.allCases[sectionIndex] })

        }else{
            return People.people.filter({ $0.group == selectedGroup })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? AddressBookDetails else { return }
        viewController.personInfo = selectedPerson
        guard let selectedPerson = selectedPerson, var clickedGroupLast = clickedGroup else { return }
        clickedGroupLast.removeAll { $0 == selectedPerson }
        viewController.groupofPerson = clickedGroupLast
    }
}

//
//
//Kod satırında, People.people adlı bir dizide bulunan nesneleri filtrelemek için bir closure kullanılmıştır. filter fonksiyonu, bir dizi üzerinde filtreleme işlemi gerçekleştirir ve belirli bir koşulu sağlayan elemanları yeni bir dizi içinde döndürür.
//
//Closure, dizideki her bir elemanı temsil etmek için $0 ifadesini kullanır. Bu durumda, $0.group ifadesi, her bir elemanın group özelliğine erişmek için kullanılır. Group.allCases[sectionIndex] ifadesi, Group adlı bir enumun tüm durumlarından (cases) birini temsil eder ve sectionIndex değişkeni ile belirtilen bölümdeki elemanları filtrelemek için kullanılır.
//
//Örneğin, People adlı bir struct içinde people adlı bir dizimiz ve her elemanın group adlı bir özelliği olduğunu varsayalım. Bu closure, people dizisini belirli bir bölümdeki (section) kişileri içeren yeni bir diziyle filtreleyecektir.
//
