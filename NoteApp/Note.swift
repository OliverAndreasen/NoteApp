//
//  Note.swift
//  NoteApp
//
//  Created by Oliver Andreasen on 22/02/2023.
//


import SwiftUI
// Define a struct called Note that conforms to the Identifiable protocol
struct Note: Identifiable {
    // A unique identifier for the note
    var id: String
    // The title of the note
    var title: String
    // The content of the note
    var content: String
}
