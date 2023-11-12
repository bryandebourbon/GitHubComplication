import Foundation

struct GitHubQueryResponse: Codable {
  let data: ViewerData
}

struct ViewerData: Codable {
  let viewer: Viewer
}

struct Viewer: Codable {
  let contributionsCollection: ContributionsCollection
}

struct ContributionsCollection: Codable {
  let contributionCalendar: ContributionCalendar
}

struct ContributionCalendar: Codable {
  let totalContributions: Int
  let weeks: [Week]
}

struct Week: Codable {
  let contributionDays: [ContributionDay]
}

struct ContributionDay: Codable {
  let date: String
  let contributionCount: Int
}
