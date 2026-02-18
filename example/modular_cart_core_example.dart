import 'package:modular_cart_core/modular_cart_core.dart';

void main() {
  // Products and options
  final rice = Product(id: 'rice', price: 10, metadata: {'name': 'Rice'});
  final eggs = ProductOption(id: 'eggs', price: 2, metadata: {'name': 'Eggs'});

  // CartLine: eggs x2 + eggs x3 will be merged internally to eggs x5
  final line = CartLine(
    product: rice,
    selectedOptions: [
      CartSelectedOption(option: eggs, quantity: 2),
      CartSelectedOption(option: eggs, quantity: 3),
    ],
    quantity: 1,
  );

  // Create cart and add line
  final cart = Cart().withAddedLine(line);

  // Debug print: includes options, quantities, and totals
  print(cart.getString());

  // Alternatively, simple total
  print('Total price: ${cart.totalPrice}');
}
