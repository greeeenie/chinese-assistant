import SwiftUI

struct ContentView: View {
    @State private var isOnboardingComplete = false
    
    var body: some View {
        if isOnboardingComplete {
            MainTabView()
        } else {
            OnboardingView(isOnboardingComplete: $isOnboardingComplete)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LessonViewModel())
}
