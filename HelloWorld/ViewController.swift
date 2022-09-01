//
//  ViewController.swift
//  HelloWorld
//
//  Created by PC220204 on 2022/09/01.
//

import UIKit


class ViewController: UIViewController, DetailViewControllerDelegate {
    
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTouchButton(_ sender: Any) {
        if let text = myTextField.text {
            myLabel.text = text
        }
        performSegue(withIdentifier: "seque1", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seque1" {
            let viewController = segue.destination as! DetailViewController
            viewController.message = myTextField.text
            viewController.delegate = self
        }
    }
    
    func didFinishEditing(message: String?) {
        if let message = message {
            myTextField.text = message
            myLabel.text = message
        }
    }
}

