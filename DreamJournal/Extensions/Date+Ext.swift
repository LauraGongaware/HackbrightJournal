//
//  Date+Ext.swift
//  DreamJournal
//
//  Created by Laura Gongaware on 7/7/22.
//

import Foundation

extension Date {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MM, d")
        return dateFormatter.string(from: self)
    }
}
