//
//  PostViewModel.swift
//  PaginationDemo
//
//  Created by Nitu Kumari on 29/04/24.
//

import Foundation

protocol PostViewModelDelegate:AnyObject {
    func fetchPosts(_ posts:[Posts])
}

class PostViewModel {
    
    weak var delegate: PostViewModelDelegate?
    var isloading = false
    var currentPage = 1
    
    var posts: [Posts] {
        didSet {
            self.delegate?.fetchPosts(posts)
        }
    }
    
    init() {
        posts = []
    }
   
    
    func getPostFromApiCall(_ page: Int) {
        
        ApiManager.shared.fetDataFromServer(page, [Posts].self) { [weak self] data in
            self?.posts.append(contentsOf: data)
            self?.isloading = false
        }
    }
}
