//
//  ContentView.swift
//  NoteApp
//
//  Created by Oliver Andreasen on 13/02/2023.
//

import SwiftUI

// Define a struct called ContentView that conforms to the View protocol
struct ContentView: View {
    // Create a State property called notes that is an array of Note structs
    @State public var notes = [Note]()
    
    // Implement the body property of the View protocol
    var body: some View {
        // Wrap the content in a NavigationView
        NavigationView {
            VStack {
                // Create a horizontal stack containing a spacer and a button
                HStack {
                    // Add a spacer to push the button to the right side
                    Spacer()
                    // Define the action that should be taken when the button is tapped
                    Button(action: {
                        // Append a new Note to the notes array
                        self.notes.append(Note(id: UUID(), title: "New Note", content: ""))
                    }) {
                        // Define the appearance of the button as a plus symbol
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                    }
                }
                // Add some padding to the horizontal stack
                .padding()
                // Create a list of notes using the notes array
                List(notes) {
                    note in
                    // Wrap each note in a NavigationLink
                    NavigationLink(destination: NoteEditorView(notes: self.$notes, note: note)) {
                        // Display the title of each note in the list
                        Text(note.title)
                    }
                }
            }
            // Set the title of the NavigationView
            .navigationBarTitle("Notes")
        }
    }
}

// Define a struct called NoteEditorView that conforms to the View protocol
struct NoteEditorView: View {
    // Create a Binding property called notes that is an array of Note structs
    @Binding public var notes: [Note]
    // Create a State property called note that is a Note struct
    @State public var note: Note
    
    // Implement the body property of the View protocol
    var body: some View {
        // Wrap the content in a NavigationView
        NavigationView {
            VStack {
                // Create a text field for the note title
                TextField("Note Title", text: $note.title)
                // Create a text field for the note content
                TextField("Note Content", text: $note.content)
            }
            // Add a save button to the right side of the navigation bar
            .navigationBarItems(trailing: Button(action: {
                // Find the index of the current note in the notes array
                let index = self.notes.firstIndex {
                    $0.id == self.note.id
                }
                // Update the current note in the notes array
                if let index = index {
                    self.notes[index] = self.note
                }
            }) {
                Text("Save")
            })
        }
    }
}

// Define a struct called Note that conforms to the Identifiable protocol
struct Note: Identifiable {
    // A unique identifier for the note
    var id: UUID
    // The title of the note
    var title: String
    // The content of the note
    var content: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
