//
//  deleteCardViewController.swift
//  Navarrete_Alexis_BetaApp
//
//  Created by Alexis Navarrete on 11/2/23.
//

import UIKit
protocol deleteDelegate {
    func deleteCard()
}

class deleteCardViewController: UIViewController {

    var deleteID: String = ""
    var delegate: deleteDelegate?
    
    @IBOutlet weak var confirmationName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelDelete(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        if confirmationName.text == deleteID {
            self.delegate?.deleteCard()
            self.dismiss(animated: true, completion: nil)
        } else {
            confirmationName.text = "must be exactly the same"
        }
    }
    
    
}
