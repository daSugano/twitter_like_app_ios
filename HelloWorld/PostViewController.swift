//
//  PostViewController.swift
//  HelloWorld
//
//  Created by PC220204 on 2022/09/01.
//

import Foundation
import UIKit

protocol PostViewControllerDelegate {
    func didFinishEditing(message: String?) -> Void
}

class PostViewController: UIViewController {
    
    
    @IBOutlet weak var postContent: UITextView!
    
    var delegate: PostViewControllerDelegate?
    
    var mediator: TweetMediator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mediator = TweetHandler.shared
    }
    
    
    @IBAction func tweetButtonDidPressed(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.didFinishEditing(message: postContent.text)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
