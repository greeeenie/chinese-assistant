import SwiftUI

struct LessonListView: View {    
    @EnvironmentObject var vm: LessonViewModel
    @State var isShowingLessonSettings: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.lessonModels, id: \.id) { lesson in
                    LessonCardView(lesson: lesson)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                Task {
                                    await vm.deleteLessonAsync(id: lesson.id)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            .tint(.red)
                        }
                }
            }
            .refreshable {
                await vm.fetchLessonsAsync()
            }
            .onAppear {
                Task {
                    await vm.fetchLessonsAsync()
                }
            }
            .overlay(Group {
                if vm.lessonModels.isEmpty {
                    VStack {
                        Image("image_placeholder")
                        Text("Your list is empty")
                            .font(.title2)
                    }
                    .padding(.bottom, 165)
                }
            })
            .scrollDisabled(vm.lessonEntities.isEmpty)
            .scrollContentBackground(.hidden)
            .background(Color("GrayBackground"))
            .navigationTitle("Lessons")
            .toolbar() {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingLessonSettings.toggle()
                        
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundStyle(.black)
                    }
                }
            }
            .listRowSpacing(12)
            .sheet(isPresented: $isShowingLessonSettings) {
                LessonCreationView(isShowingLessonSettings: $isShowingLessonSettings, index: .constant(nil))
            }
        }
        
    }
}


//#Preview {
//    LessonListView()
//        .environmentObject(LessonViewModel())
//}

