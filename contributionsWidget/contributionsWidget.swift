//
//  contributionsWidget.swift
//  contributionsWidget
//
//  Created by Bryan de Bourbon on 11/12/23.
//

import SwiftUI
import WidgetKit

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), contributions: sampleContributions())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(),  contributions: sampleContributions())
    }



  func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<
    SimpleEntry
  > {
    var entries: [SimpleEntry] = []

    // Fetch updated data from shared UserDefaults
    if let sharedDefaults = UserDefaults(suiteName: "group.com.bryandebourbon.contributions"),
      let encodedData = sharedDefaults.data(forKey: "githubContributions"),
      let contributionDays = try? JSONDecoder().decode([ContributionDay].self, from: encodedData)
    {

      // Create a single entry with the latest data
      let entry = SimpleEntry(
        date: Date(),  contributions: contributionDays)
      entries.append(entry)
    } else {
      // Handle the case where there is no data or an error in fetching data
      // This can be an empty view or some placeholder
      let entry = SimpleEntry(date: Date(),  contributions: [])
      entries.append(entry)
    }

    // Since your data might not change frequently, using a policy like .atEnd is suitable.
    // This will refresh the widget at the end of the timeline which is defined by the single entry.
    return Timeline(entries: entries, policy: .atEnd)
  }

  func recommendations() -> [AppIntentRecommendation<ConfigurationAppIntent>] {
    // Create an array with all the preconfigured widgets to show.
    [AppIntentRecommendation(intent: ConfigurationAppIntent(), description: "Example Widget")]
  }
}

private func sampleContributions() -> [ContributionDay] {
    // Sample data
    return [
        ContributionDay(date: "2023-11-01", contributionCount: 3),
        ContributionDay(date: "2023-11-02", contributionCount: 1),
        ContributionDay(date: "2023-11-03", contributionCount: 3),
        // Add more samples as needed
    ]
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let contributions: [ContributionDay]
}


struct contributionsWidgetEntryView: View {
  var entry: Provider.Entry

  var body: some View {
    VStack {
      ContributionGraphView()
    }
  }
}

@main
struct contributionsWidget: Widget {
  let kind: String = "contributionsWidget"

  var body: some WidgetConfiguration {
    AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) {
      entry in
      contributionsWidgetEntryView(entry: entry)
        .containerBackground(.fill.tertiary, for: .widget)
    }
  }
}



#Preview(as: .accessoryRectangular){
  contributionsWidget()
} timeline: {
  SimpleEntry(date: .now,  contributions: sampleContributions())
  SimpleEntry(date: .now,  contributions: sampleContributions())
}
