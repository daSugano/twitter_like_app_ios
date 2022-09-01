//
//  ViewController.swift
//  HelloWorld
//
//  Created by PC220204 on 2022/09/01.
//
import Foundation
import UIKit

protocol DetailViewControllerDelegate {
    func didFinishEditing(message: String?) -> Void
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var largeTextField: UITextField!
    
    var message: String?
    
    var delegate: DetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        largeTextField.text = message
    }
    
    
    @IBAction func didSubmit(_ sender: Any) {
        if let delegate = delegate {
            delegate.didFinishEditing(message: largeTextField.text)
        }
        // dismiss(animated: true)
        self.navigationController?.dismiss(animated: true)
    }
    
}


