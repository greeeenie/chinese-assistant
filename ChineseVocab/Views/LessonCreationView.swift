import SwiftUI

struct LessonCreationView: View {
    @EnvironmentObject var vm: LessonViewModel
    @State var selectedDate: Date = Date()
    @Binding var isShowingLessonSettings: Bool
    @Binding var index: Int?
    var isEditingMode: Bool {
        index != nil
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        TextField("Lesson name", text: $vm.name)
                    } header: {
                        Text("Name")
                    }
                    
                    Section {
                        ColorPickerView()
                    } header: {
                        Text("Color")
                    }
                    
                    Section {
                        DatePicker("Due", selection: $vm.date, in: Date.now..., displayedComponents: .date)
                    } header: {
                        Text("Date")
                    }
                }
                .background(Color.grayBackground)
                .scrollContentBackground(.hidden)
                
                Button(role: .none) {
                    if isEditingMode {
                        vm.updateLesson(index: index!, name: vm.name != "" ? vm.name : "Updated Lesson", color: vm.color, date: selectedDate, daysLeft: vm.daysLeft)
                        Task {
                            await vm.updateLessonAsync(id: index!, name: vm.name != "" ? vm.name : "Updated Lesson", color: vm.color.colorName, daysLeft: vm.daysLeft)
                        }
                    }
                    else {
                        vm.createLesson(name: vm.name != "" ? vm.name : "New Lesson", color: vm.color, date: selectedDate, daysLeft: vm.daysLeft)
                        Task {
                            await vm.createLessonAsync(name: vm.name != "" ? vm.name : "New Lesson", color: vm.color.colorName, daysLeft: vm.daysLeft)

                        }
                    }
                    isShowingLessonSettings.toggle()
                } label: {
                    Label("Confirm", systemImage: "checkmark")
                }
                .buttonStyle(PrimaryButton())
                .padding()
            }
            .background(Color.grayBackground)
            .toolbarBackground(.visible)
            .navigationTitle(isEditingMode ? "Edit Lesson" : "New Lesson")
            .navigationBarTitleDisplayMode(.inline)
            .scrollDisabled(true)
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button() {
                        isShowingLessonSettings.toggle()
                    } label: {
                        Label("Back", systemImage: "xmark")
                    }
                    .buttonStyle(ToolbarButton())
                }
                
            }
        }
    }
}


//#Preview {
//    LessonCreationView(index: IndexSet, title: .constant("New Lesson"), isShowingLessonSettings: .constant(true))
//        .environmentObject(LessonViewModel())
//}
