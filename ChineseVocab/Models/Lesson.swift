import SwiftUI
import Foundation

struct Lesson: Codable, Identifiable, Hashable {
    var id: Int
    var name: String
    var color: String
    var daysLeft: Int
}

extension Lesson {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case color
        case daysLeft
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawId = try container.decode(Int.self, forKey: .id)
        let rawName = try container.decode(String.self, forKey: .name)
        let rawColor = try container.decode(String.self, forKey: .color)
        let rawDaysLeft = try container.decode(Int.self, forKey: .daysLeft)
        
        self.id = rawId
        self.name = rawName
        self.color = rawColor
        self.daysLeft = rawDaysLeft
    }
    
    init() {
        self.id = Int()
        self.name = String()
        self.color = String()
        self.daysLeft = Int()
    }

}


