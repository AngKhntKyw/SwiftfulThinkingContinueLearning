//
//  TypealiasBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by Digital Base on 22/5/25.
//

import SwiftUI


struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

typealias TVModel = MovieModel



struct TypealiasBootcamp: View {
    
    //    @State var item: MovieModel = MovieModel(title: "Tenet", director: "Christopher", count: 30)
    @State var item: TVModel = TVModel(title: "Tenet", director: "Christopher", count: 30)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

#Preview {
    TypealiasBootcamp()
}
