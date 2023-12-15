//
//  AddCardViewController.swift
//  Navarrete_Alexis_BetaApp
//
//  Created by Alexis Navarrete on 11/2/23.
//

import UIKit
protocol settingsDel {
    func addCard(name: String, info: String)
    
}
class AddCardViewController: UIViewController {

    @IBOutlet weak var cardName: UITextField!
    @IBOutlet weak var cardInfo: UITextView!
    var delegate: settingsDel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelAdd(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // commit and add card to set
    @IBAction func addCardToSet(_ sender: Any) {
        if cardName.text == "" {
            
        } else if cardInfo.text == "" {
            
        } else {
            self.delegate?.addCard(name: cardName.text!, info: cardInfo.text!)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
