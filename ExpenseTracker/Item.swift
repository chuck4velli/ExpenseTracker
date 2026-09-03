//
//  Item.swift
//  ExpenseTracker
//
//  Created by Charlie Nguyen on 03/09/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
