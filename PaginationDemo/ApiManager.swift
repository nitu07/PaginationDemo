//
//  ApiManager.swift
//  PaginationDemo
//
//  Created by Nitu Kumari on 29/04/24.
//

import Foundation

class ApiManager {
    
    static var shared = ApiManager()
    
    
    func fetDataFromServer<DataKind:Codable>(_ page: Int, _ dataKind: DataKind.Type, completion: @escaping(_ data:DataKind) -> Void) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_page=\(page)&_limit=20") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data,  error == nil else { return  }
            
            do {
                let postArr = try JSONDecoder().decode(dataKind, from: data)
                completion(postArr)
            } catch {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    
    }
}

