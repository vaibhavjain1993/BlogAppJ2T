//
//  ArticelsViewModel.swift
//  BlogAppJ2T
//
//  Created by vaibhav Jain on 11/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

protocol ArticleViewModelDelegate: class {
    func reloadTableWithData(article: [ParentTree])
    func showError(message: String)
}

class ArticelsViewModel {

    weak var delegate: ArticleViewModelDelegate?

    func getArticlesFromApi(page: Int, limit: Int = 10, isFirstRequest : Bool,offset : Int){
        CommunityServiceManager.getArticles(param: ["page": page, "limit": limit], isFirstRequest: isFirstRequest) { (articles, error) in
            if let _ = articles{
                let articels = CoreDataManager.getRecords(offset: offset)
                if let blogs = articels{
                    self.delegate?.reloadTableWithData(article: blogs)
                }
            }else{
                self.delegate?.showError(message: error?.localizedDescription ?? "")
                let articels = CoreDataManager.getRecords(offset: offset)
                if let blogs = articels{
                    self.delegate?.reloadTableWithData(article: blogs)
                }
            }
        }
    }

    func getHeightForTableCell(blog : ParentTree) -> CGFloat{
        let height = blog.content?.calculateLabelHeight(font: UIFont.systemFont(ofSize: 12), maxSize: CGSize.init(width: UIScreen.main.bounds.size.width - 30, height: 200))
        if blog.mediaDetail?.count ?? 0 > 0{
            return 287 + (height?.height ?? 0)
        }else{
            return 137 + (height?.height ?? 0)
        }
    }
}
