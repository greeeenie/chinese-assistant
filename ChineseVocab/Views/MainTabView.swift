import SwiftUI

struct MainTabView: View {
    
    @State var selectedTab = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            SettingsView()
                .tabItem {
                    Text("Settings")
                    Image(systemName: "gearshape")
                }
                .tag(0)
            
            LessonListView()
                .tabItem {
                    Text("Lessons")
                    Image(systemName: "folder")
                }
                .tag(1)

            AccountView()
                .tabItem {
                    Text("Account")
                    Image(systemName: "person")
                }
                .tag(2)
        }
        .tint(Color.black)
        
    }
}

#Preview {
    MainTabView()
        .environmentObject(LessonViewModel())
}
