//
//  EntryListView.swift
//  DreamJournal
//
//  Created by Laura Gongaware on 7/6/22.
//

import SwiftUI

struct EntryListView: View {
    
    @State var viewModel = EntryListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section("My Entries") {
                    ForEach(viewModel.entries) { entry in
                    NavigationLink {
                        //Destination
                        DetailView(entry: entry)
                    } label: {
                        //what our navigation link looks like
                        VStack(alignment: .leading, spacing: 12) {
                            Text(entry.title)
                                .bold()
                                .font(.headline)
                            Text(entry.body)
                                .font(.system(size: 14))
                        }.padding()
                    }
                }
            }
        }
            .listStyle(.plain)
            .navigationTitle("Dream Journal")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        DetailView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView()
    }
}
