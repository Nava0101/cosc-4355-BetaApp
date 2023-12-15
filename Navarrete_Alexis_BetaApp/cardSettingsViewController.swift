//
//  cardSettingsViewController.swift
//  Navarrete_Alexis_BetaApp
//
//  Created by Alexis Navarrete on 11/2/23.
//

import UIKit

protocol editCardDel {
    func editCard(id: String, info: String)
}

class cardSettingsViewController: UIViewController {

    var delegate: editCardDel?
    var editName: String = ""
    var editInfo: String = ""
    
    
    @IBOutlet weak var cardName: UITextField!
    
    @IBOutlet weak var cardInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardName.text = editName
        cardInfo.text = editInfo
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelEdit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func commitEdit(_ sender: Any) {
        self.delegate?.editCard(id: cardName.text!, info: cardInfo.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
}
