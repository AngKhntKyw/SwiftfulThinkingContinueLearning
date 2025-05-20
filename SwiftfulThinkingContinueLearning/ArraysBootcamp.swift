//
//  ArraysBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by Digital Base on 20/5/25.
//

import SwiftUI


struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name : String?
    let point: Int
    let isVerified: Bool
}

class ArrayModificationViewModel : ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func getUsers () {
        
        let user1 = UserModel(name: "Nick", point: 4, isVerified: true)
        let user2 = UserModel(name: "Mike", point: 423, isVerified: false)
        let user3 = UserModel(name: "John", point: 89, isVerified: true)
        let user4 = UserModel(name: nil, point: 10, isVerified: false)
        let user5 = UserModel(name: nil, point: 59, isVerified: true)
        let user6 = UserModel(name: "John Doe", point: 592, isVerified: false)
        let user7 = UserModel(name: "Jack", point: 99, isVerified: true)
        let user8 = UserModel(name: "Herry", point: 239, isVerified: true)
        let user9 = UserModel(name: "Tony", point: 24, isVerified: false)
        let user10 = UserModel(name: "Chris", point: 56, isVerified: true)
        
        dataArray.append(contentsOf: [user1,user2,user3,user4,user5,user6,user7,user8,user9,user10])
    }
    
    func updateFilteredArray() {
        
        // SORT
        /* filteredArray = dataArray.sorted { user1, user2 in
         user1.point > user2.point
         }
         filteredArray = dataArray.sorted(by: { $0.point < $1.point })
         */
        
        
        // FILTER
        /*
         filteredArray = dataArray.filter({ user in
         //            user.point < 50
         user.isVerified
         //            user.name.contains("i")
         })
         filteredArray = dataArray.filter { $0.isVerified }
         */
        
        
        // MAP
        /*
         mappedArray = dataArray.map({ user in
         user.name
         })
         mappedArray = dataArray.map { $0.name ?? "Unknown"}
         mappedArray = dataArray.compactMap({ user in
         user.name
         })
         
         mappedArray = dataArray.compactMap { $0.name} // compactMap returns that values that are not nil
         */
        
        
        mappedArray = dataArray
            .sorted {$0.point > $1.point }
            .filter { $0.isVerified }
            .compactMap{ $0.name }
        
        
    }
}

struct ArraysBootcamp: View {
    
    @State var vm = ArrayModificationViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    //                    ForEach(vm.filteredArray) { user in
                    //                        VStack(alignment: .leading) {
                    //                            Text(user.name)
                    //                                .font(.headline)
                    //
                    //                            HStack {
                    //                                Text("Points: \(user.point)")
                    //                                Spacer()
                    //                                if user.isVerified {
                    //                                    Image(systemName: "flame.fill")
                    //                                }
                    //                            }
                    //                        }
                    //                        .foregroundColor(.white)
                    //                        .padding()
                    //                        .background(.blue)
                    //                        .cornerRadius(10)
                    //                        .padding(.horizontal)
                    //                    }
                    ForEach(vm.mappedArray, id: \.self) { name in
                        Text(name)
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("Users")
        }
    }
}

#Preview {
    ArraysBootcamp()
}
