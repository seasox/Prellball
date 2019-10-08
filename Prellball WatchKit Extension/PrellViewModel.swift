//
//  PrellModel.swift
//  Prellball WatchKit Extension
//
//  Created by jb on 07.10.19.
//  Copyright © 2019 FIZON GmbH. All rights reserved.
//

import Foundation
import AVFoundation

enum Competitor {
    case home
    case visitor
}

struct PrellViewModel {

    private var competitors: [Competitor: Int] = [.home: 0, .visitor: 0] {
        didSet {
            read()
        }
    }

    func value(for competitor: Competitor) -> String {
        return "\(_value(for: competitor))"
    }

    private func _value(for competitor: Competitor) -> Int {
        return competitors[competitor] ?? 0
    }

    mutating func increment(for competitor: Competitor) {
        guard let old = competitors[competitor] else {
            competitors[competitor] = 1
            return
        }
        competitors[competitor] = old + 1
    }
    mutating func decrement(for competitor: Competitor) {
        guard let old = competitors[competitor], old > 0 else {
            return
        }
        competitors[competitor] = old - 1
    }
    mutating func reset() {
        competitors = [.home: 0, .visitor: 0]
    }

    func read() {
        let synthesizer = AVSpeechSynthesizer()
        let home = _value(for: .home)
        let visitor = _value(for: .visitor)

        let text = "\(home) zu \(visitor)"
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.2
        utterance.voice = AVSpeechSynthesisVoice(language: "de-DE")
        synthesizer.speak(utterance)
        print(utterance.speechString)
    }
}
