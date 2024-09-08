import Foundation
import CoreData
import SwiftUI

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "LessonsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data \(error)")
            }
        }
        context = container.viewContext
    }
    
    func saveData() {
        do {
            try context.save()
            print("Saved successfully")
        } catch let error {
            print("Error saving \(error.localizedDescription)")
        }
    }
}
