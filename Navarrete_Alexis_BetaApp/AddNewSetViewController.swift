//
//  AddNewSetViewController.swift
//  Navarrete_Alexis_BetaApp
//
//  Created by Alexis Navarrete on 11/2/23.
//

import UIKit
// call function to add new set of cards in main screen
protocol addNewSet_delegate {
    func addSet(name: String)
}

class AddNewSetViewController: UIViewController {
    
    var delegate: addNewSet_delegate?
    var downnloaded_sets: [StudySets] = []
    @IBOutlet weak var newSetName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // if user decides to not add a new set, return back to home screen
    @IBAction func cancelAdding(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // perfomr delegate and add new set to set list
    @IBAction func addNewSet(_ sender: Any) {
        if newSetName.text != "" {
            self.delegate?.addSet(name: self.newSetName.text!)
            self.dismiss(animated: true, completion: nil)
        }
    }
    

}
