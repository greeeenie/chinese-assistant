import SwiftUI

struct ColorPickerView: View {
    @EnvironmentObject var vm: LessonViewModel
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]

    var body: some View {
        HStack(spacing: 18) {
            ForEach(colors, id: \.self) { color in
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(color)
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: vm.color == color ? 3 : 0)
                            .frame(width: 20, height: 20)
                    )
                    .onTapGesture {
                        vm.color = color
                    }
            }
        }
        
    }
}


