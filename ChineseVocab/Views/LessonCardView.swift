import SwiftUI

struct LessonCardView: View {
    var lesson: Lesson
    @State var isShowingLessonSettings: Bool = false
    @EnvironmentObject var vm: LessonViewModel
    @State private var selectedIndex: Int?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(lesson.name)
                    .font(.system(size: 20))
                HStack {
                    Image(systemName: "clock")
                        .fontWeight(.medium)
                        .foregroundStyle(Color(uiColor: lesson.color.colorValue.toUIColor()))
                    Text(lesson.daysLeft == 1 ? "1 day left" : "\(lesson.daysLeft) days left")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(uiColor: lesson.color.colorValue.toUIColor()))
                }
                .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                .background(Color(uiColor: lesson.color.colorValue.toUIColor()).opacity(0.09))
                .cornerRadius(.infinity)
            }
            Spacer()
            
            Menu {
                Button(role: .destructive) {
                    Task {
                        await vm.deleteLessonAsync(id: lesson.id)
                    }
                } label: {
                    Label("Delete", systemImage: "trash.fill")
                }
                
                Button(role: .none) {
                    selectedIndex = lesson.id
                    isShowingLessonSettings.toggle()
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .fontWeight(.medium)
                    .imageScale(.large)
                    .frame(width: 48, height: 48)
                    .tint(.secondary)
            }
        }
        .sheet(isPresented: $isShowingLessonSettings) {
            LessonCreationView(isShowingLessonSettings: $isShowingLessonSettings, index: $selectedIndex)
        }
    }
}

//#Preview {
//    LessonListView()
//        .environmentObject(LessonViewModel())
//}
