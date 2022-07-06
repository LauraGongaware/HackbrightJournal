//
//  Entry.swift
//  DreamJournal
//
//  Created by Laura Gongaware on 7/6/22.
//

import Foundation

//struct is like a class but cannot inherit things from other structs, but Classes can
//structs have a memberwise initializer
//classes can have a deinitializer
//structs are value-types (classes are reference types)
//Structs are lightweight

struct Entry: Identifiable {
    var title: String
    var body: String
    //these are default values for properties we will never edit
    var date = Date()
    var id = UUID()
}
