//
//  ViewController.swift
//  PaginationDemo
//
//  Created by Nitu Kumari on 29/04/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = PostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "PostsTableViewCell", bundle: nil), forCellReuseIdentifier: "PostsTableViewCell")
        tableView.estimatedRowHeight = 80
        viewModel.delegate = self
        tableView.prefetchDataSource = self
        viewModel.getPostFromApiCall(viewModel.currentPage)
        
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell", for: indexPath) as? PostsTableViewCell
        
        let post = viewModel.posts[indexPath.row]
        cell?.updatePost(post)
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        if indexPaths.contains(where: {$0.row >= viewModel.posts.count - 5}) && !viewModel.isloading {
            viewModel.isloading = true
            viewModel.currentPage += 1
            viewModel.getPostFromApiCall(viewModel.currentPage)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension ViewController: PostViewModelDelegate {
    
    func fetchPosts(_ posts: [Posts]) {
      
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

}
