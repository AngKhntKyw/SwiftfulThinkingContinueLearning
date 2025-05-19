//
//  GeometryReaderBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by Digital Base on 19/5/25.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    
    // if the app is only in portrait mode , just use UIScreen.main.bounds.width
    // just use geometry when we also wanna use landscape mode
    // geometry costs a lot of computing
    
    var body: some View {
        
        //        GeometryReader { geometry in
        //            HStack(spacing: 0) {
        //                Rectangle()
        //                    .fill(.red)
        //                    .frame(width: geometry.size.width * 0.6666)
        //
        //                Rectangle()
        //                    .fill(.blue)
        //            }
        //            .ignoresSafeArea()
        //        }
        
        
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 20),
                                axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        })
        
        
    }
    
    func getPercentage(geo : GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).minX
        return Double(1 - (currentX / maxDistance))
        
    }
}



#Preview {
    GeometryReaderBootcamp()
}
