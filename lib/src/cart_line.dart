import 'package:equatable/equatable.dart';
import 'package:modular_cart_core/src/cart_selected_option.dart';
import 'package:modular_cart_core/src/product.dart';


/// A single line in the cart representing a selected product,
/// its selected options, and its quantity.
class CartLine extends Equatable {
  /// The selected product.
  final Product product;

  /// Selected options for this product.
  final List<CartSelectedOption> selectedOptions;

  /// Quantity of this product.
  final int quantity;

  CartLine({
    required this.product,
    List<CartSelectedOption> selectedOptions = const [],
    this.quantity = 1,
  }) : selectedOptions = List.unmodifiable(selectedOptions);

  @override
  List<Object?> get props => [product, selectedOptions];

  @override
  String toString() {
    final options = selectedOptions.isEmpty
        ? 'None'
        : selectedOptions.map((o) => o.option.id).join(', ');

    return 'CartLine(product: ${product.id}, quantity: $quantity, options: [$options])';
  }
}
