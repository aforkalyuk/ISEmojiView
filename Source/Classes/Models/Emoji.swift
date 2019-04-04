//
//  Emoji.swift
//  ISEmojiView
//
//  Created by Beniamin Sarkisyan on 03/08/2018.
//

import Foundation

public class Emoji: Codable, Hashable {
    
    // MARK: - Hashable
    
    public static func == (lhs: Emoji, rhs: Emoji) -> Bool {
        return lhs.emoji == rhs.emoji
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(emoji)
    }
    
    // MARK: - Public variables
    
    public internal(set) var selectedEmoji: String?
    public var emoji: String {
        return emojis[0]
    }

    var emojis: [String]!
    public internal(set) var keywords: String!
    public internal(set) var sequence: String!
    public internal(set) var tts: String!
    
    // MARK: - Initial functions
    
    public init(emojis: [String], keywords: String = "", sequence: String = "", tts: String = "") {
        self.emojis = emojis
        self.keywords = keywords
        self.sequence = sequence
        self.tts = tts
    }
    
    // MARK: - Codable
    
    private enum CodingKeys: String, CodingKey {
        case selectedEmoji, emojis, keywords, sequence, tts
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        selectedEmoji = try values.decode(String.self, forKey: .selectedEmoji)
        emojis = try values.decodeIfPresent([String].self, forKey: .emojis)
        keywords = try values.decodeIfPresent(String.self, forKey: .keywords) ?? ""
        sequence = try values.decodeIfPresent(String.self, forKey: .sequence) ?? ""
        tts = try values.decodeIfPresent(String.self, forKey: .tts) ?? ""
    }
    
    public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(selectedEmoji, forKey: .selectedEmoji)
        try values.encode(emojis, forKey: .emojis)
        try values.encode(keywords, forKey: .keywords)
        try values.encode(sequence, forKey: .sequence)
        try values.encode(tts, forKey: .tts)
    }
    
}

