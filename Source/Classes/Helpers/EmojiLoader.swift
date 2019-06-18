//
//  EmojiLoader.swift
//  ISEmojiView
//
//  Created by Beniamin Sarkisyan on 01/08/2018.
//

import Foundation

final public class EmojiLoader {
    
    static func recentEmojiCategory() -> EmojiCategory {
        return EmojiCategory(
            category: .recents,
            emojis: RecentEmojisManager.sharedInstance.recentEmojis()
        )
    }
    
    static func emojiCategories() -> [EmojiCategory] {
        var emojiPListFileName = "ISEmojiList_iOS10"
        if #available(iOS 11.0, *) { emojiPListFileName = "ISEmojiList_iOS11" }
        if #available(iOS 12.1, *) { emojiPListFileName = "ISEmojiList" }
        
        guard let filePath = Bundle.podBundle.path(forResource: emojiPListFileName, ofType: "plist") else {
            return []
        }
        
        guard let categories = NSArray(contentsOfFile: filePath) as? [[String:Any]] else {
            return []
        }
        
        var emojiCategories = [EmojiCategory]()
        
        let availableCategories: [Category] = [
            .smileysAndPeople, .animalsAndNature, .foodAndDrink,
            .activity, .travelAndPlaces, .objects, .symbols, .flags
        ]
        
        for dictionary in categories {
            guard let title = dictionary["title"] as? String else {
                continue
            }
            
            guard let category = availableCategories.first(where: { $0.title == title }) else {
                continue
            }
            
            guard let rawEmojis = dictionary["emojis"] as? [[String: Any]] else {
                continue
            }
            
            var emojis = [Emoji]()
            
            for value in rawEmojis {
                guard
                    let emojisArray = value["emoji"] as? [String],
                    let keywords = value["keywords"] as? String,
                    let seq = value["sequence"] as? String,
                    let tts = value["tts"] as? String
                    else { continue }
                emojis.append(Emoji(emojis: emojisArray, keywords: keywords, sequence: seq, tts: tts))
            }
            
            let emojiCategory = EmojiCategory(category: category, emojis: emojis)
            emojiCategories.append(emojiCategory)
        }
        
        return emojiCategories
    }
    
    static func emojis() -> [Emoji] {
        var emojiPListFileName = "ISEmojiList_iOS10"
        if #available(iOS 11.0, *) { emojiPListFileName = "ISEmojiList_iOS11" }
        if #available(iOS 12.1, *) { emojiPListFileName = "ISEmojiList" }
        
        guard let filePath = Bundle.podBundle.path(forResource: emojiPListFileName, ofType: "plist") else {
            return []
        }
        
        guard let categories = NSArray(contentsOfFile: filePath) as? [[String:Any]] else {
            return []
        }
        
        var allEmojis = [Emoji]()
        
        for dictionary in categories {
            guard let rawEmojis = dictionary["emojis"] as? [[String: Any]] else {
                continue
            }
            
            var emojis = [Emoji]()
            
            for value in rawEmojis {
                guard
                    let emojisArray = value["emoji"] as? [String],
                    let keywords = value["keywords"] as? String,
                    let seq = value["sequence"] as? String,
                    let tts = value["tts"] as? String
                    else { continue }
                emojis.append(Emoji(emojis: emojisArray, keywords: keywords, sequence: seq, tts: tts))
            }
            allEmojis.append(contentsOf: emojis)
        }
        return allEmojis
    }
    
}
