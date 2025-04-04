import SwiftUI

struct ProductDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var product: Product

    var body: some View {
        Form {
            Section(header: Text("Product Info")) {
                Text(product.name ?? "Unknown Product")
                Text("$\(product.price, specifier: "%.2f")")
                Text("Ordered on: \(product.orderDate ?? Date(), formatter: dateFormatter)")
            }

            Section {
                Toggle("Review Completed", isOn: $product.reviewCompleted)
                Toggle("Refund Received", isOn: $product.refundReceived)
            }

            Button("Save Changes") {
                try? viewContext.save()
            }
        }
        .navigationTitle("Product Details")
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}
