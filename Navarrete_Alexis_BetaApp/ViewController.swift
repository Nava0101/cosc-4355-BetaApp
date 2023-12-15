//
//  ViewController.swift
//  Navarrete_Alexis_BetaApp
//
//  Created by Alexis Navarrete on 10/31/23.
//

import UIKit
// structure for sets that contain cards with an id and info
struct StudySets : Codable {
    init(){
        set_name = ""
        set_card_ids = []
        set_card_info = []
    }
    var set_name:String
    var set_card_ids : [String]
    var set_card_info : [String]
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, addNewSet_delegate, sendInfoToMain, settingsSendToMain {
    // var that will be sent to other screens
    var selected_set = StudySets()
    var downloaded_sets: [StudySets] = []
    var filteredDownloadedSets: [StudySets] = []
    // make preset for app
    func add_trial_sets () {
        var trial_set = StudySets()
        trial_set.set_name = "Math"
        trial_set.set_card_ids = ["2+1", "3-2", "0*8", "90/30"]
        trial_set.set_card_info = ["3", "1", "0", "3"]
        downloaded_sets.append(trial_set)
        var trial_set_2 = StudySets()
        trial_set_2.set_name = "Biology"
        trial_set_2.set_card_ids = ["Heart", "Brain", "Ears", "Nose"]
        trial_set_2.set_card_info = ["Pumps blood through our body", "Allows the human to think", "Allows the human to hear noices", "Allows the Human to smell things"]
        downloaded_sets.append(trial_set_2)
        var trial_set_3 = StudySets()
        trial_set_3.set_name = "empty set"
        trial_set_3.set_card_ids = []
        trial_set_3.set_card_info = []
        downloaded_sets.append(trial_set_3)
        var trial_set_4 = StudySets()
        trial_set_4.set_name = "single card"
        trial_set_4.set_card_ids = ["card one"]
        trial_set_4.set_card_info = ["I am the only card in this set"]
        downloaded_sets.append(trial_set_4)
    }
    
    @IBOutlet weak var searchName: UITextField!
    var isSearchActive: Bool = false
    
    // table view in main home screen
    @IBOutlet weak var SetTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add_trial_sets()
        SetTable.dataSource = self
        SetTable.delegate = self
        SetTable.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SetTable.reloadData()
        searchName.text = "Search..."
    }
    // search bar function
    @IBAction func searchEditChange(_ sender: Any) {
        let target = searchName.text
        filteredDownloadedSets = downloaded_sets.filter{$0.set_name.lowercased() == target?.lowercased()}
        if(filteredDownloadedSets.count == 0) {
            isSearchActive = false
        } else {
            isSearchActive = true
        }
        self.SetTable.reloadData()
    }
    
    // table functions start  ------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchActive {
            return filteredDownloadedSets.count
        } else {
            return downloaded_sets.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "protoCell", for: indexPath)
        
        let setLbl = cell.viewWithTag(2) as! UILabel
        
        if isSearchActive {
            setLbl.text = filteredDownloadedSets[indexPath.row].set_name
        } else {
            setLbl.text = downloaded_sets[indexPath.row].set_name
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    // table functions end --------------------------------
    
    //segue to go to tabs for the designated card set
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // go to the tabs
        if segue.identifier == "GoToSet" {
            let tabctrl = segue.destination as! UITabBarController
            let dest = tabctrl.viewControllers![0] as! GameViewController
            dest.selected_set = selected_set
            dest.downloaded_sets = downloaded_sets
            let cardTab = tabctrl.viewControllers![1] as! CardViewController
            cardTab.delegate = self
            let settingTab = tabctrl.viewControllers![2] as! SettingsViewController
            settingTab.delegate = self
        }
        // go on to add a new set of cards
        if segue.identifier == "GoToAdd" {
            let add_new_set = segue.destination as! AddNewSetViewController
            add_new_set.delegate = self
            add_new_set.downnloaded_sets = downloaded_sets
        }
    }
    // on click perfrom segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected_set = downloaded_sets[indexPath.row]
        performSegue(withIdentifier: "GoToSet", sender: self)
        
    }

    
    // add new set with given name
    func addSet (name:String) {
        var temp = StudySets()
        temp.set_name = name
        downloaded_sets.append(temp)
        SetTable.reloadData()
    }
    // delete set from list
    func delete (name:String) {
        downloaded_sets = downloaded_sets.filter{$0.set_name.lowercased() != name.lowercased()}
    }
    // update info made from any card changes
    func updateSet(setToUpdate: String, updatedSet: StudySets) {
        let index: Int = downloaded_sets.firstIndex(where: {$0.set_name == setToUpdate})!
        downloaded_sets[index] = updatedSet
    }
}

