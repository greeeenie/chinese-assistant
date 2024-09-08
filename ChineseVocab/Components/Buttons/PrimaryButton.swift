import Foundation
import SwiftUI

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .font(.system(size: 17, weight: .medium))
            .scaleEffect(configuration.isPressed ? 1.15 : 1)
            .foregroundStyle(.white)
            .background(configuration.isPressed ? .gray : .black)
            .clipShape(Capsule())
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct PrimaryButtonPreview: View {
    var body: some View {
        Button("Press Me") {
            print("Button pressed!")
        }
        .buttonStyle(PrimaryButton())
    }
}

#Preview {
    PrimaryButtonPreview()
}
