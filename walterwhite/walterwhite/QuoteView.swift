import SwiftUI

struct QuoteView: View {
    let quote: Quote
    
    var body: some View {
        VStack(spacing: 16) {
            Text("\"\(quote.quote)\"")
                .font(.system(size: 24, weight: .regular)) // At least 11pt as per guidelines
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.horizontal)
            
            Text("- \(quote.author)")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
} 
