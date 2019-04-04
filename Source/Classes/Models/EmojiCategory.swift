//
//  EmojiCategory.swift
//  ISEmojiView
//
//  Created by Beniamin Sarkisyan on 01/08/2018.
//

import Foundation

public class EmojiCategory {
    
    // MARK: - Public variables
    
    var category: Category!
    public var emojis: [Emoji]!
    
    // MARK: - Initial functions
    
    public init(category: Category, emojis: [Emoji]) {
        self.category = category
        self.emojis = emojis
    }
    
    // MARK: - Public
    
    public func emojis(with keyword: String) -> [Emoji] {
        return emojis.filter { $0.keywords.range(of: keyword, options: [.caseInsensitive]) != nil }
    }
}
