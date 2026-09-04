import SwiftUI
import SwiftData

struct TransactionsView: View {

    @Environment(\.modelContext) private var context

    @Query(
        FetchDescriptor<Transaction>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
    ) private var transactions: [Transaction]

    @State private var isAddSheetPresented = false
    @State private var editMode: EditMode = .inactive

    var body: some View {
        NavigationStack {
            Group {
                if transactions.isEmpty {
                    ContentUnavailableView(
                        "No transactions",
                        systemImage: "tray",
                        description: Text("Add your first transaction to get started.")
                    )
                    .padding()
                } else {
                    List {
                        ForEach(transactions) { transaction in
                            TransactionRowView(transaction: transaction)
                        }
                        .onDelete(perform: deleteTransactions)
                    }
                }
            }
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAddSheetPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddSheetPresented) {
                AddTransactionSheet()
            }
            .environment(\.editMode, $editMode)
        }
    }

    private func loadTransactions() {
        let transactions = Transaction.mocks

        for transaction in transactions {
            context.insert(transaction)
        }
    }

    private func deleteTransactions(at offsets: IndexSet) {
        for index in offsets {
            let transaction = transactions[index]
            context.delete(transaction)
        }
    }
}

#Preview {
    TransactionsView()
}
