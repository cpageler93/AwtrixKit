# AwtrixKit

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

`AwtrixKit` is a Swift package that allows you to control the `Ulanzi TC001` pixel clock. With this library, you can easily access and control the functions of the Ulanzi TC001 from your Swift project.

## Installation

### Swift Package Manager

Add `AwtrixKit` to your project by including it in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/cpageler93/AwtrixKit.git", from: "1.0.0")
]
```

Or use Xcode:

1. Open your project in Xcode.
2. Go to `File > Swift Packages > Add Package Dependency...`
3. Enter the URL to this repository: `https://github.com/cpageler93/AwtrixKit.git`
4. Follow the instructions to add the dependency.

## Usage

Import `AwtrixKit` in the file where you want to control the Ulanzi TC001:

```swift
import AwtrixKit
```

Connect to the Ulanzi TC001 and display a message:

```swift
let client = AwtrixClient(address: "192.168.178.91")!
try await client.updateApp(name: "app1", request: .init(text: "Hello World"))
```

## Contributions

Contributions are welcome! Please fork this repository and open a pull request with your changes. Be sure to follow the existing guidelines and the code of conduct.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Acknowledgements

Thank you to everyone who has contributed to this project and to the Swift community for their support.