//
//  LanguageEnum.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/10.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import Foundation

enum LanguageKey: String {
    case English = "en"
    case Chinese = "zh-Hans"
    case Japanese = "ja"
}

extension LanguageKey: CaseIterable  {
    static func getKeyList() -> [LanguageKey] {
        return LanguageKey.allCases
    }
    
    static func getCodeNames(startWith language: LanguageKey) -> [String] {
        var languages = getKeyList()
        let index = languages.firstIndex(of: language)!
        languages.swapAt(0, index)
        return languages.map { lang -> String in
            return lang.rawValue
        }
    }
    
    static func systemLanguage() -> LanguageKey? {
        for key in getKeyList() {
            if key.isSystemLanguage() {
                return key
            }
        }
        return nil
    }
    
    func isSystemLanguage() -> Bool {
        let systemLanguage: String = (UserDefaults.standard.object(forKey: "AppleLanguages") as! NSArray).firstObject as! String
        return systemLanguage.hasPrefix(self.rawValue)
    }
    
    func getName() -> String {
        switch self {
        case .English:
            return "English"
        case .Chinese:
            return "简体中文"
        case .Japanese:
            return "日本語"
        }
    }
}
