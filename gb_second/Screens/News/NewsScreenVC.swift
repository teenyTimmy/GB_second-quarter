//
//  NewsScreenVC.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 1/18/21.
//

import UIKit

class NewsScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    private let mock = ["A", "B", "C"]

    private let news = [
        [
            "id": "1",
            "authorImage": "",
            "authorName": "The best author",
            "appendTime": "12:30",
            "newsTitle": "Some news title",
            "viewsCount": "123K",
            "likesCount": "3.2K",
            "commentsCount": "60",
            "repostCount": "224"
        ],
        [
            "id": "2",
            "authorImage": "",
            "authorName": "The best fast",
            "appendTime": "13:30",
            "newsTitle": "",
            "viewsCount": "123K",
            "likesCount": "5.2K",
            "commentsCount": "60",
            "repostCount": "224"
        ],
        [
            "id": "3",
            "authorImage": "",
            "authorName": "The best author 3",
            "appendTime": "14:30",
            "newsTitle": "",
            "viewsCount": "33K",
            "likesCount": "2.2K",
            "commentsCount": "43",
            "repostCount": "224"
        ],
        [
            "id": "4",
            "authorImage": "",
            "authorName": "Fast 5",
            "appendTime": "15:30",
            "newsTitle": "Some very very very very very very very very very long news title",
            "viewsCount": "153K",
            "likesCount": "3.2K",
            "commentsCount": "20",
            "repostCount": "124"
        ],
        
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.footerView(forSection: 1) 
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }
    
    func footerView(forSection section: Int) -> UITableViewHeaderFooterView? {
        return UITableViewHeaderFooterView()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NewsCell else { return UITableViewCell() }
        
        let newsView: NewsCellView = NewsCellView()
        let imageView: UIImageView = UIImageView()
        
        imageView.frame = newsView.bodyViewContainer.bounds
        imageView.image = UIImage(named: "Fast 5")
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        newsView.frame = cell.viewCell.bounds
        newsView.authorImage.image = UIImage(named: "Dom")
        newsView.authorName.text = news[indexPath.section]["authorName"]
        newsView.appendTime.text = news[indexPath.section]["appendTime"]
        newsView.newsTitle.text = news[indexPath.section]["newsTitle"]
        newsView.viewsCount.text = news[indexPath.section]["viewsCount"]
        newsView.bodyViewContainer.addSubview(imageView)

        cell.viewCell.addSubview(newsView)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 650
    }
}
