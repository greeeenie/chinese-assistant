import SwiftUI
import UIKit

extension Color {
    func toUIColor() -> UIColor {
        let components = UIColor(self).cgColor.components
        return UIColor(
            red: components?[0] ?? 0,
            green: components?[1] ?? 0,
            blue: components?[2] ?? 0,
            alpha: components?.count == 4 ? components?[3] ?? 1 : 1
        )
    }
}

extension Color {
    var asData: Data? {
        return UIColor(self).encode()
    }
}

extension Data {
    var asColor: Color {
        if let uiColor = UIColor.decode(from: self) {
            return Color(uiColor)
        } else {
            return Color.black
        }
    }
}

extension UIColor {
    func encode() -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }
    
    static func decode(from data: Data) -> UIColor? {
        return try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
    }
}

extension Color {
    var colorName: String {
        switch self {
        case .red: return "red"
        case .orange: return "orange"
        case .yellow: return "yellow"
        case .green: return "green"
        case .blue: return "blue"
        case .purple: return "purple"
        case .pink: return "pink"
        default: return "unknown"
        }
    }
}
