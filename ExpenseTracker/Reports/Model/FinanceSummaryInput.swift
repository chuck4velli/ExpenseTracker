import Foundation

struct FinanceSummaryInput {
    let startDate: Date
    let endDate: Date
    let totalSpent: Double
    let totalsByCategory: [Transaction.Category: Double]
    let flaggedCategories: [Transaction.Category: Double]
    let topMerchants: [String: Double]

    init(
        startDate: Date,
        endDate: Date,
        totalSpent: Double,
        totalsByCategory: [Transaction.Category: Double],
        flaggedCategories: [Transaction.Category: Double],
        topMerchants: [String : Double]
    ) {
        self.startDate = startDate
        self.endDate = endDate
        self.totalSpent = totalSpent
        self.totalsByCategory = totalsByCategory
        self.flaggedCategories = flaggedCategories
        self.topMerchants = topMerchants
    }

    init(from transactions: [Transaction]) {
        var categoryTotals: [Transaction.Category: Double] = [:]
        var merchantTotals: [String: Double] = [:]
        var spentAccumulator: Double = 0

        if let minDate = transactions.map({ $0.date }).min(), let maxDate = transactions.map({ $0.date }).max() {
            self.startDate = minDate
            self.endDate = maxDate
        } else {
            let now = Date()
            self.startDate = now
            self.endDate = now
        }

        for transaction in transactions {
            let amount = transaction.amount

            spentAccumulator += amount
            categoryTotals[transaction.category, default: 0] += amount

            let merchant = transaction.merchant
            merchantTotals[merchant, default: 0] += amount
        }

        self.totalSpent = spentAccumulator
        self.totalsByCategory = categoryTotals
        self.topMerchants = merchantTotals

        let categoryValues = Array(categoryTotals.values)
        let average = (categoryValues.reduce(0, +) / Double(categoryValues.count))

        self.flaggedCategories = categoryTotals.filter { $0.value > average }
    }
}

extension FinanceSummaryInput {
    static var mockThisWeek: FinanceSummaryInput {
        let calendar = Calendar.current
        let now = Date()

        let startDate = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)) ?? now
        let endDate = calendar.date(byAdding: .day, value: 6, to: startDate) ?? now

        return FinanceSummaryInput(
            startDate: startDate,
            endDate: endDate,
            totalSpent: 845.20,
            totalsByCategory: [
                .groceries: 154.30,
                .dining: 92.50,
                .transport: 42.10,
                .shopping: 129.99,
                .utilities: 210.00,
                .entertainment: 65.00,
                .subscriptions: 27.98,
                .health: 34.50,
                .travel: 88.83
            ],
            flaggedCategories: [
                .utilities: 210.00,
                .shopping: 129.99
            ],
            topMerchants: [
                "PG&E": 210.00,
                "Trader Joe's": 154.30,
                "Amazon": 129.99,
                "Chipotle": 45.20,
                "Uber": 42.10
            ]
        )
    }
}
