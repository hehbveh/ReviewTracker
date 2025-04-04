import SwiftUI
import CoreData

struct ProductListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Product.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Product.orderDate, ascending: false)]) var products: FetchedResults<Product>

    var body: some View {
        NavigationView {
            List {
                ForEach(products) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(product.name ?? "Unknown Product")
                                    .font(.headline)
                                Text("$\(product.price, specifier: "%.2f")")
                                    .font(.subheadline)
                            }
                            Spacer()
                            VStack {
                                Image(systemName: product.reviewCompleted ? "checkmark.circle.fill" : "xmark.circle")
                                    .foregroundColor(product.reviewCompleted ? .green : .red)
                                Image(systemName: product.refundReceived ? "checkmark.circle.fill" : "xmark.circle")
                                    .foregroundColor(product.refundReceived ? .green : .red)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteProduct)
            }
            .navigationTitle("Products")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: AddProductView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }

    private func deleteProduct(offsets: IndexSet) {
        for index in offsets {
            let product = products[index]
            viewContext.delete(product)
        }
        try? viewContext.save()
    }
}
