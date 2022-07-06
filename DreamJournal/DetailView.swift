//
//  DetailView.swift
//  DreamJournal
//
//  Created by Laura Gongaware on 7/6/22.
//

import SwiftUI

struct DetailView: View {
    var entry: Entry?
    
    @State var entryTitleText: String = ""
    @State var entryBodyText: String = "Write the details of your dreams here..."
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Title")
                TextField("Placeholder", text: $entryTitleText)
                
            }.padding()
            
                VStack(alignment: .leading) {
                    HStack {
                        Text("Body")
                        Spacer()
                        Button {
                            entryBodyText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                        }
                    }
                    TextEditor(text: $entryBodyText)
                    
                }.padding()
                
                Spacer()
                
                Button {
                    
                    //ACTION
                    //STOPPING POINT
                    //SAVE OUR ENTRY
                        print(entryTitleText)
                        print(entryBodyText)
                    
                    } label: {
                        ZStack {
                    //very bottom
                            Rectangle().fill(.ultraThinMaterial)
                                .cornerRadius(12)
                    //very top
                            Text("Tap Me")
                }
            }.frame(width: UIScreen.main.bounds.width - 40, height: 55)
    
        }
        .navigationTitle("Detail View")
        .onAppear {
            if let entry = entry {
                entryTitleText = entry.title
                entryBodyText = entry.body
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        DetailView()
        }
    }
}
