
import Foundation
import CoreData
import SwiftUI

class coreDataviewModel: ObservableObject {
    
    let container: NSPersistentContainer
    
    @Published var saveEntities: [UserEntity] = []
    @Published var businessesEntities: [BusinessEntity] = []

    init () {
        container = NSPersistentContainer(name: "userCoreData")
        let mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        container.viewContext.mergePolicy = mergePolicy
        container.loadPersistentStores { description, error in
            if let error = error  {
                
                print("ERROR LOADING CORE DATA\(error)")
            }
            else {
                print("Successfully loaded core data ")
            }
        }
        
        fetchUser()
        fetchAnimal()


    }
    func fetchUser (){
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        do{
            saveEntities = try container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching \(error)")
        }
    }
    
    func fetchLoggedInUserBusiness() -> [BusinessEntity]? {
        if let loggedInUser = findLoggedInUser() {
            if let business = loggedInUser.businesses {
                return business.allObjects as? [BusinessEntity]
            }
        }
        return nil
    }
    
    
    func fetchAnimal() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        do{
            businessesEntities = try container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching \(error)")
        }
    }
    
    func saveData () {
        
        container.viewContext.perform {
            
            do{
                try self.container.viewContext.save()
                
            }catch let error{
                print("Error Saving the information. \(error)")
                
            }
        }
    }
 
    func addUser (userName: String, passWord: String, email: String){
        let newUser = UserEntity(context: container.viewContext)
        
        newUser.userID = userName
        newUser.password = passWord
        newUser.email = email
        print("added user successfully")
        saveData()
    }
    
    func returnPassword(userName: String) -> String {
        
        return findLoggedInUser()?.password ?? "unknow password"
    }
    //check the login's information from database
    func isValidLogin (username: String, password: String) -> Bool {
        for entity in saveEntities {
            if entity.userID == username && entity.password == password{
                entity.islogin = true
                print("Login status set to : \(entity.islogin)")
                saveData()
                return true
            }
        }
        return false
    }
    //update password from the edit page
    func updatePassword(currentUser: String, newPassword: String) {
        
        for entity in saveEntities {
            if entity.userID == currentUser {
                entity.password = newPassword
                saveData()
            }
        }
    }
    
    func addBusiness( business: business) -> Bool{
        
        //
        if let loginUser = findLoggedInUser() {
            
            print("add animal success")
            let newBusiness = BusinessEntity(context: container.viewContext)
            newBusiness.imageUrl = business.imageURL
            newBusiness.name = business.name
            newBusiness.rating = business.rating
            newBusiness.url = business.url
            loginUser.addToBusinesses(newBusiness)
            saveData()
            return true
            }
        else {
            print("Fail to add animal")
            return false
        }
        
    }
    
    func findLoggedInUser() -> UserEntity? {
        return saveEntities.first(where: { $0.islogin})
    }
    func isPasswordValid (password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func logOutUser (username: String) {
        for entity in saveEntities {
            if entity.userID == username {
                print("log out successfuly")
                entity.islogin = false
                print("Login status set to : \(entity.islogin)")
                saveData()
                
            }
        }
    }
    
}
