import SwiftUI
import SwiftData

struct AddTransactionSheet: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var merchant = ""
    @State private var amount = ""
    @State private var date: Date = .now
    @State private var category: Transaction.Category = .other
    @State private var isSubscription = false
    @State private var notes = ""


    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Merchant", text: $merchant)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    DatePicker("Date", selection: $date, displayedComponents: [.date])
                    Picker("Category", selection: $category) {
                        ForEach(Transaction.Category.allCases) { category in
                            Text(category.displayName)
                                .tag(category)
                        }
                    }
                    Toggle("Subscription", isOn: $isSubscription)
                }

                Section("Notes") {
                    TextField("Optional notes", text: $notes, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                }
            }
            .navigationTitle("Add transaction")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveTransaction()
                    }
                }
            }
        }
    }

    private func saveTransaction() {
        guard let amount = Double(amount), amount >= 0 else { return }

        let transaction = Transaction(
            id: UUID(),
            amount: amount,
            date: date,
            merchant: merchant,
            category: category,
            isSubscription: isSubscription,
            notes: notes.isEmpty ? nil : notes
        )

        context.insert(transaction)
        dismiss()
    }
}

#Preview {
    AddTransactionSheet()
}
