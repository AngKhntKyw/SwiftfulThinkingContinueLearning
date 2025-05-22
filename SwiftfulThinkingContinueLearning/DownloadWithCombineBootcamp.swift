//
//  DownloadWithCombineBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by Digital Base on 22/5/25.
//

import SwiftUI
import Combine

struct Post: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineBootcampViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        
        // Combine discussion
        // example ====>
        // 1. sign up for monthly subscription for package to be delivered
        // 2. the company would make the package behind the scene
        // 3.  receive the package at your front door
        // 4. make sure the box isn't damaged
        // 5. open and make sure the item is correct
        // 6. use the item
        // 7. cancellable at anytime
        
        
        // 1. create the publisher
        // 2. subscribe publisher on background thread (this is auto made by dataTaskPublisher)
        // 3. receive on main thread
        // 4. tryMap (check the data is good)
        // 5. decode data into Post (Model) or [Post] (array of Post)
        // 6. sink (put the item into our app)
        // 7. store (cancel subscription if needed)
        
        
        URLSession.shared.dataTaskPublisher(for: url)
        //.subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
        //            .tryMap { data, response -> Data in
        //                guard let response = response as? HTTPURLResponse,
        //                      response.statusCode >= 200 && response.statusCode < 300 else {
        //                    throw URLError(.badServerResponse)
        //                }
        //                return data
        //            }
            .tryMap(handleOutput)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .replaceError(with: [])
        
        // by add replaceError , we can use sink with only receiveValue because if somethings goes wrong, it will return empty array in this case
        
        //        .sink { (completion) in
        ////                switch completion {
        ////                case .finished:
        ////                    print("finished")
        ////                case .failure(let error):
        ////                    print("there was an eror \(error)")
        ////                }
        //            } receiveValue: { [weak self] (returnedPosts) in
        //                self?.posts = returnedPosts
        //            }
            .sink(receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            })
            .store(in: &cancellables)
        
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombineBootcamp: View {
    
    @StateObject var vm = DownloadWithCombineBootcampViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.posts) { post in
                    NavigationLink(destination: PostDetailScreen(post: post)) {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(alignment: .center) {
                                Circle()
                                    .frame(width: 35, height: 35)
                                    .overlay (
                                        Text("\(post.id)")
                                            .foregroundColor(.white)
                                        ,alignment: .center
                                    )
                                Text(post.title)
                                    .font(.headline)
                            }
                            Text(post.body)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .listStyle(.inset)
            .navigationTitle("Posts")
        }
    }
}

struct PostDetailScreen: View {
    
    let post: Post
    
    var body : some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(post.title)
                .font(.headline)
            Text(post.body)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    DownloadWithCombineBootcamp()
}
