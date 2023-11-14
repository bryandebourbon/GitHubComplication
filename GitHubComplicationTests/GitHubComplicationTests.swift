import XCTest

@testable import GitHubComplication  // Replace with your app's module name

class GitHubDataFetcherTests: XCTestCase {

  var dataFetcher: GitHubDataFetcher!
  var validToken: String!

  override func setUp() {
    super.setUp()
    dataFetcher = GitHubDataFetcher()
    validToken = "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"  // Replace with a valid token for testing
  }

  override func tearDown() {
    dataFetcher = nil
    validToken = nil
    super.tearDown()
  }

  func testFetchGitHubData() {
    let expectation = self.expectation(description: "FetchGitHubData")

    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [
      .withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime,
    ]

    let fromDateStr = "2023-11-01T00:00:00Z"
    let toDateStr = "2023-11-30T23:59:59Z"

    if let fromDate = dateFormatter.date(from: fromDateStr),
      let toDate = dateFormatter.date(from: toDateStr)
    {
      dataFetcher.fetchGitHubData(from: fromDate, to: toDate, accessToken: validToken) { result in
        // Handle the result
      }

      dataFetcher.fetchGitHubData(from: fromDate, to: toDate, accessToken: validToken) { result in
        switch result {
        case .success(let response):
          print(response)
          // Add your assertions here
          // e.g., XCTAssertNotNil(response), etc.
          break
        case .failure(let error):
          XCTFail("Error fetching data: \(error.localizedDescription)")
        }

        expectation.fulfill()
      }

      waitForExpectations(timeout: 10, handler: nil)
    } else {
      print("Invalid date format")
    }
  }
}
