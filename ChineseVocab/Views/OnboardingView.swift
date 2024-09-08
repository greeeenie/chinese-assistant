import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboardingComplete: Bool
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Image("image_placeholder")
                    .resizable()
                    .frame(width: 250, height: 250)
                
                Text("Welcome to Chinese Assistant!")
                    .font(.title2)
                
                Text("Start learning chinese today.")
                    .font(.subheadline)
                
                Button {
                    withAnimation {
                        isOnboardingComplete = true
                    }
                } label: {
                    Text("Get Started")
                }
                .buttonStyle(PrimaryButton())
                .padding()
            }
        }
    }
}

