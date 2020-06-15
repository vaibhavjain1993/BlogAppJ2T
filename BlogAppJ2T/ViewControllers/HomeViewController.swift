//
//  ViewController.swift
//  BlogAppJ2T
//
//  Created by Vaibhav Jain on 11/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableViewBlogList: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var loaderForLoadMore: UIActivityIndicatorView!

    var articalData : [ParentTree]?
    var loadingData : Bool = false
    var page : Int = 1
    var isGetAllDataFromApi = false
    var offsetCount = 0
    var viewModel = ArticelsViewModel()
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        self.loadingView(isShow: true)
        viewModel.getArticlesFromApi(page: page, isFirstRequest: true, offset: offsetCount)
        ArticleTableViewCell.register(for: tableViewBlogList)
        
    }
}

extension HomeViewController{
    private func loadingView(isShow : Bool){
        self.loadingView.isHidden = !isShow
        self.view.isUserInteractionEnabled = !isShow
        if isShow{
            self.loadingView.startAnimating()
        }else{
            self.loadingView.stopAnimating()
        }
    }

    func showAlertView(title : String, message: String){
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "Ok", style: .default) { (alert) in

        }
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: false) {

        }
    }
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //287 hright of table cell with
        if let blog = self.articalData?[indexPath.row]{
           return viewModel.getHeightForTableCell(blog: blog)
        }
        return 300
    }
}

extension HomeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articalData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell",
                                                       for: indexPath) as? ArticleTableViewCell
            else{
                return UITableViewCell()
        }
        if let blog = self.articalData?[indexPath.row]{
            cell.setupData(blog: blog)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = (self.articalData?.count ?? 0) - 1
        if !isGetAllDataFromApi{
            if !loadingData && indexPath.row == lastElement {
                loaderForLoadMore.startAnimating()
                loaderForLoadMore.isHidden = false
                loadingData = true
                self.page += 1
                self.offsetCount += 10
                viewModel.getArticlesFromApi(page: self.page, isFirstRequest: false, offset: self.offsetCount)
            }
        }
    }


}

extension HomeViewController: ArticleViewModelDelegate{
    func showError(message: String) {
        self.loadingView(isShow: false)
        self.showAlertView(title: "Error", message: message)
    }

    func reloadTableWithData(article: [ParentTree]) {
        article.count < 10 ? (self.isGetAllDataFromApi = true) : (self.isGetAllDataFromApi = false)
        self.loadingView(isShow: false)
        self.loadingData = false
        loaderForLoadMore.stopAnimating()
        loaderForLoadMore.isHidden = true
        if articalData == nil{
            self.articalData = article
        }else{
            self.articalData?.append(contentsOf: article)
        }
        self.tableViewBlogList.reloadData()
    }
}
