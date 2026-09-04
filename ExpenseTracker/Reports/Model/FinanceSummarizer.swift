import Foundation
import FoundationModels

struct FinanceSummarizer {
    let session = LanguageModelSession {
        """
        You are a finance advisor.
        You will receive input data about a users finacial transactions and are tasked with generating a financial summary.
        Here is an example input: \(FinanceSummaryInput.mockThisWeek)
        Here is an example output: \(FinanceSummaryOutput.mock)
        """
    }

    func summarize(input: FinanceSummaryInput) async throws -> FinanceSummaryOutput {
        let prompt = """
        Analyze the following weekly financial data and produce a structured summary.

        Requirements:
        - Provide a brief, friendly 2–3 sentence overview summarizing overall spending behavior.
        - Identify 3–5 key insights highlighting notable spending trends, top categories, or high-value merchants.
        - Offer 2–3 specific, practical recommendations to help save money based on this week's data.

        Data Context:
        - Total Spent: \(input.totalSpent.formatted(.currency(code: "GBP")))
        - Date Range: \(input.startDate.formatted(date: .abbreviated, time: .omitted)) – \(input.endDate.formatted(date: .abbreviated, time: .omitted))
        - Category Breakdown: \(input.totalsByCategory.map { "\($0.key.displayName): \($0.value.formatted(.currency(code: "GBP")))" }.joined(separator: ", "))
        - Flagged Categories: \(input.flaggedCategories.map { "\($0.key.displayName): \($0.value.formatted(.currency(code: "GBP")))" }.joined(separator: ", "))
        - Top Merchants: \(input.topMerchants.map { "\($0.key): \($0.value.formatted(.currency(code: "GBP")))" }.joined(separator: ", "))
        """

        let output = try await session.respond(to: prompt, generating:  FinanceSummaryOutput.self)
        return output.content
    }
}
