//
//  ContentView.swift
//  NoteApp
//
//  Created by Oliver Andreasen on 13/02/2023.
//

import SwiftUI
import Firebase

// Define a struct called ContentView that conforms to the View protocol
struct ContentView: View {
    @ObservedObject var dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    // Implement the body property of the View protocol
    var body: some View {
        // Wrap the content in a NavigationView

        NavigationView {
            VStack {
                // Create a horizontal stack containin spacer and a button
                HStack {
                    // Add a spacer to push the button to the right side
                    Spacer()
                    // Define the action that should be taken when the button is tapped

                    Button(action: {
                        self.dataManager.Notes.append(Note(id: UUID().uuidString, title: "New Note", content: ""))
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
                List(dataManager.Notes) { note in
                    // Wrap each note in a NavigationLink
                    NavigationLink(destination: NoteEditorView(dataManager: self.dataManager, note: note)) {
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
    @ObservedObject var dataManager: DataManager
    // Create a State property called note that is a Note struct
    @State var note: Note
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
                if let index = self.dataManager.Notes.firstIndex(where: { $0.id == self.note.id }) {
                    self.dataManager.Notes[index] = self.note
                } else {
                    self.dataManager.Notes.append(self.note)
                }
                
                let db = Firestore.firestore()
                let reference = db.collection("Notes")
                
                reference.document(self.note.id).setData([
                    "id": self.note.id,
                    "title": self.note.title,
                    "content": self.note.content
                ])
            }) {
                Text("Save")
            })
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dataManager: DataManager()) // Create an instance of DataManager and pass it to ContentView
    }
}
