//
//  GitHubCompilation_WatchApp.swift
//  GitHubCompilation.Watch Watch App
//
//  Created by Bryan de Bourbon on 11/12/23.
//

import SwiftUI
import WidgetKit

@main
struct GitHubCompilation_Watch_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
  var body: some View {
    VStack {
      ContributionGraphView()
      Button("Refresh Widget") {
        refreshWidgetData()
      }
    }
  }
}

#Preview{
  ContentView()
}
