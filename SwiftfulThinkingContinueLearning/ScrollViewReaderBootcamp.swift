//
//  ScrollViewReaderBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by Digital Base on 19/5/25.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    
    @State var textFieldText: String = ""
    @State var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            
            TextField("Enter a number here...", text: $textFieldText)
                .frame(height: 45)
                .border(.gray, width: 1)
                .padding(.horizontal)
                .keyboardType(.numberPad)
                .cornerRadius(10)
            
            Button("Scroll now") {
                if let index = Int(textFieldText) {
                    scrollToIndex = index
                }
                
            }
            
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<50) { index in
                        Text("This is item number \(index)")
                            .font(.headline)
                            .frame(height: CGFloat.random(in: 100...400))
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    
                    //                    .onChange(of: scrollToIndex) { value in
                    //                        withAnimation(.spring()) {
                    //                            proxy.scrollTo(value, anchor: .top)
                    //                        }
                    //                    }
                    
                    
                    .onChange(of: scrollToIndex) { oldValue, value in
                        withAnimation(.spring()) {
                            proxy.scrollTo(value, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderBootcamp()
}
