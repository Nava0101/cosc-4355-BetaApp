//
//  SettingsViewController.swift
//  Navarrete_Alexis_BetaApp
//
//  Created by Alexis Navarrete on 11/2/23.
//

import UIKit
protocol settingsSendToMain {
    func delete(name:String)
    func updateSet(setToUpdate: String, updatedSet: StudySets)
}

class SettingsViewController: UIViewController, settingsDel, settingEditDel, settingDeleteDel {
    var selected_set = StudySets()
    var downloaded_sets = [StudySets]()
    var delegate: settingsSendToMain? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // update all other tabs on dissapear
    override func viewDidDisappear(_ animated: Bool) {
        let gameTab = self.tabBarController?.children[0] as! GameViewController
        gameTab.selected_set = selected_set
        gameTab.downloaded_sets = downloaded_sets
        let cardTab = self.tabBarController?.children[1] as! CardViewController
        cardTab.selected_set = selected_set
    }
    // set up all segues to transfer data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // go on to add a new set of cards
        if segue.identifier == "ToAddCard" {
            let addCard = segue.destination as! AddCardViewController
            addCard.delegate = self
        }
        if segue.identifier == "ToEditSetName" {
            let editName = segue.destination as! EditNameViewController
            editName.delegate = self
        }
        if segue.identifier == "ToDeleteSet" {
            let deleteSet = segue.destination as! DeleteSetViewController
            deleteSet.delegate = self
            deleteSet.name = selected_set.set_name
        }
    }
    // add card to the set
    func addCard(name: String, info: String) {
        selected_set.set_card_ids.append(name)
        selected_set.set_card_info.append(info)
        self.delegate?.updateSet(setToUpdate: selected_set.set_name, updatedSet: selected_set)
    }
    // edit the same name
    func editSetName(name: String) {
        let oldName = selected_set.set_name
        selected_set.set_name = name
        self.delegate?.updateSet(setToUpdate: oldName, updatedSet: selected_set)
    }
    // delete the entire set
    func deleteSet() {
        self.delegate?.delete(name: selected_set.set_name)
        // return to home screen since this set is going to be deleted
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
