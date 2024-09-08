import Foundation
import SwiftUI

extension String {
    var colorValue: Color {
        switch self {
        case "red": return .red
        case "orange": return .orange
        case "yellow": return .yellow
        case "green": return .green
        case "blue": return .blue
        case "purple": return .purple
        case "pink": return .pink
        default: return .red
        }
    }
}
