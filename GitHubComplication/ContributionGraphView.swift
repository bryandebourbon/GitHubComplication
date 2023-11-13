import SwiftUI

struct ContributionGraphView: View {
  private let blockSize: CGFloat = 8
    // Adjust this value as needed for the size of the blocks
  private let padding: CGFloat = 2 // Padding around each block
  private let numberOfRows: Int = 7 // One for each day of the week
  private let maxWidth: CGFloat = 200
    // The approximate width available for a modular large complication
  
  private func colorForContributionCount(_ count: Int) -> Color {
    switch count {
    case 0: return Color.gray.opacity(0.1)
    case 1...3: return Color.green.opacity(0.3)
    case 4...6: return Color.green.opacity(0.6)
    default: return Color.green
    }
  }
  
  // Calculate the number of columns that can fit within maxWidth
  private var numberOfColumns: Int {
    let totalPadding = padding * (CGFloat(numberOfRows) + 1)
    let availableWidth = maxWidth - totalPadding
    let maxColumns = Int(availableWidth / (blockSize + padding))
    return maxColumns
  }
  
  // Generate sample data based on the number of columns and rows
  var contributions: [ContributionDay] {
    (0..<(numberOfRows * numberOfColumns)).map { index in
      ContributionDay(date: "2023-11-\(String(format: "%02d", index + 1))",
                      contributionCount: Int.random(in: 0...6))
    }
  }

  var body: some View {
    VStack(alignment: .leading, spacing: padding) {
      ForEach(0..<numberOfRows, id: \.self) { rowIndex in
        HStack(spacing: padding) {
          ForEach(0..<numberOfColumns, id: \.self) { columnIndex in
            let index = rowIndex + columnIndex * numberOfRows
            Rectangle()
              .fill(colorForContributionCount(contributions[index].contributionCount))
              .frame(width: blockSize, height: blockSize)
              .cornerRadius(2)
          }
        }
      }
    }
    .padding(.all, padding)
    // The frame size dynamically adjusts to the number of columns
    .frame(width: CGFloat(numberOfColumns) * (blockSize + padding) + padding,
           height: CGFloat(numberOfRows) * (blockSize + padding) + padding)
  }
}

#if DEBUG
struct ContributionGraphView_Previews: PreviewProvider {
  static var previews: some View {
    ContributionGraphView()
      .previewLayout(.fixed(width: 155, height: 110)) // Adjust the preview layout to simulate the modular large size
  }
}
#endif

