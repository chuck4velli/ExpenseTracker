import SwiftUI

struct TransactionRowView: View {
    let transaction: Transaction

    var body: some View {
        HStack {
            CategoryIcon(category: transaction.category)

            VStack(alignment: .leading) {
                Text(transaction.merchant)
                    .font(.headline)

                Text(transaction.category.displayName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text("£\(transaction.amount)")
                    .font(.headline)

                Text(transaction.date.formatted())
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    TransactionRowView(transaction: .mock)
}
