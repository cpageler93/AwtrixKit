import XCTest
@testable import AwtrixKit

final class AwtrixKitTests: XCTestCase {
    func testExample() async throws {
        let client = AwtrixClient(address: "192.168.178.91")!
//        let stats = try await client.stats()
//        XCTAssertNotNil(stats)

//        let loop = try await client.loop()
//        print("Loop: \(loop)")

        try await client.power(on: true)

//        try await client.sleep(seconds: 2)

//        try await client.indicator(position: .bottomRight, color: UIColor.clear)

        try await client.updateApp(name: "app1", request: .init(text: "Hello World"))

    }
}
