import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = QuoteViewModel()
    
    var body: some View {
        ZStack {
            // Professional gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "1A2F1A"), // Dark green
                    Color(hex: "0D1810"), // Darker green
                    Color(hex: "080C08")  // Almost black
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                // Logo at the top
                Image("breaking-bad-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 120)
                    .padding(.top, 30)
                    .padding(.horizontal)
                
                Spacer()
                
                // Quote in the middle
                if let quote = viewModel.currentQuote {
                    VStack(spacing: 16) {
                        Text(quote.quote)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundColor(.white)
                        
                        Text("- \(quote.author)")
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                }
                
                Spacer()
                
                // Button at the bottom
                Button(action: {
                    Task {
                        await viewModel.fetchNewQuote()
                    }
                }) {
                    Text("Get Quote")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .background(
                            Color(hex: "369457") // Breaking Bad green
                        )
                        .cornerRadius(10)
                }
                .padding(.bottom, 30)
            }
            .padding()
        }
        .task {
            await viewModel.fetchNewQuote()
        }
    }
}

// Add this extension to support hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
