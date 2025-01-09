import Foundation
import SwiftUI

struct Quote: Codable {
    let quote: String
    let author: String
}

class QuoteViewModel: ObservableObject {
    @Published var currentQuote: Quote?
    @Published var isLoading = false
    
    func fetchNewQuote() async {
        isLoading = true
        do {
            guard let url = URL(string: "https://api.breakingbadquotes.xyz/v1/quotes") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            let quotes = try JSONDecoder().decode([Quote].self, from: data)
            
            DispatchQueue.main.async {
                self.currentQuote = quotes.first
                self.isLoading = false
            }
        } catch {
            print("Error fetching quote: \(error)")
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}
