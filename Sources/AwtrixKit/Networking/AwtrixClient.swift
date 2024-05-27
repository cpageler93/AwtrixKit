//
//  AwtrixClient.swift
//  AwtrixKit
//
//  Created by Christoph Pageler on 25.05.24.
//

import Foundation

public struct AwtrixClient {
    private let baseURL: URL

    public init?(address: String) {
        guard let url = URL(string: "http://\(address)/api") else { return nil }
        self.baseURL = url
    }

    public func stats() async throws -> StatsResponse {
        try await request(method: "GET", path: "/stats")
    }

    public func loop() async throws -> [String] {
        let loopResponse: [String: Int] = try await request(method: "GET", path: "/loop")
        return loopResponse
            .map { ($0.value, $0.key) }
            .sorted(by: { $0.0 < $1.0 })
            .map { $0.1 }
    }

    public func power(on: Bool) async throws {
        struct Request: Encodable {
            let power: Bool
        }

        _ = try await request(method: "POST", path: "/power", encodableBody: Request(power: on))
    }

    public func sleep(seconds: Int) async throws {
        struct Request: Encodable {
            let sleep: Int
        }

        _ = try await request(method: "POST", path: "/sleep", encodableBody: Request(sleep: seconds))
    }

    public func indicator(position: IndicatorPosition, color: AwtrixColorConvertable) async throws {
        struct Request: Encodable {
            let color: String
        }

        _ = try await request(
            method: "POST",
            path: "/\(position.path)",
            encodableBody: Request(color: color.awtrixColorCode)
        )
    }

    public func switchApp(_ switchApp: SwitchApp) async throws {
        switch switchApp {
        case .next:
            _ = try await request(method: "POST", path: "/nextapp")
        case .previous:
            _ = try await request(method: "POST", path: "/previousapp")
        case let .specific(name):
            struct Request: Encodable {
                let name: String
            }

            _ = try await request(
                method: "POST",
                path: "/switch",
                encodableBody: Request(name: name)
            )
        }
    }

    public func updateApp(name: String, request updateAppRequest: UpdateAppRequest) async throws {
        _ = try await request(
            method: "POST",
            path: "/custom",
            encodableBody: updateAppRequest,
            queryItems: [.init(name: "name", value: name)]
        )
    }

    public func deleteApp(name: String) async throws {
        _ = try await request(
            method: "POST",
            path: "/custom",
            encodableBody: UpdateAppRequest(),
            queryItems: [.init(name: "name", value: name)]
        )
    }
}

internal extension AwtrixClient {
    func request<B: Encodable, T: Decodable>(
        method: String,
        path: String,
        header: [String: String] = [:],
        encodableBody: B,
        queryItems: [URLQueryItem]? = nil
    ) async throws -> T {
        let data = try JSONEncoder().encode(encodableBody)
        var header = header
        header["Content-Type"] = "application/json"
        return try await request(
            method: method,
            path: path,
            header: header,
            body: data,
            queryItems: queryItems
        )
    }

    func request<B: Encodable>(
        method: String,
        path: String,
        header: [String: String] = [:],
        encodableBody: B,
        queryItems: [URLQueryItem]? = nil
    ) async throws -> Data {
        let data = try JSONEncoder().encode(encodableBody)
        var header = header
        header["Content-Type"] = "application/json"
        return try await request(
            method: method,
            path: path,
            header: header,
            body: data,
            queryItems: queryItems
        )
    }

    func request<T: Decodable>(
        method: String,
        path: String,
        header: [String: String] = [:],
        body: Data? = nil,
        queryItems: [URLQueryItem]? = nil
    ) async throws -> T {
        let data = try await request(method: method, path: path, header: header, body: body, queryItems: queryItems)
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }

    @discardableResult
    func request(
        method: String,
        path: String,
        header: [String: String] = [:],
        body: Data? = nil,
        queryItems: [URLQueryItem]? = nil
    ) async throws -> Data {
        let url = baseURL.appendingPathComponent(path)

        // Build URL Components
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw AwtrixClientError.invalidURL
        }
        components.queryItems = queryItems
        guard let urlFromComponents = components.url else { throw AwtrixClientError.invalidURL }

        // Build URL request
        var urlRequest = URLRequest(url: urlFromComponents)
        urlRequest.httpMethod = method
        urlRequest.httpBody = body
        for (key, value) in header {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else { throw AwtrixClientError.invalidResponse }
        switch httpResponse.statusCode {
        case 200...299:
            return data
        default:
            throw AwtrixClientError.invalidStatusCode(httpResponse.statusCode)
        }
    }
}

public enum AwtrixClientError: Error {
    case invalidResponse
    case invalidStatusCode(_ statusCode: Int)
    case invalidURL
}
