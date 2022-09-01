import Foundation
import UIKit


class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PostViewControllerDelegate, TweetHandlerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet] = []
    
    var tweetHandler = TweetHandler.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tweetHandler.delegate = self
        
        tweetHandler.get()
        
        tableView.reloadData()
        
        configureRefreshControl()
    }
    
    func configureRefreshControl () {
       tableView.refreshControl = UIRefreshControl()
       tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }

    @objc func handleRefreshControl() {
        TweetHandler.shared.get()

        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StandardCell", for: indexPath) as! MyTableViewCell
        
         let tweet = tweets[indexPath.row]
         cell.myCell.text = "\(tweet.content ?? "")"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    @IBAction func postButtonDidPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ToPostView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPostView" {
            let viewController = segue.destination as! PostViewController
            viewController.delegate = self
        }
    }
    
    func didFinishEditing(message: String?) {
        if let message = message {
            TweetHandler.shared.post(content: message)
        }
    }
    
    func didFetchData(_ tweetHandler: TweetHandler, posts: [Dictionary<String, Any>]) {
        DispatchQueue.main.async {
            var formattedPosts: [Tweet] = []
            for post in posts {
                let content: String = post["content"] as! String
                print(content)
                let t = Tweet()
                t.content = content
                formattedPosts.append(t)
            }
            self.tweets = formattedPosts
            self.tableView.reloadData()
        }
    }
}


class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var myCell: UILabel!
}
