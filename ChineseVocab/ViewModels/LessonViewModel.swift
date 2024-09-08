import Foundation
import SwiftUI
import CoreData

final class LessonViewModel: ObservableObject {
    init() {
        fetchLessons()
    }
    
    let manager = CoreDataManager.shared
    @Published var name: String = ""
    @Published var color: Color = Color.red
    @Published var date: Date = Date()
    @Published var lessonEntities: [LessonEntity] = []
    @Published var lessonModels: [Lesson] = []
    var daysLeft: Int {
        Calendar.current.dateComponents([.day], from: Date.now, to: date).day ?? -1
    }
    
    func createLessonAsync(name: String, color: String, daysLeft: Int) async {
        var requestModel = Lesson()
        requestModel.name = name
        requestModel.color = color
        requestModel.daysLeft = daysLeft
        
        guard let encoded = try? JSONEncoder().encode(requestModel) else {
            print("Failed to encode input")
            return
        }
        
        guard let url = URL(string: "http://127.0.0.1:8080/lessons") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            try await URLSession.shared.upload(for: request, from: encoded)
            await fetchLessonsAsync()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func fetchLessonsAsync() async {
        guard let url = URL(string: "http://127.0.0.1:8080/lessons") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let lessons = try JSONDecoder().decode([Lesson].self, from: data)
            DispatchQueue.main.async {
                self.lessonModels = lessons
            }
        } catch {
            print("Failed to fetch or decode lessons: \(error)")
        }
        print(lessonModels)
    }

    func updateLessonAsync(id: Int, name: String, color: String, daysLeft: Int) async {
        var requestModel = Lesson()
        requestModel.id = id
        requestModel.name = name
        requestModel.color = color
        requestModel.daysLeft = daysLeft
        
        guard let encoded = try? JSONEncoder().encode(requestModel) else {
            print("Failed to encode input")
            return
        }
        
        guard let url = URL(string: "http://127.0.0.1:8080/lessons/\(id)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        request.httpBody = encoded
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            let lesson = try JSONDecoder().decode(Lesson.self, from: data)
            DispatchQueue.main.async {
                if let index = self.lessonModels.firstIndex(where: { $0.id == lesson.id }) {
                    self.lessonModels[index] = lesson
                    self.objectWillChange.send()
                }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func deleteLessonAsync(id: Int) async {
        guard let url = URL(string: "http://127.0.0.1:8080/lessons/\(id)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "DELETE"
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            DispatchQueue.main.async {
                self.lessonModels.removeAll { $0.id == id }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func createLesson(name: String, color: Color, date: Date, daysLeft: Int) {
        let newLesson = LessonEntity(context: manager.context)
        newLesson.name = name
        newLesson.color = color.asData
        newLesson.date = date
        newLesson.daysLeft = Int16(daysLeft)
        saveData()
    }
    
    func fetchLessons() {
        let request = NSFetchRequest<LessonEntity>(entityName: "LessonEntity")
        do {
            lessonEntities = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func updateLesson(index: Int, name: String, color: Color, date: Date, daysLeft: Int) {
        let existingLesson = lessonEntities[index]
        existingLesson.name = name
        existingLesson.color = color.asData
        existingLesson.date = date
        existingLesson.daysLeft = Int16(daysLeft)
        saveData()
    }
    
    func deleteLesson(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = lessonEntities[index]
        manager.context.delete(entity)
        saveData()
    }
    
    func saveData() {
        manager.saveData()
        fetchLessons()
    }
    
    
}
