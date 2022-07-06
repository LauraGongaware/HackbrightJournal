//
//  EntryListView.swift
//  DreamJournal
//
//  Created by Laura Gongaware on 7/6/22.
//

import SwiftUI

struct EntryListView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(Range(1..<5) { item in
                    VStack {
                        Text("This is my Title")
                        Text("This is my body, all of the details of my dream will be written here")
                    }
                }
            }
                    .navigationTitle("Dream Journal")
        }
    }
}

struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView()
    }
}
