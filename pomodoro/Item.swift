//
//  Item.swift
//  pomodoro
//
//  Created by Ali Siddique on 19/01/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var name:String
    
    init(timestamp: Date) {
        self.timestamp = timestamp
        self.name = "ali"
    }
}
