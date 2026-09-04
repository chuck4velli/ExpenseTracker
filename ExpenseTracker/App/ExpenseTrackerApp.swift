import SwiftUI
import SwiftData

@main
struct ExpenseTrackerApp: App {

    var body: some Scene {
        WindowGroup {
            RootView()
                .modelContainer(sharedModelContainer)
        }
    }

    private var sharedModelContainer: ModelContainer = {
        let schema = Schema([Transaction.self])
        let config = ModelConfiguration(schema: schema)

        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }()
}
