//
//  GitHubComplicationApp.swift
//  GitHubComplication
//
//  Created by Bryan de Bourbon on 11/11/23.
//

import SwiftUI
import WidgetKit

@main
struct GitHubComplicationApp: App {
  var body: some Scene {
    WindowGroup {
      VStack {
        ContributionGraphView()
        Button("Refresh Widget") {
          refreshWidgetData()
        }
      }
    }
  }
}
