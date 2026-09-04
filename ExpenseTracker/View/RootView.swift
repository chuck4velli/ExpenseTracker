
import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            Tab("Transactions", systemImage: "list.bullet.rectangle") {
                TransactionsView()
            }
            Tab("Reports", systemImage: "doc.text.magnifyingglass") {
                ReportsView()
            }
        }
    }
}

#Preview {
    RootView()
}
