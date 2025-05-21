//
//  CoreDataRelationshipsBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by Digital Base on 20/5/25.
//

import SwiftUI
import CoreData

// 3 entities
// BusinessEntity
// DapartmentEntity
// EmployeeEntity


class CoredataManager {
    static let instance = CoredataManager()  // Singleton
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("saved successfully")
        } catch let error {
            print("Error saving core data \(error.localizedDescription)")
        }
    }
}


class CoreDataRelationshipsViewModel: ObservableObject {
    
    let manager = CoredataManager.instance
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    
    init() {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        
        //        let filter = NSPredicate(format: "name == %@", "Microsoft")
        //        request.predicate = filter
        
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Fetching businesses error \(error)")
        }
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        
        do {
            departments = try manager.context.fetch(request)
        } catch let error {
            print("Fetching departments error \(error)")
        }
    }
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Fetching employees error \(error)")
        }
    }
    
    func getEmployees(forBusiness business: BusinessEntity) {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        let filter = NSPredicate(format: "business ==  %@", business)
        request.predicate = filter
        
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Fetching employees error \(error)")
        }
    }
    
    func updateBusiness() {
        let existingBusiness = businesses[6]
        existingBusiness.addToDepartments(departments[1])
        save()
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Facebook"
        
        // add existing departments to the new business
        //        newBusiness.departments = [departments[0], departments[1]]
        
        // existing employess to the new business
        //        newBusiness.employees = [employees[1]]
        
        // add new business to existing dapartment
        //        newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        // add new business to existing employee
        //        newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Sdaf"
        newDepartment.businesses = [businesses[0], businesses[1], businesses[2]]
        newDepartment.employees = [employees[0], employees[1]]
        // another way
        //        newDepartment.addToEmployees(employees[0])
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = "Mike"
        newEmployee.dateJoined = Date()
        newEmployee.age = 28
        newEmployee.business = businesses[6]
        newEmployee.department = departments[0]
        save()
    }
    
    func deleteBusiness() {
        let business = businesses[1]
        manager.context.delete(business)
        save()
    }
    
    func deleteDepartment() {
        let department = departments[0]
        manager.context.delete(department)
        save()
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.manager.save()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
    }
}

struct CoreDataRelationshipsBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Button {
                        vm.addDepartment()
                    } label: {
                        Text("Perform action")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    }
                    
                    
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct BusinessView: View {
    
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Name : \(entity.name ?? "Unknown business")")
                .fontWeight(.bold)
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                
                Text("Departments : ")
                    .fontWeight(.bold)
                
                ForEach(departments) { department in
                    Text(department.name ?? "Unknown department")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees :")
                    .fontWeight(.bold)
                
                ForEach(employees) { employee in
                    Text(employee.name ?? "Unknown employee")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct DepartmentView: View {
    
    let entity: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Name : \(entity.name ?? "Unknown department")")
                .fontWeight(.bold)
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses :")
                    .fontWeight(.bold)
                
                ForEach(businesses) { business in
                    Text(business.name ?? "Unknown business")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees :")
                    .fontWeight(.bold)
                
                ForEach(employees) { employee in
                    Text(employee.name ?? "Unknown employee")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(.green.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct EmployeeView: View {
    
    let entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Name : \(entity.name ?? "Unknown Employee")")
                .fontWeight(.bold)
            
            Text("Age : \(entity.age)")
                .fontWeight(.bold)
            
            Text("Date Joined : \(entity.dateJoined ?? Date())")
                .fontWeight(.bold)
            
            Text("Business :")
                .fontWeight(.bold)
            
            Text(entity.business?.name ?? "Unknown Business")
            
            Text("Department :")
                .fontWeight(.bold)
            
            Text(entity.department?.name ?? "Unknown Department")
            
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(.blue.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

#Preview {
    CoreDataRelationshipsBootcamp()
}
