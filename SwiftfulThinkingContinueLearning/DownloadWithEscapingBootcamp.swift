//
//  DownloadWithEscapingBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by Digital Base on 22/5/25.
//

import SwiftUI


struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        downloadData(fromURL: url) { returnedData in
            if let data = returnedData {
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPosts
                }
                
            } else {
                print("No data returned.")
            }
        }
    }
    
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //
            //            guard let data = data else {
            //                print("No data.")
            //                return
            //            }
            //
            //            guard error == nil else {
            //                print("Error : \(String(describing: error))")
            //                return
            //            }
            //
            //            guard let response = response as? HTTPURLResponse else {
            //                print("No response")
            //                return
            //            }
            //
            //            guard response.statusCode >= 200 && response.statusCode < 300 else {
            //                print("Status code should be 2xx, but is \(response.statusCode)")
            //                return
            //            }
            
            // all in one
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloading data.")
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }.resume()
    }
}

struct DownloadWithEscapingBootcamp: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .listStyle(.grouped)
    }
}

#Preview {
    DownloadWithEscapingBootcamp()
}
