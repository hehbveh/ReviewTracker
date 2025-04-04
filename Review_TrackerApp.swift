//
//  Review_TrackerApp.swift
//  Review Tracker
//
//  Created by Almogio on 4/4/25.
//

import SwiftUI

@main
struct Review_TrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
