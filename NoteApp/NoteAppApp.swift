//
//  NoteAppApp.swift
//  NoteApp
//
//  Created by Oliver Andreasen on 13/02/2023.
//

import SwiftUI
import Firebase

@main
struct NoteAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView(dataManager: DataManager())
        }
    }
}
