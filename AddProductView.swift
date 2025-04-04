import SwiftUI

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @State private var name = ""
    @State private var price = ""
    @State private var orderDate = Date()

    var body: some View {
        Form {
            Section(header: Text("Product Info")) {
                TextField("Product Name", text: $name)
                TextField("Price", text: $price)
                    .keyboardType(.decimalPad)
                DatePicker("Order Date", selection: $orderDate, displayedComponents: .date)
            }
            Button("Save Product") {
                addProduct()
            }
        }
        .navigationTitle("Add Product")
    }

    private func addProduct() {
        let newProduct = Product(context: viewContext)
        newProduct.id = UUID()
        newProduct.name = name
        newProduct.price = Double(price) ?? 0.0
        newProduct.orderDate = orderDate
        newProduct.reviewCompleted = false
        newProduct.refundReceived = false

        try? viewContext.save()
        presentationMode.wrappedValue.dismiss()
    }
}
