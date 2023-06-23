//
//  Constants.swift
//  PlayMusicApp
//
//  Created by Даниил Циркунов on 22.06.2023.
//

import UIKit

enum Constants {
    static let dynamicTextColor = UIColor { (traitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor.white
        } else {
            return UIColor.black
        }
    }
    
    enum Spacing {
        static let standart = 16
        static let little = 6
        static let big = 50
    }
    
    enum Font {
        static let body = UIFont.preferredFont(forTextStyle: .body)
    }
    
    enum Color {
        static let background = UIColor.systemBackground
    }
}
