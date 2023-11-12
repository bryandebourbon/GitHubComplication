import SwiftUI

struct ContributionGraphView: View {
  let contributions: [ContributionDay]

  private func colorForContributionCount(_ count: Int) -> Color {
    switch count {
    case 0: return Color.gray.opacity(0.1)
    case 1...3: return Color.green.opacity(0.3)
    case 4...6: return Color.green.opacity(0.6)
    default: return Color.green
    }
  }

  var body: some View {
    // Assuming a max of 7 days in a week for simplicity
    VStack(alignment: .leading) {
      ForEach(0..<contributions.count / 7, id: \.self) { weekIndex in
        HStack {
          ForEach(0..<7, id: \.self) { dayIndex in
            Rectangle()
              .fill(
                self.colorForContributionCount(
                  self.contributions[weekIndex * 7 + dayIndex].contributionCount)
              )
              .frame(width: 20, height: 20)
          }
        }
      }
    }
  }
}

#if DEBUG
  struct ContributionGraphView_Previews: PreviewProvider {
    static var previews: some View {
      // Create sample data for the preview
      let sampleContributions = [
        ContributionDay(date: "2023-11-01", contributionCount: 3),
        ContributionDay(date: "2023-11-02", contributionCount: 2),
        ContributionDay(date: "2023-11-03", contributionCount: 1),
        ContributionDay(date: "2023-11-04", contributionCount: 0),
        ContributionDay(date: "2023-11-05", contributionCount: 4),
        ContributionDay(date: "2023-11-06", contributionCount: 2),
        ContributionDay(date: "2023-11-07", contributionCount: 0),
        // ... Add as many days as needed for the preview
      ]

      ContributionGraphView(contributions: sampleContributions)
        .previewLayout(.sizeThatFits)
        .padding()
    }
  }
#endif
