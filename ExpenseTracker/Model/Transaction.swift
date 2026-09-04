import SwiftUI
import SwiftData

@Model
class Transaction: Identifiable {
    var id: UUID
    var amount: Double
    var date: Date
    var merchant: String
    var category: Category
    var isSubscription: Bool
    var notes: String?

    init(
        id: UUID,
        amount: Double,
        date: Date,
        merchant: String,
        category: Category,
        isSubscription: Bool,
        notes: String?
    ) {
        self.id = id
        self.amount = amount
        self.date = date
        self.merchant = merchant
        self.category = category
        self.isSubscription = isSubscription
        self.notes = notes
    }

    enum Category: String, Codable, CaseIterable, Identifiable {
        case groceries
        case dining
        case transport
        case shopping
        case entertainment
        case utilities
        case health
        case travel
        case subscriptions
        case other

        var id: String { rawValue }

        var displayName: String {
            switch self {
            case .groceries: return "Groceries"
            case .dining: return "Dining"
            case .transport: return "Transport"
            case .shopping: return "Shopping"
            case .entertainment: return "Entertainment"
            case .utilities: return "Utilities"
            case .health: return "Health"
            case .travel: return "Travel"
            case .subscriptions: return "Subscriptions"
            case .other: return "Other"
            }
        }

        var iconInfo: (symbol: String, color: Color) {
            switch self {
            case .groceries: return ("cart.fill", .green)
            case .dining: return ("fork.knife.circle.fill", .orange)
            case .transport: return ("car.fill", .blue)
            case .shopping: return ("bag.fill", .purple)
            case .entertainment: return ("film.fill", .pink)
            case .utilities: return ("bolt.fill", .yellow)
            case .health: return ("heart.fill", .red)
            case .travel: return ("airplane", .teal)
            case .subscriptions: return ("repeat.circle.fill", .indigo)
            case .other: return ("ellipsis.circle.fill", .gray)
            }
        }
    }
}

extension Transaction {
    static func makeMock(
        id: UUID = UUID(),
        amount: Double,
        daysAgo: Int = 0,
        merchant: String,
        category: Category,
        isSubscription: Bool = false,
        notes: String? = nil
    ) -> Transaction {
        let date = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date()) ?? Date()
        return Transaction(
            id: id,
            amount: amount,
            date: date,
            merchant: merchant,
            category: category,
            isSubscription: isSubscription,
            notes: notes
        )
    }

    static let mock = Transaction.makeMock(
        amount: 23.45,
        daysAgo: 1,
        merchant: "Trader Joe's",
        category: .groceries,
        notes: "Snacks and veggies"
    )

    static let mocks: [Transaction] = [
        .makeMock(amount: 23.45, daysAgo: 1, merchant: "Trader Joe's", category: .groceries, notes: "Snacks and veggies"),
        .makeMock(amount: 12.99, daysAgo: 0, merchant: "Starbucks", category: .dining, notes: "Latte and muffin"),
        .makeMock(amount: 42.10, daysAgo: 3, merchant: "Uber", category: .transport),
        .makeMock(amount: 89.99, daysAgo: 5, merchant: "Amazon", category: .shopping, notes: "Household items"),
        .makeMock(amount: 15.00, daysAgo: 2, merchant: "Netflix", category: .subscriptions, isSubscription: true),
        .makeMock(amount: 65.30, daysAgo: 7, merchant: "PG&E", category: .utilities, notes: "Electric bill"),
        .makeMock(amount: 29.99, daysAgo: 6, merchant: "Apple Music", category: .subscriptions, isSubscription: true),
        .makeMock(amount: 58.75, daysAgo: 4, merchant: "AMC Theatres", category: .entertainment, notes: "Movie night"),
        .makeMock(amount: 120.00, daysAgo: 10, merchant: "Southwest Airlines", category: .travel, notes: "Weekend trip"),
        .makeMock(amount: 34.50, daysAgo: 8, merchant: "CVS Pharmacy", category: .health, notes: "Medicine"),
        .makeMock(amount: 9.99, daysAgo: 9, merchant: "iCloud Storage", category: .subscriptions, isSubscription: true),
        .makeMock(amount: 7.25, daysAgo: 1, merchant: "Parking Meter", category: .transport),
        .makeMock(amount: 19.80, daysAgo: 2, merchant: "Chipotle", category: .dining),
        .makeMock(amount: 210.00, daysAgo: 12, merchant: "Costco", category: .groceries, notes: "Monthly stock-up"),
        .makeMock(amount: 14.29, daysAgo: 11, merchant: "App Store", category: .entertainment, notes: "Game purchase"),
        .makeMock(amount: 49.00, daysAgo: 13, merchant: "Hulu", category: .subscriptions, isSubscription: true),
        .makeMock(amount: 5.49, daysAgo: 0, merchant: "7-Eleven", category: .other, notes: "Bottled water")
    ]
}
