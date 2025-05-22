//
//  CodableBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by Digital Base on 22/5/25.
//

import SwiftUI

// normally conform like this
// struct CustomerModel: Identifiable, Decodable, Encodable { ... } // Codable = Encodable + Decodable

struct CustomerModel: Identifiable, Codable {
    let id: String
    let name: String
    let point: Int
    let isPremium: Bool
    
    //    init(id: String, name: String, point: Int, isPremium: Bool) {
    //        self.id = id
    //        self.name = name
    //        self.point = point
    //        self.isPremium = isPremium
    //    }
    //
    //    enum CodingKeys: CodingKey {
    //        case id, name, point, isPremium
    //    }
    //
    //    init(from decoder: any Decoder) throws {
    //        let container = try decoder.container(keyedBy: CodingKeys.self)
    //        self.id = try container.decode(String.self, forKey: .id)
    //        self.name = try container.decode(String.self, forKey: .name)
    //        self.point = try container.decode(Int.self, forKey: .point)
    //        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
    //    }
    //
    //    func encode(to encoder: any Encoder) throws {
    //        var container = encoder.container(keyedBy: CodingKeys.self)
    //        try container.encode(self.id, forKey: .id)
    //        try container.encode(self.name, forKey: .name)
    //        try container.encode(self.point, forKey: .point)
    //        try container.encode(self.isPremium, forKey: .isPremium)
    //    }
}


class CodableViewModel: ObservableObject {
    //    @Published var customer: CustomerModel? = CustomerModel(id: "1", name: "Gay Oak", point: 29, isPremium: true)
    @Published var customer: CustomerModel? = nil
    
    init() {
        guard let jsonData = getJSONData() else { return }
        
        // Manually decoing //
        //        if
        //            let localData = try? JSONSerialization.jsonObject(with: jsonData, options: []),
        //            let dictionary = localData as? [String:Any],
        //            let id = dictionary["id"] as? String,
        //            let name = dictionary["name"] as? String,
        //            let point = dictionary["point"] as? Int,
        //            let isPremium = dictionary["isPremium"] as? Bool {
        //            let newCustomer = CustomerModel(id: id, name: name, point: point, isPremium: isPremium)
        //            customer = newCustomer
        
        
        // do try catch
        //        do {
        //            self.customer = try JSONDecoder().decode(CustomerModel.self, from: jsonData)
        //        } catch let error {
        //            print("Error decoding \(error)")
        //        }
        
        self.customer = try? JSONDecoder().decode(CustomerModel.self, from: jsonData)
        
    }
    
    
    func getJSONData()-> Data? {
        
        // Manually encode //
        
        //        let dictionary: [String:Any] = [
        //            "id" : "12345",
        //            "name" : "Oak",
        //            "point" : 213,
        //            "isPremium" : true
        //        ]
        
        //        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        
        let customer = CustomerModel(id: "23", name: "Gay Oak", point: 2432, isPremium: true)
        let jsonData = try? JSONEncoder().encode(customer)
        
        return jsonData
    }
}

struct CodableBootcamp: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.point)")
                Text(customer.isPremium.description)
            }
        }
    }
}

#Preview {
    CodableBootcamp()
}
