//
//  ArticleTableViewself.swift
//  BlogAppJ2T
//
//  Created by Vaibhav jain on 11/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewUserProfile: UIImageView!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var imageViewArtice: UIImageView!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelArticelDescription: UILabel!
    @IBOutlet weak var labelLikesCount: UILabel!
    @IBOutlet weak var labelCommentCount: UILabel!
    @IBOutlet weak var articalImageloadingView: UIActivityIndicatorView!
    @IBOutlet weak var imageViewArticeHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageViewUserProfile.layer.cornerRadius = 20.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    func setupData(blog : ParentTree){
        self.labelUserName.text = blog.users?.first?.name
        self.userDescription.text = blog.users?.first?.about
        self.labelArticelDescription.text = blog.content
        let likesCount = Shortener().string(from: String(blog.likes))
        self.labelLikesCount.text = (likesCount ?? "0") + " Likes"
        let commentsCount = Shortener().string(from: String(blog.comments ))
        self.labelCommentCount.text = (commentsCount ?? "0") + " Comments"
        if let iconUrl = URL.init(string: blog.users?.first?.avatar ?? ""){
            ImageDownloadManager.downloadImage(url: iconUrl) { (image, error) in
                if error != nil{
                    self.imageViewUserProfile.image = UIImage.init(named: "user")
                }else{
                    self.imageViewUserProfile.image = image
                }
            }
        }

        if blog.mediaDetail?.count ?? 0 > 0{
            if let iconUrl = URL.init(string: blog.mediaDetail?.first?.image ?? ""){
                self.articalImageloadingView.isHidden = false
                self.articalImageloadingView.startAnimating()
                self.imageViewArticeHeight.constant = 150.0
                ImageDownloadManager.downloadImage(url: iconUrl) { (image, error) in
                    self.articalImageloadingView.isHidden = true
                    self.articalImageloadingView.stopAnimating()
                    if error != nil{
                        self.imageViewArtice.image = UIImage.init(named: "article")
                    }else{
                        self.imageViewArtice.image = image
                    }
                }
            }
        }else{
            self.imageViewArticeHeight.constant = 0.0
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from:blog.createdAt ?? ""){
            self.labelTime.text = date.getElapsedInterval()
        }
    }
}
