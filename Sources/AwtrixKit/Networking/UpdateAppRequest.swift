//
//  UpdateAppRequest.swift
//  AwtrixKit
//
//  Created by Christoph Pageler on 25.05.24.
//

import Foundation

public struct UpdateAppRequest: Encodable {
    public let text: String?
    public let textCase: TextCase?
    public let topText: Bool?
    public let textOffset: Int?
    public let center: Bool?
    public let color: String?
    // gradient
    // blinkText
    // fadeText
    // background
    public let rainbow: Bool?
    public let icon: String?
    public let pushIcon: PushIcon?
    // repeat
    // duration
    // hold
    // sound
    // rtttl
    // loopSound
    // bar
    // line
    // autoscale
    // progress
    // progressC
    // progressBC
    // pos
    // draw
    // lifetime
    // lifetimeMode
    // stack
    // wakeup
    // noScroll
    // clients
    // scrollSpeed
    // effect
    // effectSettings
    // save
    // overlay

    public init(
        text: String? = nil,
        textCase: TextCase? = nil,
        topText: Bool? = nil,
        textOffset: Int? = nil,
        center: Bool? = nil,
        color: AwtrixColorConvertable? = nil,
        rainbow: Bool? = nil,
        icon: String? = nil,
        pushIcon: PushIcon? = nil
    ) {
        self.text = text
        self.textCase = textCase
        self.topText = topText
        self.textOffset = textOffset
        self.center = center
        self.color = color?.awtrixColorCode
        self.rainbow = rainbow
        self.icon = icon
        self.pushIcon = pushIcon
    }

    public enum TextCase: Int, Encodable {
        case globalSettings = 0
        case uppercase = 1
        case asSent = 2
    }

    public enum PushIcon: Int, Encodable {
        case dontMove = 0
        case moveWithTextAndHide = 1
        case moveWithTextAndShowAgain = 2
    }
}
