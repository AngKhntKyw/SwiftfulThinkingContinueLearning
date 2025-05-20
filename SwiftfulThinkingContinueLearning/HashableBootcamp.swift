//
//  HashableBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by Digital Base on 20/5/25.
//

import SwiftUI

struct MyCutomModel: Hashable {
    let title: String
    let subtitle: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title + subtitle)
    }
}

struct HashableBootcamp: View {
    
    let data: [MyCutomModel] = [
        MyCutomModel(title: "ONE", subtitle: "one"),
        MyCutomModel(title: "TWO", subtitle: "two"),
        MyCutomModel(title: "THREE", subtitle: "three"),
        MyCutomModel(title: "FOUR", subtitle: "four"),
        MyCutomModel(title: "FIVE", subtitle: "five"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(data, id: \.self) { item in
                    Text(item.title)
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    HashableBootcamp()
}
