//
//  EntryListViewModel.swift
//  DreamJournal
//
//  Created by Laura Gongaware on 7/6/22.
//

import Foundation

class EntryListViewModel: ObservableObject {
    
    // SOT
    // All changes to our SOT will be PUBLISHED to the view that is listening.
    // If we add an entry, that change will be published, etc.
    @Published var entries: [Entry] = []
    @Published var streak: Int = 0
    @Published var hasJournaled: Bool = false
    
//    [
//     Entry(title: "This is a test", body: "This is where I will write all the details of my dreams"),
//     Entry(title: "This is test 2", body: "This is where I will write all the details of my dreams"),
//     Entry(title: "This is test 3", body: "This is where I will write all the details of my dreams"),
//     Entry(title: "This is test 4", body: "This is where I will write all the details of my dreams"),
//    ]
    
    // func(keyword for function) functionName(argumentLabels: Parameters) -> Return Type { Body }
    //MARK Magic Strings
    
    let dayStreakText = "DAY STREAK"
    let entriesText = "ENTRIES"
    let journaledTodayText = "JOURNALED TODAY"
    static let emptyMessage = "You have not written any entries yet, tap the +  in the upper right corner to begin recording your dreams."
    
    // MARK: - CRUD
    func createEntry(_ entry: Entry) {
        entries.append(entry)
        // Save
        saveToPersistenceStore()
    }
    
    func update(_ entry: Entry, _ title: String, _ body: String) {
        // Find the entry that we want to update
        guard let index = entries.firstIndex(of: entry) else { return }
        // Update it
        entries[index].title = title
        entries[index].body = body
        // Save
        saveToPersistenceStore()
    }
    
    func removeEntry(indexSet: IndexSet) {
        entries.remove(atOffsets: indexSet)
        saveToPersistenceStore()
    }
    
    // MARK: - DASHBOARD
    
    // Calculate current streak
    func getStreak() {
        var localStreak: Int = 0
        var previousEntry: Entry?
        
        // Loop through entries
        for entry in entries {
            // Make sure we have a previous entry
            guard let previousEntryDate = previousEntry?.date else {
                localStreak += 1
                previousEntry = entry
                continue
            }
            // Next compare entry 1 and entry 2
            let components = Calendar.current.dateComponents([.hour], from: previousEntryDate, to: entry.date)
            let hours = components.hour
            if let hours = hours, hours <= 24 {
                
                if Calendar.current.isDate(previousEntryDate, inSameDayAs: entry.date) {
                    continue
                } else {
                    localStreak += 1
                }
            } else {
                return self.streak = localStreak
            }
            previousEntry = entry
        }
        self.streak = localStreak
    }
    
    func hasJournaledToday() {
        let today = Date()
        for entry in entries {
            if Calendar.current.isDate(today, inSameDayAs: entry.date) {
                self.hasJournaled = true
                return
            } else {
                continue
            }
        }
        self.hasJournaled = false
    }
    
    
    
    
    //MARK: -- Date Persistence
    // Create a place to store our data, save the data, load the data

    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("entries")
        return fileURL
    }

    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to:createPersistenceStore())
            
        } catch {
            print("Error encoding.")
        }
        
    }
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            entries = try JSONDecoder().decode([Entry].self, from: data)
        }
        catch {
            print("Error decoding")
        }
    }
}
