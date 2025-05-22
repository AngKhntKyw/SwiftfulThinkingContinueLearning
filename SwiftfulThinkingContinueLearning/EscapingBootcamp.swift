//
//  EscapingBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by Digital Base on 22/5/25.
//

import SwiftUI


class EscapingViewModle: ObservableObject {
    @Published var text: String = "Hello"
    
    func getData() {
        //        let newData =  downloadData()
        //        text = newData
        
        downloadData5 { [weak self] data in
            self?.text = data.data
        }
        
        
        dotSomething("Something2")
    }
    
    func downloadData()-> String {
        "New Data"
    }
    
    func downloadData2(completionHandler: (_ data: String) -> ()) {
        completionHandler("New Data 2")
    }
    
    
    func downloadData3(completionHandler: @escaping (_ data: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            completionHandler("New Data 3")
        }
    }
    
    func downloadData4(completionHandler: @escaping (DownloadResult) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let result = DownloadResult(data: "New Data 4")
            completionHandler(result)
        }
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let result = DownloadResult(data: "New Data 5")
            completionHandler(result)
        }
    }
    
    
    func dotSomething(_ data: String)-> () {
        print(data)
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingBootcamp: View {
    
    @StateObject var vm = EscapingViewModle()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    EscapingBootcamp()
}
