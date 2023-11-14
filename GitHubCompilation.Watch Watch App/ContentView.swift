//
//  ContentView.swift
//  GitHubCompilation.Watch Watch App
//
//  Created by Bryan de Bourbon on 11/12/23.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
  var body: some View {
    VStack {
      Button("Refresh Widget") {
        self.refreshWidgetData()
      }
    }
  }

  private func refreshWidgetData() {
    // Example data fetching and storing
    let fetcher = GitHubDataFetcher()
    fetcher.fetchGitHubData(from: "2023-01-01", to: "2023-12-31", accessToken: "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")
    { result in
      switch result {
      case .success(let response):
        // Encode your ContributionDay array and store it
        let contributionDays = response.data.viewer.contributionsCollection.contributionCalendar
          .weeks.flatMap { $0.contributionDays }
        if let encodedData = try? JSONEncoder().encode(contributionDays) {
          let sharedDefaults = UserDefaults(suiteName: "group.com.bryandebourbon")
          sharedDefaults?.set(encodedData, forKey: "githubContributions")
        }

        // Request widget to update
        WidgetCenter.shared.reloadAllTimelines()

      case .failure(let error):
        // Handle error
        print("Error fetching data: \(error)")
      }
    }
  }
}

#Preview{
  ContentView()
}
