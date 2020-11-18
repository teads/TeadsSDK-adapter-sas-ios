//
//  TeadsSASAdapterHelper.swift
//  TeadsSASAdapter
//
//  Created by Jérémy Grosjean on 06/11/2020.
//

import UIKit
import TeadsSDK

@objc public class TeadsSASAdapterHelper: NSObject {

    @objc public static func teadsAdSettingsToString(adSettings: TeadsAdSettings) -> String? {
        
        if let data = try? JSONEncoder().encode(adSettings), let adSettingsString = String(data: data, encoding: .utf8) {
            return "teadsAdSettingsKey=\(adSettingsString)".addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)
        }
        return nil
    }
    
    @objc public static func concatAdSettingsToKeywords(keywordsStrings: String, adSettings: TeadsAdSettings) -> String {
        if let adSettingsStrings = teadsAdSettingsToString(adSettings: adSettings) {
            return "\(keywordsStrings);\(adSettingsStrings)"
        }
        return keywordsStrings
    }
    
    static func stringToAdSettings(adSettingsString: String?) -> TeadsAdSettings? {
        if let adSettingsString = adSettingsString?.removingPercentEncoding?.data(using: .utf8) {
        return try? JSONDecoder().decode(TeadsAdSettings.self, from: adSettingsString)
        }
        return nil
    }
    
}
