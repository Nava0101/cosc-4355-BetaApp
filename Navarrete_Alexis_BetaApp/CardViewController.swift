//
//  CardViewController.swift
//  Navarrete_Alexis_BetaApp
//
//  Created by Alexis Navarrete on 11/2/23.
//

import UIKit

protocol sendInfoToMain{
    func updateSet(setToUpdate: String, updatedSet: StudySets)
}

class CardViewController: UIViewController, editCardDel, deleteDelegate {
    
    var selected_set = StudySets()
    var showInfo = false
    var currentCard = 0
    
    var delegate: sendInfoToMain?
    
    @IBOutlet weak var noteCard: UITextView!
    
    @IBOutlet weak var flipButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var cardSettings: UIButton!
    @IBOutlet weak var cardDelete: UIButton!
    
    @IBOutlet weak var tittle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tittle.text = selected_set.set_name
        showcard()
    }
    // on disappear update anything that needs to be updated
    override func viewDidDisappear(_ animated: Bool) {
        let game_tab = self.tabBarController?.children[0] as! GameViewController
        game_tab.selected_set = selected_set
        let settings_tab = self.tabBarController?.children[2] as! SettingsViewController
        settings_tab.selected_set = selected_set
    }
    // go forward a card
    @IBAction func nextCard(_ sender: Any) {
        if currentCard + 1 < selected_set.set_card_ids.count {
            currentCard += 1
            whatToShow()
        } else {
            currentCard = 0
            whatToShow()
        }
    }
    // go back a card
    @IBAction func prevCard(_ sender: Any) {
        if currentCard - 1 != -1 {
            currentCard -= 1
            whatToShow()
        } else {
            currentCard = selected_set.set_card_ids.count - 1
            whatToShow()
        }
    }
    // flip the card and show the other side
    @IBAction func showInfo(_ sender: Any) {
        if !showInfo {
            showInfo = true
            noteCard.text = selected_set.set_card_info[currentCard]
        } else {
            showInfo = false
            noteCard.text = selected_set.set_card_ids[currentCard]
        }
        
    }
    // enable or disable the buttons as needed
    func enableButtons(x: Bool) {
        flipButton.isEnabled = x
        nextButton.isEnabled = x
        prevButton.isEnabled = x
        cardSettings.isEnabled = x
        cardDelete.isEnabled = x
    }
    // check if current set has any cards that can be studied
    func showcard() {
        if selected_set.set_card_ids.count > 0 {
            whatToShow()
            enableButtons(x: true)
        } else {
            noteCard.text = "Your set contains no cards, go to settings and add some cards"
            enableButtons(x: false)
        }
    }
    // show the card
    func whatToShow() {
        if showInfo {
            noteCard.text = selected_set.set_card_info[currentCard]
        } else {
            noteCard.text = selected_set.set_card_ids[currentCard]
        }
    }
    // send info to edit card information view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // go on to add a new set of cards
        if segue.identifier == "ToEditCard" {
            let editCard = segue.destination as! cardSettingsViewController
            editCard.delegate = self
            editCard.editName = selected_set.set_card_ids[currentCard]
            editCard.editInfo = selected_set.set_card_info[currentCard]
        }
        if segue.identifier == "ToDeleteCard" {
            let deleteCard = segue.destination as! deleteCardViewController
            deleteCard.delegate = self
            deleteCard.deleteID = selected_set.set_card_ids[currentCard]
        }
    }
    // finish and commit the edit on the card
    func editCard(id: String, info: String) {
        selected_set.set_card_ids[currentCard] = id
        selected_set.set_card_info[currentCard] = info
        showcard()
        // return changes to main screen
        self.delegate?.updateSet(setToUpdate: selected_set.set_name, updatedSet: selected_set)
    }
    // finish and commit the deletion
    func deleteCard() {
        selected_set.set_card_ids.remove(at: currentCard)
        selected_set.set_card_info.remove(at: currentCard)
        // make sure we did not just delete the last card
        if selected_set.set_card_ids.count != 0 {
            nextCard(self)
        }
        // if there is no more cards left to delete, let the user know
        else{
            noteCard.text = "Your set contains no cards, go to settings and add some cards"
            enableButtons(x: false)
        }
        // return changes to main screen
        self.delegate?.updateSet(setToUpdate: selected_set.set_name, updatedSet: selected_set)

    }
    
}
