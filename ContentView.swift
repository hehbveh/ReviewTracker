import SwiftUI

struct ContentView: View {
    // Access the Core Data environment
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        ProductListView()
            .environment(\.managedObjectContext, viewContext) // Pass Core Data context
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
