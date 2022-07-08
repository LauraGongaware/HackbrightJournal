//
//  EntryListView.swift
//  DreamJournal
//
//  Created by Laura Gongaware on 7/6/22.
//

import SwiftUI

struct EntryListView: View {
    
    @ObservedObject var viewModel = EntryListViewModel()
    
    var body: some View {
        NavigationView {
            
            // DashBoard
            ScrollView {
                JournalDashboard(viewModel: viewModel)
                    .padding(.horizontal)
                    .frame(height: 140)
                //Empty View for no entries
                if viewModel.entries.isEmpty {
                    EmptyJournalTile()
                        .padding(.top)
                    } else {
                
                // List of Entries
                List {
                    Section("My Entries") {
                        ForEach(viewModel.entries) { entry in
                            
                            NavigationLink {
                                // Destination
                                DetailView(entry: entry, entryViewModel: viewModel)
                            } label: {
                                JournalRowView(entry: entry)
                                // What our navigation link looks like
                               .padding()
                                    .frame(maxHeight: 115)
                            }
                        }
                        .onDelete(perform: viewModel.removeEntry(indexSet:))
                    }
                }
                .frame(height: CGFloat(viewModel.entries.count) * 115 + 25)
                .listStyle(.plain)
            }
        }
            .navigationTitle("Dream Journal")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        // Destination
                        DetailView(entryViewModel: viewModel)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                setupViews()
            }
        }
    }
    
    func setupViews() {
        viewModel.loadFromPersistenceStore()
        viewModel.getStreak()
        viewModel.hasJournaledToday()
    }
}

    
struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView()
    }
}

struct EmptyJournalTile: View {
    var body: some View {
        VStack(spacing: 24) {
            Divider()
            ZStack() {
                Rectangle().fill(.ultraThinMaterial)
                Text(EntryListViewModel.emptyMessage)
                    .padding()
                    .font(.system(.caption, design: .monospaced))
                
            }.cornerRadius(12)
            .frame(width: UIScreen.main.bounds.width - 40)
        }
    }
}

    struct JournalRowView: View {
        var entry: Entry
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(entry.title)
                    .bold()
                    .font(.headline)
                Text(entry.body)
                    .font(.system(size: 14))
                    .lineLimit(2)
            }
        }
    }

struct JournalDashboard: View {
    @ObservedObject var viewModel: EntryListViewModel
    var body: some View {
        VStack {
            HStack {
                // DAY STREAK TILE
            DayStreakTile(viewModel: viewModel)
                
                VStack {
                    // TOTAL ENTRIES TILE
                    
                    TotalEntriesTile(viewModel: viewModel)
                    // JOURNALED TODAY TILE
                    JournaledTodayTile(viewModel: viewModel)
                }
            }
        }
    }
}

    struct DayStreakTile: View {
        @ObservedObject var viewModel: EntryListViewModel
        var body: some  View {
            ZStack {
                Rectangle().fill(.ultraThinMaterial)
                VStack {
                    Text(String(viewModel.streak))
                        .font(.title)
                        .bold()
                    Text(viewModel.dayStreakText)
                        .font(.headline)
                }
            }.cornerRadius(12)
        }
    }
struct TotalEntriesTile: View {
    @ObservedObject var viewModel: EntryListViewModel
    var body: some View {
        ZStack {
            Rectangle().fill(.ultraThinMaterial)
            VStack {
                Text(String(viewModel.entries.count))
                    .font(.title3)
                    .bold()
                Text(viewModel.entriesText)
                    .font(.caption)
            }
        }.cornerRadius(12)
    }
}

struct JournaledTodayTile: View {
    @ObservedObject var viewModel: EntryListViewModel
    var body: some View {
        ZStack() {
            Rectangle().fill(.ultraThinMaterial)
            VStack(spacing: 8) {
                Image(systemName: viewModel.hasJournaled ? "checkmark.circle.fill" : "xmark.circle.fill")
                Text(viewModel.journaledTodayText)
                    .font(.caption2)
            }
        }.cornerRadius(12)
    }
}
