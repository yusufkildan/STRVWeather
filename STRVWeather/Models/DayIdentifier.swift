//
//  DayIdentifier.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import Foundation

class DayIdentifier: Hashable, Equatable, Comparable {
    let year: Int
    let month: Int
    let day: Int

    var rawValue: Int {
        return year * 10000 + month * 100 + day
    }
    
    // MARK: - Constructors
    
    init(year: Int, month: Int, day: Int) {
        self.year  = year
        self.month = month
        self.day   = day
    }
    
    // MARK: - Date
    
    static func fromComponents(components: DateComponents) -> DayIdentifier {
        return DayIdentifier(year: components.year!, month: components.month!, day: components.day!)
    }
    
    func dateComponents() -> DateComponents {
        var component = DateComponents()
        
        component.year = year
        component.month = month
        component.day = day
        
        return component
    }
    
    func date() -> Date? {
        return Calendar.current.date(from: dateComponents())
    }
    
    // MARK: - Hashable
    
    var hashValue: Int {
        return rawValue
    }
}

// MARK: - Equatable

func ==(lhs: DayIdentifier, rhs: DayIdentifier) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

// MARK: - Comparable

func <(lhs: DayIdentifier, rhs: DayIdentifier) -> Bool {
    return lhs.rawValue < rhs.rawValue
}

func >(lhs: DayIdentifier, rhs: DayIdentifier) -> Bool {
    return lhs.rawValue > rhs.rawValue
}

func <=(lhs: DayIdentifier, rhs: DayIdentifier) -> Bool {
    return lhs.rawValue <= rhs.rawValue
}

func >=(lhs: DayIdentifier, rhs: DayIdentifier) -> Bool {
    return lhs.rawValue >= rhs.rawValue
}
