import XCTest
@testable import GitHubComplication // Replace with your app's module name

class GitHubDataFetcherTests: XCTestCase {

    var dataFetcher: GitHubDataFetcher!
    var validToken: String!

    override func setUp() {
        super.setUp()
        dataFetcher = GitHubDataFetcher()
        validToken = "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" // Replace with a valid token for testing
    }

    override func tearDown() {
        dataFetcher = nil
        validToken = nil
        super.tearDown()
    }

    func testFetchGitHubData() {
        let expectation = self.expectation(description: "FetchGitHubData")

        let fromDate = "2023-11-01T00:00:00Z"
        let toDate = "2023-11-30T23:59:59Z"

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
    }
}
