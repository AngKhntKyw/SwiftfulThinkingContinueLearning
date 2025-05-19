//
//  MultipleSheetsBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by Digital Base on 19/5/25.
//

import SwiftUI


struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

// 1 - use binding
// 2 - use multiple .sheets
// 3 - use $item

struct MultipleSheetsBootcamp: View {
    
    @State var selectedModel: RandomModel? = nil
    
    //    @State var showSheet: Bool = false
    //    @State var showSheet2: Bool = false
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                ForEach(0..<20) { index in
                    Button("Button \(index)") {
                        selectedModel = RandomModel(title: "\(index)")
                        //                showSheet.toggle()
                    }
                }
                //            .sheet(isPresented: $showSheet) {
                //                NextScreen(selectedModel: RandomModel(title: "ONE"))
                //            }
                
                //            Button("Button 2") {
                //                selectedModel = RandomModel(title: "TWO")
                
                //                showSheet2.toggle()
                //            }
                //            .sheet(isPresented: $showSheet2) {
                //                NextScreen(selectedModel: RandomModel(title: "TWO"))
                //            }
            }
        }
        .sheet(item: $selectedModel) { model in
            NextScreen(selectedModel: model)
        }
    }
}

struct NextScreen: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultipleSheetsBootcamp()
}
