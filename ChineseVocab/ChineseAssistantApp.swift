import CoreData
import SwiftUI
import Foundation

@main
struct ChineseAssistantApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LessonViewModel())

        }
    }
}
#Preview {
ContentView()
        .environmentObject(LessonViewModel())
    
}
