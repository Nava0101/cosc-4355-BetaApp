//
//  GameViewController.swift
//  Navarrete_Alexis_BetaApp
//
//  Created by Alexis Navarrete on 11/2/23.
//

import UIKit

class GameViewController: UIViewController {

    var selected_set = StudySets()
    var downloaded_sets = [StudySets]()
    // to set random cards on screen
    var cardOne: Int = 0
    var cardTwo: Int = 1
    var cardThree: Int = 2
    // keep up with accuracy
    var answer: String = ""
    var totalGuesses = 0.0
    var totalCorrect = 0.0
    func getAcc () -> Double {
        return Double((totalCorrect/totalGuesses) * 100)
    }
    @IBOutlet weak var accLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    
    // get random card indexes
    func getRandomCards() {
        let totalCards: Int = selected_set.set_card_ids.count
        cardOne = Int.random(in: 0..<totalCards)
        cardTwo = Int.random(in: 0..<totalCards)
        cardThree = Int.random(in: 0..<totalCards)
    }
    func noMatchCards() {
        getRandomCards()
        if cardTwo == cardOne || cardTwo == cardThree || cardThree == cardOne {
            noMatchCards()
        }
    }
    
    @IBOutlet weak var cardName: UILabel!

    @IBOutlet weak var cardOneInfo: UITextView!
    
    @IBOutlet weak var cardTwoInfo: UITextView!
    
    @IBOutlet weak var cardThreeInfo: UITextView!
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    
    // set up the cards and pick one as the answer
    func setCards () {
        let answerSpot = Int.random(in: 0..<3)
        let totalCards: Int = selected_set.set_card_ids.count
        // make sure we have enough cards for the game
        if totalCards < 3 {
            cardName.text = "needs more cards"
            buttonOne.isEnabled = false
            buttonTwo.isEnabled = false
            buttonThree.isEnabled = false
        } else {
            buttonOne.isEnabled = true
            buttonTwo.isEnabled = true
            buttonThree.isEnabled = true
            // pick the cards
            noMatchCards()
            cardOneInfo.text = selected_set.set_card_info[cardOne]
            cardTwoInfo.text = selected_set.set_card_info[cardTwo]
            cardThreeInfo.text = selected_set.set_card_info[cardThree]
            // store the answer
            if answerSpot == 0 {
                answer = selected_set.set_card_info[cardOne]
                cardName.text = selected_set.set_card_ids[cardOne]
            }
            else if answerSpot == 1 {
                answer = selected_set.set_card_info[cardTwo]
                cardName.text = selected_set.set_card_ids[cardTwo]
            }
            else {
                answer = selected_set.set_card_info[cardThree]
                cardName.text = selected_set.set_card_ids[cardThree]
            }
        }
    }
    
    override func viewDidLoad() {
        setCards()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        setCards()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let card_tab = self.tabBarController?.children[1] as! CardViewController
        card_tab.selected_set = selected_set
        let settings_tab = self.tabBarController?.children[2] as! SettingsViewController
        settings_tab.selected_set = selected_set
        settings_tab.downloaded_sets = downloaded_sets
    }
    
    // if user clicks button onw
    @IBAction func checkOne(_ sender: Any) {
        if answer == cardOneInfo.text {
            totalCorrect += 1
            totalGuesses += 1
            accLabel.text = "ACC: %\(getAcc())"
            totalLabel.text = "Total: \(totalGuesses)"
            setCards()
        } else {
            totalGuesses += 1
            accLabel.text = "ACC: %\(getAcc())"
            totalLabel.text = "Total: \(totalGuesses)"
            cardOneInfo.text = "X - incorrect - X"
        }
    }
    // if user clicks button two
    @IBAction func checkTwo(_ sender: Any) {
        if answer == cardTwoInfo.text {
            totalCorrect += 1
            totalGuesses += 1
            accLabel.text = "ACC: %\(getAcc())"
            totalLabel.text = "Total: \(totalGuesses)"
            setCards()
        } else {
            totalGuesses += 1
            accLabel.text = "ACC: %\(getAcc())"
            totalLabel.text = "Total: \(totalGuesses)"
            cardTwoInfo.text = "X - incorrect - X"
        }
    }
    // if user picks button three
    @IBAction func checkThree(_ sender: Any) {
        if answer == cardThreeInfo.text {
            totalCorrect += 1
            totalGuesses += 1
            accLabel.text = "ACC: %\(getAcc())"
            totalLabel.text = "Total: \(totalGuesses)"
            setCards()
        } else {
            totalGuesses += 1
            accLabel.text = "ACC: %\(getAcc())"
            totalLabel.text = "Total: \(totalGuesses)"
            cardThreeInfo.text = "X - incorrect - X"
        }
    }
    // reset the acc score and total guesses for a fresh start
    @IBAction func resetScore(_ sender: Any) {
        totalCorrect = 0
        totalGuesses = 0
        accLabel.text = "ACC: %0"
        totalLabel.text = "Total: 0"
    }
    // disable landscape mode on this screen

}
