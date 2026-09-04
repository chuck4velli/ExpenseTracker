import SwiftUI

struct CategoryIcon: View {

    let category: Transaction.Category

    var body: some View {
        Image(systemName: category.iconInfo.symbol)
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 32, height: 32)
            .background(
                Circle()
                    .fill(category.iconInfo.color)
            )
    }
}

#Preview {
    CategoryIcon(category: .entertainment)
}
