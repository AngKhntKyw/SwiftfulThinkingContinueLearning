//
//  LongPressGestureBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by Digital Base on 18/5/25.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    
    @State var isCompleted:Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        
        //        Text(isCompleted ? "COMPLETED" : "NOT COMPLETED")
        //            .padding()
        //            .padding(.horizontal)
        //            .background(isCompleted ? .green : .gray)
        //            .cornerRadius(10)
        //            .onLongPressGesture(minimumDuration: 1, maximumDistance: 50) {
        //                isCompleted.toggle()
        //            }
        
        VStack {
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(maxWidth: isCompleted ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray)
            
            HStack {
                Text("Click here")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 5, maximumDistance: 50) { (isPressing) in
                        // start of press -> minimun duration
                        if isPressing {
                            withAnimation(.easeInOut(duration: 5)) {
                                isCompleted = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut(duration: 1)) {
                                        isCompleted = false
                                    }
                                }
                            }
                        }
                    } perform: {
                        // at the minimun duration
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    }
                
                Text("Reset")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isCompleted = false
                        isSuccess = false
                    }
            }
            
        }
    }
}

#Preview {
    LongPressGestureBootcamp()
}
