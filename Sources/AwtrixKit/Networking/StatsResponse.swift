//
//  StatsResponse.swift
//  AwtrixKit
//
//  Created by Christoph Pageler on 25.05.24.
//

import Foundation

public struct StatsResponse: Decodable {
    public let battery: Int
    public let batteryRaw: Int
    public let type: Int
    public let lux: Int
    public let ldrRaw: Int
    public let ram: Int
    public let brightness: Int
    public let temperature: Int
    public let humidity: Int
    public let uptime: Int
    public let wifiSignal: Int
    public let messages: Int
    public let version: String
    public let indicator1: Bool
    public let indicator2: Bool
    public let indicator3: Bool
    public let app: String
    public let uid: String
    public let matrix: Bool
    public let ipAddress: String

    enum CodingKeys: String, CodingKey {
        case battery = "bat"
        case batteryRaw = "bat_raw"
        case type
        case lux
        case ldrRaw = "ldr_raw"
        case ram
        case brightness = "bri"
        case temperature = "temp"
        case humidity = "hum"
        case uptime
        case wifiSignal = "wifi_signal"
        case messages
        case version
        case indicator1
        case indicator2
        case indicator3
        case app
        case uid
        case matrix
        case ipAddress = "ip_address"
    }
}
