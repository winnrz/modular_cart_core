import 'package:equatable/equatable.dart';
import 'cart_product.dart';

class CartLine extends Equatable {
  final CartProduct product;
  final int quantity;

  CartLine({required this.product, this.quantity = 1});

  /// Total price of product + options
  double get totalPrice {
    final optionsTotal = product.selectedOptions.fold<double>(
        0, (sum, o) => sum + o.price * o.quantity);
    return (product.price * quantity) + optionsTotal;
  }

  /// Checks if another line is for the same product + options
  bool isSameAs(CartLine other) => product == other.product;

  @override
  List<Object?> get props => [product, quantity];

  @override
  String toString() {
    return '${product.name} x$quantity, total: \$${totalPrice.toStringAsFixed(2)}, options: ${product.selectedOptions.map((o) => o.name).join(', ')}';
  }
}
