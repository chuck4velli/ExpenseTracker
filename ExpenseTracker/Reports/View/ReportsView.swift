import SwiftUI
import SwiftData

struct ReportsView: View {

    @Environment(\.modelContext) private var context

    @State private var isLoading = false

    var body: some View {
        NavigationStack {
            List {

            }
            .navigationTitle("Reports")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        generateWeeklyReport()
                    } label: {
                        if isLoading {
                            ProgressView()
                        } else {
                            Image(systemName: "sparkles")
                        }
                    }
                }
            }
        }
    }

    private func generateWeeklyReport() {
        guard !isLoading else { return }

        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                let descriptor = FetchDescriptor<Transaction>()
                let transactions = try context.fetch(descriptor)
                let input = FinanceSummaryInput(from: transactions)
                
                let output = try await FinanceSummarizer().summarize(input: input)
                print(output.overview)
                print(output.recommendations)
                print(output.keyInsights)
            } catch {
                print("Fetch failed \(error)")
            }
        }
    }
}

#Preview {
    ReportsView()
}
