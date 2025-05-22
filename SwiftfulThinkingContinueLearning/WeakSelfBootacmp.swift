//
//  WeakSelfBootacmp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by Digital Base on 21/5/25.
//

import SwiftUI

struct WeakSelfBootacmp: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate", destination: WeakSelfSecondScreen())
                .navigationTitle("Screen 1")
        }
        .overlay (
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(.green)
                .cornerRadius(10)
            , alignment: .topTrailing
        )
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var vm =  WeakSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            
            Text("Second Screen")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
            
        }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject {
    @Published var data: String? = nil
    
    init() {
        print("Initialize now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("Deinitialize now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [ weak self] in
            self?.data = "New Data"
        }
    }
}

#Preview {
    WeakSelfBootacmp()
}
